Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C8673B57
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjASOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjASOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:09:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE23A5AD;
        Thu, 19 Jan 2023 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674137324; x=1705673324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9CO79Dt3SpGze5n1rLabTDVRLOYS7VzEZiWcpNV7fdo=;
  b=Znj1UQa5yHg2ipTkKTphY+uzv04YxiorMP1FexEWAAzL4ax3q2eMl77y
   NBXhzHN/l4ImxhSJ7wGz9ZDB2zCjeiWekdrxkQGpQJzCAOTFW2RnhIABv
   gOdMIRvxA8AeKSlEJs3DsV4EnLcrwCvi/FY7liJT9Rg12sTxVKxCrYodx
   MvEq1xJFyGH1wcVE+47mX81hgH/Dc8+q6oGKzYKbqLAUe5Zqyk+Kf3Fmm
   QWjJzV2hATh/g8bNzYpkj3HV80oW1QCVPU6J3LdPx3qCoSrq4E7jp8GRS
   eVTVwIFrIcxfTQKwjFyyp+3KYn23zpo9LMNzdSCkq+bejPZ3gWOKcOHlP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="325335002"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="325335002"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="692432343"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="692432343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2023 06:06:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:06:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 06:06:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 06:06:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXUiLtL4ymknp40HQ4Us+tFXau1419APufD96KmHdC0pZgRwNE7jggYMXx0DcjwfPJL74AYc76op+kYsL+JE5xBCmyNjXNsNUJlY+QlurpAhwK4nICbZGpng/v24IsmSnk/0XLJXzgLH/AC0EpXALB+HKuxMeXtoS50WyuOEtxh79K52yCoK8I6Ag9yVcGUQFwaDVSM99vcdDB6D+D5JNQAdbf59ZZrj2owV5F3gey4OnD6jyx6ITEnUCDvYiUwCPJpIoqeZMlN5oA31hiUwOB+K5zT/uPx3VnmOpzipcFhEFbJ6PThLEIjcFvGV9eXDjKYEc4ItEHLuGDeqRcoZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1dUp9lvrZ4uHYAcSZ4h2m33330MI9WTsIDI40Au/vA=;
 b=W7SX2xiiv39ig5Yf68LHwUG86V9L+WVlGzn9VgY6X526RUg8GNNXfEu2JKH8rKKHdOSIrLf6/0izz1kuuc4FhPoXAoyXR376ZJv9JUNzujcBRfKf3qEE6+7UnIF9svlZPiTqhusv4hBwapXKRfz1pbmMLZ2JWV2Q3Cf7f1VDROwEU2CeIH37GbYmc8TG1lVYt7VLKcCyS175FIriOlIISQrsQ3fbAhuXeYdMKllY1OfDE9JTiEmG7VawkcZukttc5+g3sb4ejyfO4Z/rtftpAzY3oIs8oAwULNrwStZfaZj6K+G7IT1zmtUVef4s4Q+NHK9Nh3wbzesAi44weJgi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 14:06:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 14:06:32 +0000
Date:   Thu, 19 Jan 2023 22:06:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [tip:sched/core] [tracing, hardirq]  9aedeaed6f:
 WARNING:suspicious_RCU_usage
Message-ID: <202301192148.58ece903-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="xzgWY3NTp4GxXFlv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH8PR11MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e71189-36b8-41d9-d1fa-08dafa265dac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFRxbsjQlHKCqa3nI5RdNrHnUCSP1L5uu2YNAMuDKLJ6e72voPL10CM/IMkijWUpEStVbEhIoLzQLKxERnzpOFtXs4yA1NG2VLbuu6Lkrw04I4sYtjD9HXrSgViraoLAWzu/E+wVB8FzXOAHkfbpUVddqkPhkrKONFTLQXTX7xzRM1MgZmRWQOCdpbh+V5GVXrEDGCSuxdFuq8HczEtamBFE7GUaR9FnDVlT3p3KL5imDL/zhcnO4halV/bdrcUqfgt2ZZUXS45v5eZ+mh7vDzSPuka1pRYmgp6WWy5v5yvBu1dofiEQCXoTxV8rAlqUspqhsfnhKVGpR2kqT7VX/l9n76OjgbuHQYxiFb0hNmnxF1xwEFsqoI4fnokOBczBKtbg2H3+5getzZlGmsRzqdwyzXx6fnc0lfdTJxBr9FuEDuOCdfHLJR42R/TZFkfvPFoC/DoFUqzx/Mxk/JRCDwQvYOv6y5Sgwd/PNXQH+4c/oVeoGNwtu6RGile92qVq7Y6Ks67DEy0Mn/TttTmsTMTIZ7/9CgoUTaQ+zElDlPK/xNiBly3wM4hIWKzSJMoYxAn3YBSGlkVynNRCJJeDampJad/B4hZfehSUX1w6KlKYqn7Vr4p81FRCekIU2f1Ji37BjhIlXI/cQ+xjlu1zj7F1/hfNu+W6x2/0BfYSdn1v9HHslZxrvWr6QDt4kYv+nP2NrZZGlFp2r/kOHurdqUWX6J9Yv4cluF0rghx2w6vZ6vNW0en6hkPMFsOHtGaKclWsZkbF5psxlIqlSEN2zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(6506007)(235185007)(86362001)(66946007)(66476007)(30864003)(66556008)(5660300002)(2906002)(8936002)(82960400001)(38100700002)(316002)(6666004)(44144004)(45080400002)(36756003)(4326008)(6486002)(478600001)(966005)(21490400003)(6916009)(8676002)(41300700001)(26005)(1076003)(6512007)(186003)(83380400001)(2616005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G1x6sbEF5hMVJmFSCxyzwbyXGlKCvA2sID1iXFsIbZE5hBw3ojRRbIYxp369?=
 =?us-ascii?Q?POif2wKPnhPveWwrvwPkakKDHgx6xb+aBpvXU8YMFFXF4W7FKIuinZsMIwB5?=
 =?us-ascii?Q?wX/d/uDZlIgMp1kR+5pruY25Mv/4dD+HJo2/uJv+9HIF46sPC1jGvNyCMMtX?=
 =?us-ascii?Q?OJ0DK7uZ+EQQYzG4AbO8u2U8SDBab+Df9b4FgezY/wxb0PCI8t+s2ZDikYXJ?=
 =?us-ascii?Q?rl/EmdAnhJWJFBh2uKogAJRUCqTjdhWQCChUxAYbc38EtECK9iQygwfDgCOq?=
 =?us-ascii?Q?lpSdhhJWWVGxVdYogRBiLbtMfaY/Jh5tneOCG2Kj33N6LKMpxDZRqSI3bpw9?=
 =?us-ascii?Q?EifPeyqHuZrHl6qFK9l0fc4bEJ2aR7Tqo5Vy4NPPMd74V9/Uxqd9/juO+d+H?=
 =?us-ascii?Q?2cuNLbeUrK3BG5f93peyt/oRTXw5az4GhSEMKwTm7wqq8ckr4rDktk3XuasQ?=
 =?us-ascii?Q?btKqnyvPgW/O/+fllnCmm61TNNT4JVIjKmUNpLpuQkKXnxwhpkr4QtxKuhLx?=
 =?us-ascii?Q?nUrxc5tEmwnKgEl3ZLx5BUcfeogexk5vyxKELcmiDGbZZscfTWi2VzY38r7L?=
 =?us-ascii?Q?NvNYG3KnZa5rQUfwPodL+VPtyDiiav9Ugrc7C9n5+KfEKOlBjVuAp5UkGUry?=
 =?us-ascii?Q?H0FZG3VJzqnrQdW3AtTc9gMe4uaQ3yw1K7N6mY3SNEmFdTZ4oMX5wSxBsP4m?=
 =?us-ascii?Q?5Os//NbAI/BaGKUPKDZcJbipIAntkwzqinv/0hdAK5N2cFjAIEc+jcVCS7TE?=
 =?us-ascii?Q?Uuk2JCfYBT8GqkPziJ8DUcnEwarrdGN4bwWiLt57toOW91u4Z/CePPpKbcP8?=
 =?us-ascii?Q?KPBZGGpZz1lEUVPFI55cIo5XOCD+1eegL9CsB+XhnTHCVw9xd1dsz9C4yViS?=
 =?us-ascii?Q?WzYUevf/XAYMPiOuQH4mfYH2yRLfXjr0VVwCmy6/ks2v8oDnjZBQPe/pQCJX?=
 =?us-ascii?Q?uFvslhpvGHKtv2r89AP0Ks2VKPbT3l+I9w8WIJ7MCMkklDVI32QQiHT5tWTj?=
 =?us-ascii?Q?+QOPwwed2epNlOaW+7OqQv6lar5ty4ffIb5voVqgMsv7vBvUzBW3QPpaI1os?=
 =?us-ascii?Q?keFMvPRHpZbdWdjMG22twgfgnJ/y7WYl06uoyn3bYQI9181Sp43gCzuCh4uU?=
 =?us-ascii?Q?ZEZBiwS6eyyBMidnUWdpkFeVZkDPyhZbDlLai5qYkyW+d2QoTEgyIZ6HfG+w?=
 =?us-ascii?Q?5RaTr11kmZQMfwiW3NWWlQV906JL5DCrMpd2zGGLBn1ORoS7JGqyHiYS6cfz?=
 =?us-ascii?Q?fnT7XPDuUPsL8oY0G6/Kq+6G3ToUkOX8FmILvrJ79KTAHLWS+xAbkhx8FaWQ?=
 =?us-ascii?Q?9OzQQrWUGWmZCID/7mBzDBjUx9Ts5pG3o0sTuLEVBHUnbQhyq2XnqGwu6fb0?=
 =?us-ascii?Q?9J6aO2uXQMzEo9U62QwB2ahhYuuHR2aw7BPv8hgKQGYo8KMdVUixP3DMJugM?=
 =?us-ascii?Q?6RpBNt8EBvtUkNCHh+uGCsx9PXT3BmkOdBGxirExvEJa1b6SCCEXXzoTYbuf?=
 =?us-ascii?Q?5GquvJgq57Fi4zOI0aScb8jLELcdKTiTq6SEzPxDKKpI0mc9PGn13tT4HHGu?=
 =?us-ascii?Q?18GMiop6WBgNTsSgRNZZXxlCQuRaqqhFMr+2TLBMj/cmJan5dsP10NYUux9x?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e71189-36b8-41d9-d1fa-08dafa265dac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:06:32.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NGpiGXuOzU5NhAzhKGmcnpGTtrJeFw9Mvo4XC+cKIvjz9xnbNCwnNTvEv6Qhwz9EuswbpXDeIRm/yhyFqCDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--xzgWY3NTp4GxXFlv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:suspicious_RCU_usage due to commit (built with gcc-11):

commit: 9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91 ("tracing, hardirq: No moar _rcuidle() tracing")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

[test failed on linux-next/master f3381a7baf5ccbd091eb2c4fd2afd84266fcef24]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-d4cf28ee-1_20230110
with following parameters:

	group: ftrace

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202301192148.58ece903-oliver.sang@intel.com


[  137.120136][    T0] WARNING: suspicious RCU usage
[  137.120151][    T0] 6.2.0-rc1-00074-g9aedeaed6fc6 #1 Not tainted
[  137.120168][    T0] -----------------------------
[  137.120182][    T0] include/trace/events/lock.h:24 suspicious rcu_dereference_check() usage!
[  137.120198][    T0]
[  137.120198][    T0] other info that might help us debug this:
[  137.120198][    T0]
[  137.120213][    T0]
[  137.120213][    T0] rcu_scheduler_active = 2, debug_locks = 1
[  137.120228][    T0] RCU used illegally from extended quiescent state!
[  137.120242][    T0] no locks held by swapper/0/0.
[  137.120256][    T0]
[  137.120256][    T0] stack backtrace:
[  137.120273][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
[  137.120289][    T0] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[  137.120306][    T0] Call Trace:
[  137.120333][    T0]  <TASK>
[ 137.120420][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.120448][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 137.120517][ T0] lock_acquire.cold (include/trace/events/lock.h:24 kernel/locking/lockdep.c:5639) 
[ 137.120620][ T0] ? rcu_read_unlock (include/linux/rcupdate.h:793 (discriminator 5)) 
[  137.120734][    T0] ------------[ cut here ]------------
[ 137.120749][ T0] WARNING: CPU: 0 PID: 0 at kernel/module/internal.h:115 __module_address (kernel/module/main.c:3100 kernel/module/main.c:3081) 
[  137.120778][    T0] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs intel_rapl_msr blake2b_generic xor intel_rapl_common raid6_pq zstd_compress libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic crc64_rocksoft crc64 kvm sg irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 mei_wdt ipmi_devintf wmi_bmof i915 rapl ipmi_msghandler intel_cstate drm_buddy intel_gtt drm_display_helper i2c_i801 ttm ahci intel_uncore drm_kms_helper libahci mei_me serio_raw i2c_smbus syscopyarea sysfillrect libata ie31200_edac mei sysimgblt intel_pch_thermal video wmi intel_pmc_core acpi_pad tpm_infineon binfmt_misc drm fuse ip_tables [last unloaded: ftrace_direct]
[  137.121813][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
[  137.121830][    T0] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[ 137.121848][ T0] RIP: 0010:__module_address (kernel/module/main.c:3100 kernel/module/main.c:3081) 
[ 137.121877][ T0] Code: 01 00 00 48 01 da 48 39 d5 0f 82 69 ff ff ff 0f 0b be ff ff ff ff 48 c7 c7 48 56 9f 84 e8 e6 88 3b 02 85 c0 0f 85 d1 fe ff ff <0f> 0b e9 ca fe ff ff 48 83 c4 08 31 c0 5b 5d c3 48 c7 c7 cc 15 29
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 48 01             	add    %cl,0x1(%rax)
   5:	da 48 39             	fimull 0x39(%rax)
   8:	d5                   	(bad)  
   9:	0f 82 69 ff ff ff    	jb     0xffffffffffffff78
   f:	0f 0b                	ud2    
  11:	be ff ff ff ff       	mov    $0xffffffff,%esi
  16:	48 c7 c7 48 56 9f 84 	mov    $0xffffffff849f5648,%rdi
  1d:	e8 e6 88 3b 02       	callq  0x23b8908
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 d1 fe ff ff    	jne    0xfffffffffffffefb
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 ca fe ff ff       	jmpq   0xfffffffffffffefb
  31:	48 83 c4 08          	add    $0x8,%rsp
  35:	31 c0                	xor    %eax,%eax
  37:	5b                   	pop    %rbx
  38:	5d                   	pop    %rbp
  39:	c3                   	retq   
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	(bad)  
  3d:	cc                   	int3   
  3e:	15                   	.byte 0x15
  3f:	29                   	.byte 0x29

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 ca fe ff ff       	jmpq   0xfffffffffffffed1
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	31 c0                	xor    %eax,%eax
   d:	5b                   	pop    %rbx
   e:	5d                   	pop    %rbp
   f:	c3                   	retq   
  10:	48                   	rex.W
  11:	c7                   	.byte 0xc7
  12:	c7                   	(bad)  
  13:	cc                   	int3   
  14:	15                   	.byte 0x15
  15:	29                   	.byte 0x29
[  137.121895][    T0] RSP: 0018:ffffffff84406b40 EFLAGS: 00010046
[  137.121924][    T0] RAX: 0000000000000000 RBX: ffffffff84406d38 RCX: 0000000000000001
[  137.121939][    T0] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff849f5648
[  137.121954][    T0] RBP: ffffffffa03e6086 R08: 0000000000000000 R09: ffff88837f43f943
[  137.121969][    T0] R10: ffffed106fe87f28 R11: 0000000000000001 R12: ffffffff84406c30
[  137.121984][    T0] R13: ffffffff84406c10 R14: ffffffffa03e6086 R15: ffffffff84406c70
[  137.121999][    T0] FS:  0000000000000000(0000) GS:ffff88837f400000(0000) knlGS:0000000000000000
[  137.122014][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  137.122030][    T0] CR2: 0000000000451c00 CR3: 000000043ce2a003 CR4: 00000000003706f0
[  137.122046][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  137.122061][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  137.122078][    T0] Call Trace:
[  137.122100][    T0]  <TASK>
[  137.122173][    T0]
[  137.122187][    T0] =============================
[  137.122202][    T0] WARNING: suspicious RCU usage
[  137.122217][    T0] 6.2.0-rc1-00074-g9aedeaed6fc6 #1 Not tainted
[  137.122231][    T0] -----------------------------
[  137.122245][    T0] include/linux/rcupdate.h:765 rcu_read_lock() used illegally while idle!
[  137.122260][    T0]
[  137.122260][    T0] other info that might help us debug this:
[  137.122260][    T0]
[  137.122275][    T0]
[  137.122275][    T0] rcu_scheduler_active = 2, debug_locks = 1
[  137.122290][    T0] RCU used illegally from extended quiescent state!
[  137.122304][    T0] 1 lock held by swapper/0/0:
[ 137.122319][ T0] #0: ffffffff84925b40 (rcu_read_lock){....}-{1:2}, at: __bpf_address_lookup (kernel/bpf/core.c:690) 
[  137.122417][    T0]
[  137.122417][    T0] stack backtrace:
[  137.122433][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
[  137.122449][    T0] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[  137.122466][    T0] Call Trace:
[  137.122491][    T0]  <TASK>
[ 137.122577][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.122598][ T0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[  137.122630][    T0]  ? 0xffffffffa03e6085
[ 137.127567][ T0] __bpf_address_lookup (include/linux/rcupdate.h:765 kernel/bpf/core.c:694) 
[  137.127635][    T0]  ? 0xffffffffa03e6085
[ 137.127738][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.127759][ T0] kallsyms_lookup_buildid (include/linux/filter.h:1145 kernel/kallsyms.c:434) 
[  137.127883][    T0]  ? 0xffffffffa03e6086
[ 137.127932][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.127953][ T0] __sprint_symbol+0xaf/0x1c0 
[ 137.127981][ T0] ? prepare_ftrace_return (arch/x86/kernel/ftrace.c:653) 
[ 137.128042][ T0] ? kallsyms_lookup_buildid (kernel/kallsyms.c:517) 
[  137.128144][    T0]  ? 0xffffffffa03e6087
[ 137.128193][ T0] ? ftrace_return_to_handler (arch/x86/include/asm/current.h:41 kernel/trace/fgraph.c:257) 
[  137.128421][    T0]  ? 0xffffffffa03e6086
[ 137.128596][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.128617][ T0] symbol_string (lib/vsprintf.c:994) 
[ 137.128664][ T0] ? rb_handle_head_page (kernel/trace/ring_buffer.c:1411 kernel/trace/ring_buffer.c:1444 kernel/trace/ring_buffer.c:2650) 
[ 137.128724][ T0] ? ip6_addr_string (lib/vsprintf.c:982) 
[ 137.128855][ T0] ? __rb_reserve_next (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/trace/ring_buffer.c:2952 kernel/trace/ring_buffer.c:3709) 
[ 137.129239][ T0] ? __rb_reserve_next (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/trace/ring_buffer.c:2952 kernel/trace/ring_buffer.c:3709) 
[ 137.129575][ T0] ? ring_buffer_lock_reserve (kernel/trace/ring_buffer.c:3781 kernel/trace/ring_buffer.c:3838) 
[ 137.129861][ T0] ? __rb_reserve_next (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/trace/ring_buffer.c:2952 kernel/trace/ring_buffer.c:3709) 
[ 137.130068][ T0] ? __rb_reserve_next (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/trace/ring_buffer.c:2952 kernel/trace/ring_buffer.c:3709) 
[ 137.130331][ T0] ? __rb_reserve_next (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/trace/ring_buffer.c:2952 kernel/trace/ring_buffer.c:3709) 
[ 137.130625][ T0] ? move_right (lib/vsprintf.c:617) 
[  137.130855][    T0]  ? 0xffffffffa03e6086
[ 137.130905][ T0] pointer (lib/vsprintf.c:2394) 
[ 137.131025][ T0] ? resource_string+0x1590/0x1590 
[ 137.131106][ T0] ? rb_commit (arch/x86/include/asm/atomic64_64.h:22 include/linux/atomic/atomic-long.h:29 include/linux/atomic/atomic-instrumented.h:1266 kernel/trace/ring_buffer.c:3181 kernel/trace/ring_buffer.c:3204) 
[ 137.131331][ T0] vsnprintf (lib/vsprintf.c:2802) 
[ 137.131521][ T0] ? pointer (lib/vsprintf.c:2727) 
[ 137.131617][ T0] ? __trace_graph_entry (kernel/trace/trace_functions_graph.c:113) 
[ 137.131820][ T0] vprintk_store (kernel/printk/printk.c:2241) 
[ 137.131956][ T0] ? ftrace_graph_stop (kernel/trace/fgraph.c:124) 
[ 137.132016][ T0] ? printk_sprint (kernel/printk/printk.c:2206) 
[ 137.132040][ T0] ? vprintk (kernel/printk/printk_safe.c:30) 
[ 137.132188][ T0] ? vprintk_store (kernel/printk/printk.c:2206) 
[ 137.132266][ T0] ? prepare_ftrace_return (arch/x86/kernel/ftrace.c:653) 
[  137.132384][    T0]  ? 0xffffffffa03e6086
[  137.132438][    T0]  ? 0xffffffffa03e6087
[  137.132853][    T0]  ? 0xffffffffa03e6086
[ 137.132884][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.132905][ T0] vprintk (kernel/printk/printk_safe.c:44 kernel/printk/printk_safe.c:29) 
[ 137.132950][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.132971][ T0] _printk (kernel/printk/printk.c:2373) 
[ 137.133034][ T0] ? record_print_text.cold (kernel/printk/printk.c:2373) 
[  137.133242][    T0]  ? 0xffffffffa03e6086
[  137.133368][    T0]  ? 0xffffffffa03e6086
[ 137.133471][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.133492][ T0] show_trace_log_lvl (arch/x86/kernel/dumpstack.c:284) 
[  137.133561][    T0]  ? 0xffffffffa03e6086
[  137.133886][    T0]  ? 0xffffffffa03e6086
[ 137.133916][ T0] ? module_address_lookup (kernel/module/kallsyms.c:339) 
[ 137.134048][ T0] ? __module_address (kernel/module/main.c:3100 kernel/module/main.c:3081) 
[ 137.134107][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.134128][ T0] __warn (kernel/panic.c:664) 
[ 137.134210][ T0] ? __module_address (kernel/module/main.c:3100 kernel/module/main.c:3081) 
[ 137.134287][ T0] ? ftrace_regs_caller_end (arch/x86/kernel/ftrace_64.S:345) 
[ 137.134308][ T0] report_bug (lib/bug.c:200) 
[ 137.134480][ T0] handle_bug (arch/x86/kernel/traps.c:324) 
[ 137.134525][ T0] exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
[ 137.134589][ T0] asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 137.134615][ T0] RIP: 0010:__module_address (kernel/module/main.c:3100 kernel/module/main.c:3081) 
[ 137.134622][ T0] Code: 01 00 00 48 01 da 48 39 d5 0f 82 69 ff ff ff 0f 0b be ff ff ff ff 48 c7 c7 48 56 9f 84 e8 e6 88 3b 02 85 c0 0f 85 d1 fe ff ff <0f> 0b e9 ca fe ff ff 48 83 c4 08 31 c0 5b 5d c3 48 c7 c7 cc 15 29
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 48 01             	add    %cl,0x1(%rax)
   5:	da 48 39             	fimull 0x39(%rax)
   8:	d5                   	(bad)  
   9:	0f 82 69 ff ff ff    	jb     0xffffffffffffff78
   f:	0f 0b                	ud2    
  11:	be ff ff ff ff       	mov    $0xffffffff,%esi
  16:	48 c7 c7 48 56 9f 84 	mov    $0xffffffff849f5648,%rdi
  1d:	e8 e6 88 3b 02       	callq  0x23b8908
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 d1 fe ff ff    	jne    0xfffffffffffffefb
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 ca fe ff ff       	jmpq   0xfffffffffffffefb
  31:	48 83 c4 08          	add    $0x8,%rsp
  35:	31 c0                	xor    %eax,%eax
  37:	5b                   	pop    %rbx
  38:	5d                   	pop    %rbp
  39:	c3                   	retq   
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	c7                   	(bad)  
  3d:	cc                   	int3   
  3e:	15                   	.byte 0x15
  3f:	29                   	.byte 0x29

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 ca fe ff ff       	jmpq   0xfffffffffffffed1
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	31 c0                	xor    %eax,%eax
   d:	5b                   	pop    %rbx
   e:	5d                   	pop    %rbp
   f:	c3                   	retq   
  10:	48                   	rex.W
  11:	c7                   	.byte 0xc7
  12:	c7                   	(bad)  
  13:	cc                   	int3   
  14:	15                   	.byte 0x15
  15:	29                   	.byte 0x29


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--xzgWY3NTp4GxXFlv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc1-00074-g9aedeaed6fc6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
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
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
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
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
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
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
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
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
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
CONFIG_EXPERT=y
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
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

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
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
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
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
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

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
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
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
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
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
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
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
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
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
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
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
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
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

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
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
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
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
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
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
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
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
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
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

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
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
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
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
# CONFIG_BPF_LIRC_MODE2 is not set
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
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

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
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
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

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

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
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
# end of Enable LiteX SoC Builder specific drivers

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
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
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
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
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
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
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
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
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
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
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
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
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
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
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
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
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
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
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
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
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--xzgWY3NTp4GxXFlv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-skl-d06'
	export tbox_group='lkp-skl-d06'
	export submit_id='63c8a20d0b9a933bc34d1bf2'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml'
	export id='6f2b137910a5ff75d61a14f37c48de4e2bbcbea6'
	export queuer_version='/lkp/xsang/.src-20230119-093835'
	export model='Skylake'
	export nr_cpu=4
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1'
	export brand='Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz'
	export commit='9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export need_kconfig=\{\"FTRACE\"\=\>\"y\"\}'
'\{\"KPROBES\"\=\>\"y\"\}'
'\{\"FUNCTION_PROFILER\"\=\>\"y\"\}'
'\{\"TRACER_SNAPSHOT\"\=\>\"y\"\}'
'\{\"STACK_TRACER\"\=\>\"y\"\}'
'\{\"HIST_TRIGGERS\"\=\>\"y\"\}'
'\{\"SCHED_TRACER\"\=\>\"y\"\}'
'\{\"IRQSOFF_TRACER\"\=\>\"y\"\}'
'\{\"PREEMPTIRQ_DELAY_TEST\"\=\>\"m\"\}'
'\{\"MODULES\"\=\>\"y\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"SAMPLES\"\=\>\"y\"\}'
'\{\"SAMPLE_FTRACE_DIRECT\"\=\>\"m\"\}'
'\{\"SAMPLE_TRACE_PRINTK\"\=\>\"m\"\}'
'\{\"KALLSYMS_ALL\"\=\>\"y\"\}
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-01-19 09:51:10 +0800'
	export _id='63c8a2100b9a933bc34d1bf3'
	export _rt='/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='2cbef8bbf45812df036885934eb6e2782a37181c'
	export base_commit='5dc4c995db9eb45f6373a956eb1f69460e69e6d4'
	export branch='tip/sched/core'
	export result_root='/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6
branch=tip/sched/core
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91
kvm-intel.unrestricted_guest=0
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.2.0-rc4'
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6'
	export dequeue_time='2023-01-19 11:21:41 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='ftrace' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='ftrace' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--xzgWY3NTp4GxXFlv
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAEWVo=

--xzgWY3NTp4GxXFlv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.2.0-rc1-00074-g9aedeaed6fc6 (kbuild@89f585d3a0a5) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39.90.20221231) #1 SMP Wed Jan 18 19:47:08 CST 2023
Command line: ip=::::lkp-skl-d06::dhcp root=/dev/ram0 RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6 branch=tip/sched/core job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91 kvm-intel.unrestricted_guest=0 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_cou
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
signal: max sigframe size: 2032
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000400-0x0000000000091bff] usable
BIOS-e820: [mem 0x0000000000091c00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000b30fafff] usable
BIOS-e820: [mem 0x00000000b30fb000-0x00000000b3c7efff] reserved
BIOS-e820: [mem 0x00000000b3c7f000-0x00000000b3e7efff] ACPI NVS
BIOS-e820: [mem 0x00000000b3e7f000-0x00000000b3efefff] ACPI data
BIOS-e820: [mem 0x00000000b3eff000-0x00000000b3efffff] usable
BIOS-e820: [mem 0x00000000b3f00000-0x00000000be7fffff] reserved
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
BIOS-e820: [mem 0x00000000fed84000-0x00000000fed84fff] reserved
BIOS-e820: [mem 0x00000000fedb0000-0x00000000fedbffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff700000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043f7fffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.7 present.
DMI: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
tsc: Detected 3300.000 MHz processor
tsc: Detected 3299.994 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x43f800 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xb3f00 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
Scan for SMP in [mem 0x00091c00-0x00091fff]
Using GB pages for direct mapping
RAMDISK: [mem 0x40e3fe000-0x4399fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000FBE30 000024 (v02 HPQOEM)
ACPI: XSDT 0x00000000B3EFD0E8 0000AC (v01 HPQOEM SLIC-WKS 00000000      01000013)
ACPI: FACP 0x00000000B3EF1000 0000F4 (v05 HPQOEM SLIC-WKS 00000000 HP   00000001)
ACPI: DSDT 0x00000000B3ECD000 0209E1 (v02 HPQOEM 8183     00000000 INTL 20121018)
ACPI: FACS 0x00000000B3E5A000 000040
ACPI: SSDT 0x00000000B3EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
ACPI: TCPA 0x00000000B3EFB000 000032 (v02 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EFA000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
ACPI: UEFI 0x00000000B3E6A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EF4000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
ACPI: SSDT 0x00000000B3EF3000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
ACPI: WSMT 0x00000000B3EF2000 000028 (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: HPET 0x00000000B3EF0000 000038 (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: APIC 0x00000000B3EEF000 0000BC (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: MCFG 0x00000000B3EEE000 00003C (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: SSDT 0x00000000B3ECC000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECB000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECA000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
ACPI: ASF! 0x00000000B3EC9000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
ACPI: FPDT 0x00000000B3EC8000 000044 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: BGRT 0x00000000B3EC7000 000038 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: Reserving FACP table memory at [mem 0xb3ef1000-0xb3ef10f3]
ACPI: Reserving DSDT table memory at [mem 0xb3ecd000-0xb3eed9e0]
ACPI: Reserving FACS table memory at [mem 0xb3e5a000-0xb3e5a03f]
ACPI: Reserving SSDT table memory at [mem 0xb3efc000-0xb3efc107]
ACPI: Reserving TCPA table memory at [mem 0xb3efb000-0xb3efb031]
ACPI: Reserving SSDT table memory at [mem 0xb3efa000-0xb3efa3b7]
ACPI: Reserving UEFI table memory at [mem 0xb3e6a000-0xb3e6a041]
ACPI: Reserving SSDT table memory at [mem 0xb3ef4000-0xb3ef91f9]
ACPI: Reserving SSDT table memory at [mem 0xb3ef3000-0xb3ef35b0]
ACPI: Reserving WSMT table memory at [mem 0xb3ef2000-0xb3ef2027]
ACPI: Reserving HPET table memory at [mem 0xb3ef0000-0xb3ef0037]
ACPI: Reserving APIC table memory at [mem 0xb3eef000-0xb3eef0bb]
ACPI: Reserving MCFG table memory at [mem 0xb3eee000-0xb3eee03b]
ACPI: Reserving SSDT table memory at [mem 0xb3ecc000-0xb3ecc199]
ACPI: Reserving SSDT table memory at [mem 0xb3ecb000-0xb3ecb728]
ACPI: Reserving SSDT table memory at [mem 0xb3eca000-0xb3ecae72]
ACPI: Reserving ASF! table memory at [mem 0xb3ec9000-0xb3ec90a4]
ACPI: Reserving FPDT table memory at [mem 0xb3ec8000-0xb3ec8043]
ACPI: Reserving BGRT table memory at [mem 0xb3ec7000-0xb3ec7037]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000043f7fffff]
NODE_DATA(0) allocated [mem 0x43f7d5000-0x43f7fffff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043f7fffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x0000000000090fff]
node   0: [mem 0x0000000000100000-0x00000000b30fafff]
node   0: [mem 0x00000000b3eff000-0x00000000b3efffff]
node   0: [mem 0x0000000100000000-0x000000043f7fffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000043f7fffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 111 pages in unavailable ranges
On node 0, zone DMA32: 3588 pages in unavailable ranges
On node 0, zone Normal: 16640 pages in unavailable ranges
On node 0, zone Normal: 2048 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0xb6800000-0xbe7fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 4 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x00091000-0x00091fff]
PM: hibernation: Registered nosave memory: [mem 0x00092000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xb30fb000-0xb3c7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3c7f000-0xb3e7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3e7f000-0xb3efefff]
PM: hibernation: Registered nosave memory: [mem 0xb3f00000-0xbe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xbe800000-0xdfffffff]
PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfcffffff]
PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xfe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xfe800000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed0ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
PM: hibernation: Registered nosave memory: [mem 0xfed1a000-0xfed83fff]
PM: hibernation: Registered nosave memory: [mem 0xfed84000-0xfed84fff]
PM: hibernation: Registered nosave memory: [mem 0xfed85000-0xfedaffff]
PM: hibernation: Registered nosave memory: [mem 0xfedb0000-0xfedbffff]
PM: hibernation: Registered nosave memory: [mem 0xfedc0000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff6fffff]
PM: hibernation: Registered nosave memory: [mem 0xff700000-0xffffffff]
[mem 0xbe800000-0xdfffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 70 pages/cpu s247648 r8192 d30880 u524288
pcpu-alloc: s247648 r8192 d30880 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 4074328
Policy zone: Normal
Kernel command line: ip=::::lkp-skl-d06::dhcp root=/dev/ram0 RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6 branch=tip/sched/core job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91 kvm-intel.unrestricted_guest=0 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.mi
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6 branch=tip/sched/core job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
random: crng init done
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:on, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 4.
Memory: 2998000K/16556592K available (43008K kernel code, 14943K rwdata, 9424K rodata, 3076K init, 15120K bss, 3247744K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 48452 entries in 190 pages
ftrace: allocated 190 pages with 6 groups
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
calling  con_init+0x0/0x5a2 @ 0
Console: colour VGA+ 80x25
printk: console [tty0] enabled
initcall con_init+0x0/0x5a2 returned 0 after 0 usecs
calling  hvc_console_init+0x0/0x18 @ 0
initcall hvc_console_init+0x0/0x18 returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x2b @ 0
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x2b returned 0 after 0 usecs
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 6365 kB
memory used for stack traces: 4224 kB
per task-struct memory footprint: 1920 bytes
ACPI: Core revision 20221020
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
APIC: Switch to symmetric I/O mode setup
x2apic: IRQ remapping doesn't support X2APIC mode
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
apic 2 pin 62 not connected
apic 2 pin 63 not connected
apic 2 pin 64 not connected
apic 2 pin 65 not connected
apic 2 pin 66 not connected
apic 2 pin 67 not connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2f9146cb80a, max_idle_ns: 440795296911 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6599.98 BogoMIPS (lpj=3299994)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=capability,landlock,yama,integrity
landlock: Up and running.
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
RETBleed: Mitigation: IBRS
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
TAA: Mitigation: TSX disabled
MMIO Stale Data: Mitigation: Clear CPU buffers
SRBDS: Mitigation: Microcode
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (family: 0x6, model: 0x5e, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 2 and lim to 1.
cblist_init_generic: Setting shift to 2 and lim to 1.
Running RCU-tasks wait API self tests
calling  init_hw_perf_events+0x0/0x595 @ 1
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      8
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             00000007000000ff
Callback from call_rcu_tasks_trace() invoked.
initcall init_hw_perf_events+0x0/0x595 returned 0 after 9000 usecs
calling  do_init_real_mode+0x0/0x12 @ 1
initcall do_init_real_mode+0x0/0x12 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x17 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x17 returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0x5e @ 1
Estimated ratio of average max frequency by base frequency (times 1024): 1055
initcall bp_init_aperfmperf+0x0/0x5e returned 0 after 1000 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x1a @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x1a returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xe1 @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xe1 returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x3d @ 1
initcall spawn_ksoftirqd+0x0/0x3d returned 0 after 0 usecs
calling  migration_init+0x0/0xd5 @ 1
initcall migration_init+0x0/0xd5 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x7c @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x7c returned 0 after 2000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x35d @ 1
initcall rcu_spawn_gp_kthread+0x0/0x35d returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x1f @ 1
initcall check_cpu_stall_init+0x0/0x1f returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x26 @ 1
initcall rcu_sysrq_init+0x0/0x26 returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0x13 @ 1
initcall trace_init_flags_sys_enter+0x0/0x13 returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0x13 @ 1
initcall trace_init_flags_sys_exit+0x0/0x13 returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x166 @ 1
initcall cpu_stop_init+0x0/0x166 returned 0 after 0 usecs
calling  init_kprobes+0x0/0x25d @ 1
initcall init_kprobes+0x0/0x25d returned 0 after 1000 usecs
calling  init_events+0x0/0xc6 @ 1
initcall init_events+0x0/0xc6 returned 0 after 0 usecs
calling  init_trace_printk+0x0/0x10 @ 1
initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x23 @ 1
initcall event_trace_enable_again+0x0/0x23 returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0x7 @ 1
initcall irq_work_init_threads+0x0/0x7 returned 0 after 0 usecs
calling  static_call_init+0x0/0x93 @ 1
initcall static_call_init+0x0/0x93 returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x15 @ 1
initcall jump_label_init_module+0x0/0x15 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0xbf @ 1
initcall init_zero_pfn+0x0/0xbf returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x26 @ 1
initcall init_fs_inode_sysctls+0x0/0x26 returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x26 @ 1
initcall init_fs_locks_sysctls+0x0/0x26 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x3bf @ 1
initcall dynamic_debug_init+0x0/0x3bf returned 0 after 0 usecs
calling  efi_memreserve_root_init+0x0/0x2a @ 1
initcall efi_memreserve_root_init+0x0/0x2a returned 0 after 0 usecs
calling  efi_earlycon_remap_fb+0x0/0xf8 @ 1
initcall efi_earlycon_remap_fb+0x0/0xf8 returned 0 after 0 usecs
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 4 processors activated (26399.95 BogoMIPS)
Callback from call_rcu_tasks_rude() invoked.
node 0 deferred pages initialised in 54ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
calling  bpf_jit_charge_init+0x0/0x40 @ 1
initcall bpf_jit_charge_init+0x0/0x40 returned 0 after 0 usecs
calling  ipc_ns_init+0x0/0x11e @ 1
initcall ipc_ns_init+0x0/0x11e returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x1a @ 1
initcall init_mmap_min_addr+0x0/0x1a returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x49 @ 1
initcall pci_realloc_setup_params+0x0/0x49 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x46 @ 1
initcall inet_frag_wq_init+0x0/0x46 returned 0 after 0 usecs
calling  e820__register_nvs_regions+0x0/0x150 @ 1
ACPI: PM: Registering ACPI NVS region [mem 0xb3c7f000-0xb3e7efff] (2097152 bytes)
initcall e820__register_nvs_regions+0x0/0x150 returned 0 after 2000 usecs
calling  cpufreq_register_tsc_scaling+0x0/0x7a @ 1
initcall cpufreq_register_tsc_scaling+0x0/0x7a returned 0 after 0 usecs
calling  cache_ap_register+0x0/0x2c @ 1
initcall cache_ap_register+0x0/0x2c returned 0 after 0 usecs
calling  reboot_init+0x0/0xa9 @ 1
initcall reboot_init+0x0/0xa9 returned 0 after 0 usecs
calling  init_lapic_sysfs+0x0/0x4b @ 1
initcall init_lapic_sysfs+0x0/0x4b returned 0 after 0 usecs
calling  alloc_frozen_cpus+0x0/0x25 @ 1
initcall alloc_frozen_cpus+0x0/0x25 returned 0 after 0 usecs
calling  cpu_hotplug_pm_sync_init+0x0/0x18 @ 1
initcall cpu_hotplug_pm_sync_init+0x0/0x18 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x2f @ 1
initcall wq_sysfs_init+0x0/0x2f returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x9d @ 1
initcall ksysfs_init+0x0/0x9d returned 0 after 0 usecs
calling  schedutil_gov_init+0x0/0x15 @ 1
initcall schedutil_gov_init+0x0/0x15 returned 0 after 0 usecs
calling  pm_init+0x0/0xb4 @ 1
initcall pm_init+0x0/0xb4 returned 0 after 0 usecs
calling  pm_disk_init+0x0/0x42 @ 1
initcall pm_disk_init+0x0/0x42 returned 0 after 0 usecs
calling  swsusp_header_init+0x0/0x35 @ 1
initcall swsusp_header_init+0x0/0x35 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x63 @ 1
initcall rcu_set_runtime_mode+0x0/0x63 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x1c @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 1000 usecs
calling  futex_init+0x0/0x1f9 @ 1
futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
initcall futex_init+0x0/0x1f9 returned 0 after 1000 usecs
calling  cgroup_wq_init+0x0/0x2d @ 1
initcall cgroup_wq_init+0x0/0x2d returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x2d @ 1
initcall cgroup1_wq_init+0x0/0x2d returned 0 after 0 usecs
calling  ftrace_mod_cmd_init+0x0/0x10 @ 1
initcall ftrace_mod_cmd_init+0x0/0x10 returned 0 after 0 usecs
calling  init_irqsoff_tracer+0x0/0x13 @ 1
initcall init_irqsoff_tracer+0x0/0x13 returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x31 @ 1
initcall init_wakeup_tracer+0x0/0x31 returned 0 after 0 usecs
calling  init_graph_trace+0x0/0x95 @ 1
initcall init_graph_trace+0x0/0x95 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x2b @ 1
initcall trace_events_eprobe_init_early+0x0/0x2b returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x2b @ 1
initcall trace_events_synth_init_early+0x0/0x2b returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0x2a @ 1
initcall init_kprobe_trace_early+0x0/0x2a returned 0 after 0 usecs
calling  kasan_memhotplug_init+0x0/0x13 @ 1
initcall kasan_memhotplug_init+0x0/0x13 returned 0 after 0 usecs
calling  memory_failure_init+0x0/0x273 @ 1
initcall memory_failure_init+0x0/0x273 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x8b @ 1
initcall fsnotify_init+0x0/0x8b returned 0 after 0 usecs
calling  filelock_init+0x0/0x174 @ 1
initcall filelock_init+0x0/0x174 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x1a @ 1
initcall init_script_binfmt+0x0/0x1a returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x1a @ 1
initcall init_elf_binfmt+0x0/0x1a returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x1a @ 1
initcall init_compat_elf_binfmt+0x0/0x1a returned 0 after 0 usecs
calling  configfs_init+0x0/0xee @ 1
initcall configfs_init+0x0/0xee returned 0 after 0 usecs
calling  debugfs_init+0x0/0xb7 @ 1
initcall debugfs_init+0x0/0xb7 returned 0 after 0 usecs
calling  tracefs_init+0x0/0x67 @ 1
initcall tracefs_init+0x0/0x67 returned 0 after 0 usecs
calling  securityfs_init+0x0/0xbe @ 1
initcall securityfs_init+0x0/0xbe returned 0 after 0 usecs
calling  pinctrl_init+0x0/0xb2 @ 1
pinctrl core: initialized pinctrl subsystem
initcall pinctrl_init+0x0/0xb2 returned 0 after 6000 usecs
calling  gpiolib_dev_init+0x0/0x124 @ 1
initcall gpiolib_dev_init+0x0/0x124 returned 0 after 0 usecs
calling  virtio_init+0x0/0x20 @ 1
initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
calling  iommu_init+0x0/0x55 @ 1
initcall iommu_init+0x0/0x55 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x21 @ 1
initcall component_debug_init+0x0/0x21 returned 0 after 0 usecs
calling  cpufreq_core_init+0x0/0xce @ 1
initcall cpufreq_core_init+0x0/0xce returned 0 after 0 usecs
calling  cpufreq_gov_performance_init+0x0/0x15 @ 1
initcall cpufreq_gov_performance_init+0x0/0x15 returned 0 after 0 usecs
calling  cpufreq_gov_powersave_init+0x0/0x15 @ 1
initcall cpufreq_gov_powersave_init+0x0/0x15 returned 0 after 0 usecs
calling  cpufreq_gov_userspace_init+0x0/0x15 @ 1
initcall cpufreq_gov_userspace_init+0x0/0x15 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x15 @ 1
initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x15 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x15 @ 1
initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x15 returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x4a @ 1
initcall cpuidle_init+0x0/0x4a returned 0 after 0 usecs
calling  sock_init+0x0/0xa3 @ 1
initcall sock_init+0x0/0xa3 returned 0 after 2000 usecs
calling  net_inuse_init+0x0/0x2d @ 1
initcall net_inuse_init+0x0/0x2d returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x2d @ 1
initcall net_defaults_init+0x0/0x2d returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x54 @ 1
initcall init_default_flow_dissectors+0x0/0x54 returned 0 after 0 usecs
calling  netpoll_init+0x0/0x18 @ 1
initcall netpoll_init+0x0/0x18 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x269 @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x269 returned 0 after 7000 usecs
calling  genl_init+0x0/0x47 @ 1
initcall genl_init+0x0/0x47 returned 0 after 1000 usecs
calling  bsp_pm_check_init+0x0/0x18 @ 1
initcall bsp_pm_check_init+0x0/0x18 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xbe @ 1
initcall irq_sysfs_init+0x0/0xbe returned 0 after 1000 usecs
calling  audit_init+0x0/0x18e @ 1
audit: initializing netlink subsys (disabled)
initcall audit_init+0x0/0x18e returned 0 after 7000 usecs
audit: type=2000 audit(1674098476.673:1): state=initialized audit_enabled=0 res=1
calling  release_early_probes+0x0/0x5d @ 1
initcall release_early_probes+0x0/0x5d returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x71 @ 1
initcall bdi_class_init+0x0/0x71 returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x53 @ 1
initcall mm_sysfs_init+0x0/0x53 returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x2a @ 1
initcall init_per_zone_wmark_min+0x0/0x2a returned 0 after 0 usecs
calling  mpi_init+0x0/0xea @ 1
initcall mpi_init+0x0/0xea returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x11d @ 1
initcall gpiolib_sysfs_init+0x0/0x11d returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x11a @ 1
initcall acpi_gpio_setup_params+0x0/0x11a returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x1c @ 1
initcall pcibus_class_init+0x0/0x1c returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x26 @ 1
initcall pci_driver_init+0x0/0x26 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0xf2 @ 1
initcall backlight_class_init+0x0/0xf2 returned 0 after 0 usecs
calling  tty_class_init+0x0/0x5c @ 1
initcall tty_class_init+0x0/0x5c returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0x1a4 @ 1
initcall vtconsole_class_init+0x0/0x1a4 returned 0 after 0 usecs
calling  iommu_dev_init+0x0/0x1c @ 1
initcall iommu_dev_init+0x0/0x1c returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x15 @ 1
initcall mipi_dsi_bus_init+0x0/0x15 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x4a @ 1
initcall devlink_class_init+0x0/0x4a returned 0 after 0 usecs
calling  software_node_init+0x0/0x55 @ 1
initcall software_node_init+0x0/0x55 returned 0 after 0 usecs
calling  wakeup_sources_debugfs_init+0x0/0x28 @ 1
initcall wakeup_sources_debugfs_init+0x0/0x28 returned 0 after 0 usecs
calling  wakeup_sources_sysfs_init+0x0/0x31 @ 1
initcall wakeup_sources_sysfs_init+0x0/0x31 returned 0 after 0 usecs
calling  regmap_initcall+0x0/0x11 @ 1
initcall regmap_initcall+0x0/0x11 returned 0 after 0 usecs
calling  spi_init+0x0/0xcb @ 1
initcall spi_init+0x0/0xcb returned 0 after 0 usecs
calling  i2c_init+0x0/0xec @ 1
initcall i2c_init+0x0/0xec returned 0 after 0 usecs
calling  thermal_init+0x0/0x1ae @ 1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x1ae returned 0 after 21000 usecs
calling  init_menu+0x0/0x15 @ 1
cpuidle: using governor menu
initcall init_menu+0x0/0x15 returned 0 after 5000 usecs
calling  pcc_init+0x0/0xcb @ 1
initcall pcc_init+0x0/0xcb returned -19 after 0 usecs
calling  kobject_uevent_init+0x0/0x10 @ 1
initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
calling  bts_init+0x0/0x134 @ 1
initcall bts_init+0x0/0x134 returned -19 after 0 usecs
calling  pt_init+0x0/0x2c1 @ 1
initcall pt_init+0x0/0x2c1 returned 0 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x96 @ 1
initcall boot_params_ksysfs_init+0x0/0x96 returned 0 after 0 usecs
calling  sbf_init+0x0/0xd3 @ 1
initcall sbf_init+0x0/0xd3 returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x4d9 @ 1
initcall arch_kdebugfs_init+0x0/0x4d9 returned 0 after 0 usecs
calling  xfd_update_static_branch+0x0/0x48 @ 1
initcall xfd_update_static_branch+0x0/0x48 returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0xa9 @ 1
initcall intel_pconfig_init+0x0/0xa9 returned 0 after 0 usecs
calling  mtrr_if_init+0x0/0xaf @ 1
initcall mtrr_if_init+0x0/0xaf returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x36 @ 1
initcall activate_jump_labels+0x0/0x36 returned 0 after 0 usecs
calling  init_s4_sigcheck+0x0/0x90 @ 1
initcall init_s4_sigcheck+0x0/0x90 returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x66 @ 1
initcall ffh_cstate_init+0x0/0x66 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x1ca @ 1
initcall kvm_alloc_cpumask+0x0/0x1ca returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x36 @ 1
initcall activate_jump_labels+0x0/0x36 returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x4a @ 1
initcall gigantic_pages_init+0x0/0x4a returned 0 after 0 usecs
calling  uv_rtc_setup_clock+0x0/0x27a @ 1
initcall uv_rtc_setup_clock+0x0/0x27a returned -19 after 0 usecs
calling  kcmp_cookies_init+0x0/0xa6 @ 1
initcall kcmp_cookies_init+0x0/0xa6 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x15 @ 1
initcall cryptomgr_init+0x0/0x15 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x14d @ 1
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
initcall acpi_pci_init+0x0/0x14d returned 0 after 16000 usecs
calling  dma_channel_table_init+0x0/0x17c @ 1
initcall dma_channel_table_init+0x0/0x17c returned 0 after 0 usecs
calling  dma_bus_init+0x0/0x20f @ 1
initcall dma_bus_init+0x0/0x20f returned 0 after 0 usecs
calling  iommu_dma_init+0x0/0x50 @ 1
initcall iommu_dma_init+0x0/0x50 returned 0 after 0 usecs
calling  dmi_id_init+0x0/0x16c @ 1
initcall dmi_id_init+0x0/0x16c returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x11c @ 1
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x11c returned 0 after 42000 usecs
calling  init_vdso+0x0/0x18 @ 1
initcall init_vdso+0x0/0x18 returned 0 after 0 usecs
calling  sysenter_setup+0x0/0x18 @ 1
initcall sysenter_setup+0x0/0x18 returned 0 after 0 usecs
calling  fixup_ht_bug+0x0/0x257 @ 1
initcall fixup_ht_bug+0x0/0x257 returned 0 after 0 usecs
calling  topology_init+0x0/0x9e @ 1
initcall topology_init+0x0/0x9e returned 0 after 1000 usecs
calling  intel_epb_init+0x0/0xd8 @ 1
initcall intel_epb_init+0x0/0xd8 returned 0 after 0 usecs
calling  mtrr_init_finialize+0x0/0x6f @ 1
initcall mtrr_init_finialize+0x0/0x6f returned 0 after 0 usecs
calling  uid_cache_init+0x0/0x102 @ 1
initcall uid_cache_init+0x0/0x102 returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0x4f @ 1
initcall param_sysfs_init+0x0/0x4f returned 0 after 0 usecs
calling  user_namespace_sysctl_init+0x0/0x11e @ 1
initcall user_namespace_sysctl_init+0x0/0x11e returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x29 @ 1
initcall proc_schedstat_init+0x0/0x29 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x1d @ 1
initcall pm_sysrq_init+0x0/0x1d returned 0 after 0 usecs
calling  create_proc_profile+0x0/0xe0 @ 1
initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x742 @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x742 returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x3d @ 1
initcall crash_notes_memory_init+0x0/0x3d returned 0 after 1000 usecs
calling  cgroup_sysfs_init+0x0/0x42 @ 1
initcall cgroup_sysfs_init+0x0/0x42 returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0xc @ 1
initcall cgroup_namespaces_init+0x0/0xc returned 0 after 0 usecs
calling  user_namespaces_init+0x0/0x31 @ 1
initcall user_namespaces_init+0x0/0x31 returned 0 after 0 usecs
calling  init_optprobes+0x0/0x1d @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x1d returned 0 after 10000 usecs
calling  hung_task_init+0x0/0x79 @ 1
initcall hung_task_init+0x0/0x79 returned 0 after 0 usecs
calling  ftrace_check_for_weak_functions+0x0/0x8b @ 1
initcall ftrace_check_for_weak_functions+0x0/0x8b returned 0 after 0 usecs
calling  trace_eval_init+0x0/0xae @ 1
initcall trace_eval_init+0x0/0xae returned 0 after 1000 usecs
calling  send_signal_irq_work_init+0x0/0x154 @ 1
initcall send_signal_irq_work_init+0x0/0x154 returned 0 after 0 usecs
calling  dev_map_init+0x0/0x123 @ 1
initcall dev_map_init+0x0/0x123 returned 0 after 0 usecs
calling  cpu_map_init+0x0/0x117 @ 1
initcall cpu_map_init+0x0/0x117 returned 0 after 0 usecs
calling  netns_bpf_init+0x0/0x15 @ 1
initcall netns_bpf_init+0x0/0x15 returned 0 after 0 usecs
calling  oom_init+0x0/0x4e @ 1
initcall oom_init+0x0/0x4e returned 0 after 1000 usecs
calling  default_bdi_init+0x0/0x2d @ 1
initcall default_bdi_init+0x0/0x2d returned 0 after 1000 usecs
calling  cgwb_init+0x0/0x2d @ 1
initcall cgwb_init+0x0/0x2d returned 0 after 0 usecs
calling  percpu_enable_async+0x0/0x13 @ 1
initcall percpu_enable_async+0x0/0x13 returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x9c @ 1
initcall kcompactd_init+0x0/0x9c returned 0 after 0 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x23 @ 1
initcall init_reserve_notifier+0x0/0x23 returned 0 after 0 usecs
calling  swap_init_sysfs+0x0/0x92 @ 1
initcall swap_init_sysfs+0x0/0x92 returned 0 after 0 usecs
calling  swapfile_init+0x0/0x14b @ 1
initcall swapfile_init+0x0/0x14b returned 0 after 0 usecs
calling  hugetlb_init+0x0/0xb07 @ 1
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
initcall hugetlb_init+0x0/0xb07 returned 0 after 30000 usecs
calling  ksm_init+0x0/0x246 @ 1
initcall ksm_init+0x0/0x246 returned 0 after 1000 usecs
calling  memory_tier_init+0x0/0x143 @ 1
initcall memory_tier_init+0x0/0x143 returned 0 after 1000 usecs
calling  numa_init_sysfs+0x0/0x92 @ 1
initcall numa_init_sysfs+0x0/0x92 returned 0 after 0 usecs
calling  hugepage_init+0x0/0x1b4 @ 1
initcall hugepage_init+0x0/0x1b4 returned 0 after 0 usecs
calling  mem_cgroup_init+0x0/0x3d0 @ 1
initcall mem_cgroup_init+0x0/0x3d0 returned 0 after 0 usecs
calling  mem_cgroup_swap_init+0x0/0x60 @ 1
initcall mem_cgroup_swap_init+0x0/0x60 returned 0 after 0 usecs
calling  page_idle_init+0x0/0x5d @ 1
initcall page_idle_init+0x0/0x5d returned 0 after 0 usecs
calling  damon_init+0x0/0x49 @ 1
initcall damon_init+0x0/0x49 returned 0 after 0 usecs
calling  damon_va_initcall+0x0/0x15c @ 1
initcall damon_va_initcall+0x0/0x15c returned 0 after 0 usecs
calling  damon_pa_initcall+0x0/0xf7 @ 1
initcall damon_pa_initcall+0x0/0xf7 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x15 @ 1
initcall seqiv_module_init+0x0/0x15 returned 0 after 0 usecs
calling  rsa_init+0x0/0x43 @ 1
initcall rsa_init+0x0/0x43 returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x15 @ 1
initcall hmac_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x71 @ 1
initcall crypto_null_mod_init+0x0/0x71 returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x15 @ 1
initcall md5_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x15 @ 1
initcall sha1_generic_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x1a @ 1
initcall sha256_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x1a @ 1
initcall sha512_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x15 @ 1
initcall crypto_ecb_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x15 @ 1
initcall crypto_cbc_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x15 @ 1
initcall crypto_cfb_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x1a @ 1
initcall crypto_ctr_module_init+0x0/0x1a returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x67 @ 1
initcall crypto_gcm_module_init+0x0/0x67 returned 0 after 0 usecs
calling  cryptd_init+0x0/0x21d @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x21d returned 0 after 6000 usecs
calling  aes_init+0x0/0x15 @ 1
initcall aes_init+0x0/0x15 returned 0 after 0 usecs
calling  sm4_init+0x0/0x15 @ 1
initcall sm4_init+0x0/0x15 returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x48 @ 1
initcall deflate_mod_init+0x0/0x48 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x15 @ 1
initcall crc32c_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x15 @ 1
initcall crct10dif_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0x43 @ 1
initcall lzo_mod_init+0x0/0x43 returned 0 after 0 usecs
calling  lzorle_mod_init+0x0/0x43 @ 1
initcall lzorle_mod_init+0x0/0x43 returned 0 after 0 usecs
calling  drbg_init+0x0/0xe8 @ 1
initcall drbg_init+0x0/0xe8 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x15 @ 1
initcall ghash_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  init_bio+0x0/0x115 @ 1
initcall init_bio+0x0/0x115 returned 0 after 1000 usecs
calling  blk_ioc_init+0x0/0x2e @ 1
initcall blk_ioc_init+0x0/0x2e returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x17b @ 1
initcall blk_mq_init+0x0/0x17b returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x8c @ 1
initcall genhd_device_init+0x0/0x8c returned 0 after 0 usecs
calling  blkcg_init+0x0/0x2d @ 1
initcall blkcg_init+0x0/0x2d returned 0 after 0 usecs
calling  io_wq_init+0x0/0x3d @ 1
initcall io_wq_init+0x0/0x3d returned 0 after 0 usecs
calling  sg_pool_init+0x0/0x1a9 @ 1
initcall sg_pool_init+0x0/0x1a9 returned 0 after 1000 usecs
calling  irq_poll_setup+0x0/0x149 @ 1
initcall irq_poll_setup+0x0/0x149 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x28 @ 1
initcall gpiolib_debugfs_init+0x0/0x28 returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x28 @ 1
initcall pwm_debugfs_init+0x0/0x28 returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x1c @ 1
initcall pwm_sysfs_init+0x0/0x1c returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
calling  fbmem_init+0x0/0xe5 @ 1
initcall fbmem_init+0x0/0xe5 returned 0 after 0 usecs
calling  scan_for_dmi_ipmi+0x0/0x56 @ 1
initcall scan_for_dmi_ipmi+0x0/0x56 returned 0 after 0 usecs
calling  acpi_init+0x0/0x271 @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103DFD000 0006C3 (v02 PmRef  Cpu0Ist  00003000 INTL 20121018)
ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103E96800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121018)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103EAE000 0005AA (v02 PmRef  ApIst    00003000 INTL 20121018)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888100F69C00 000119 (v02 PmRef  ApCst    00003000 INTL 20121018)
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 5 GPEs in block 00 to 7F
ACPI: \_SB_.PCI0.PEG1.PG01: New power resource
ACPI: \_SB_.PCI0.PEG2.PG02: New power resource
ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
ACPI: \_SB_.PCI0.PEG0.PEGP.WRST: New power resource
ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME LTR]
acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: root bus resource [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
pci 0000:00:00.0: [8086:1918] type 00 class 0x060000
pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:02.0: [8086:191d] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xd0000000-0xd0ffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x490 @ 1
pci 0000:00:02.0: efifb_fixup_resources+0x0/0x490 took 0 usecs
pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x200 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x200 took 8789 usecs
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xd1020000-0xd102ffff 64bit]
pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
pci 0000:00:14.2: reg 0x10: [mem 0xd104a000-0xd104afff 64bit]
pci 0000:00:14.2: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:14.2: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xd104b000-0xd104bfff 64bit]
pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:16.3: [8086:a13d] type 00 class 0x070002
pci 0000:00:16.3: reg 0x10: [io  0x3080-0x3087]
pci 0000:00:16.3: reg 0x14: [mem 0xd104f000-0xd104ffff]
pci 0000:00:16.3: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:16.3: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:17.0: [8086:2822] type 00 class 0x010400
pci 0000:00:17.0: reg 0x10: [mem 0xd1048000-0xd1049fff]
pci 0000:00:17.0: reg 0x14: [mem 0xd104e000-0xd104e0ff]
pci 0000:00:17.0: reg 0x18: [io  0x3088-0x308f]
pci 0000:00:17.0: reg 0x1c: [io  0x3090-0x3093]
pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
pci 0000:00:17.0: reg 0x24: [mem 0xd104c000-0xd104c7ff]
pci 0000:00:17.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:17.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1f.0: [8086:a149] type 00 class 0x060100
pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
pci 0000:00:1f.2: reg 0x10: [mem 0xd1044000-0xd1047fff]
pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
pci 0000:00:1f.3: reg 0x10: [mem 0xd1040000-0xd1043fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0xd1030000-0xd103ffff 64bit]
pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0xd104d000-0xd104d0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
pci 0000:00:1f.4: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.4: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.6: calling  quirk_f0_vpd_link+0x0/0x220 @ 1
pci 0000:00:1f.6: quirk_f0_vpd_link+0x0/0x220 took 0 usecs
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
pci 0000:00:1f.6: reg 0x10: [mem 0xd1000000-0xd101ffff]
pci 0000:00:1f.6: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.6: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
ACPI: PCI: Interrupt link LNKA configured for IRQ 11
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 11
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 11
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 11
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: EC: GPE=0x6e
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
initcall acpi_init+0x0/0x271 returned 0 after 2334000 usecs
calling  adxl_init+0x0/0x250 @ 1
initcall adxl_init+0x0/0x250 returned -19 after 0 usecs
calling  pnp_init+0x0/0x15 @ 1
initcall pnp_init+0x0/0x15 returned 0 after 1000 usecs
calling  misc_init+0x0/0xe8 @ 1
initcall misc_init+0x0/0xe8 returned 0 after 1000 usecs
calling  tpm_init+0x0/0x21c @ 1
initcall tpm_init+0x0/0x21c returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x1a9 @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x1a9 returned 0 after 13000 usecs
calling  cn_init+0x0/0x180 @ 1
initcall cn_init+0x0/0x180 returned 0 after 0 usecs
calling  dax_core_init+0x0/0xe7 @ 1
initcall dax_core_init+0x0/0xe7 returned 0 after 0 usecs
calling  dma_buf_init+0x0/0xcb @ 1
initcall dma_buf_init+0x0/0xcb returned 0 after 0 usecs
calling  dma_resv_lockdep+0x0/0x45a @ 1
initcall dma_resv_lockdep+0x0/0x45a returned 0 after 0 usecs
calling  dma_heap_init+0x0/0xc0 @ 1
initcall dma_heap_init+0x0/0xc0 returned 0 after 0 usecs
calling  init_scsi+0x0/0x8c @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x8c returned 0 after 5000 usecs
calling  phy_init+0x0/0x69 @ 1
initcall phy_init+0x0/0x69 returned 0 after 0 usecs
calling  usb_common_init+0x0/0x21 @ 1
initcall usb_common_init+0x0/0x21 returned 0 after 0 usecs
calling  usb_init+0x0/0x154 @ 1
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x154 returned 0 after 23000 usecs
calling  xdbc_init+0x0/0x155 @ 1
initcall xdbc_init+0x0/0x155 returned 0 after 0 usecs
calling  typec_init+0x0/0xb2 @ 1
initcall typec_init+0x0/0xb2 returned 0 after 0 usecs
calling  serio_init+0x0/0x32 @ 1
initcall serio_init+0x0/0x32 returned 0 after 1000 usecs
calling  input_init+0x0/0x108 @ 1
initcall input_init+0x0/0x108 returned 0 after 0 usecs
calling  rtc_init+0x0/0x75 @ 1
initcall rtc_init+0x0/0x75 returned 0 after 0 usecs
calling  rc_core_init+0x0/0x7e @ 1
initcall rc_core_init+0x0/0x7e returned 0 after 0 usecs
calling  pps_init+0x0/0xda @ 1
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
initcall pps_init+0x0/0xda returned 0 after 16000 usecs
calling  ptp_init+0x0/0xc4 @ 1
PTP clock support registered
initcall ptp_init+0x0/0xc4 returned 0 after 4000 usecs
calling  power_supply_class_init+0x0/0x68 @ 1
initcall power_supply_class_init+0x0/0x68 returned 0 after 1000 usecs
calling  hwmon_init+0x0/0x17c @ 1
initcall hwmon_init+0x0/0x17c returned 0 after 0 usecs
calling  md_init+0x0/0x160 @ 1
initcall md_init+0x0/0x160 returned 0 after 0 usecs
calling  edac_init+0x0/0x7a @ 1
EDAC MC: Ver: 3.0.0
initcall edac_init+0x0/0x7a returned 0 after 4000 usecs
calling  leds_init+0x0/0x83 @ 1
initcall leds_init+0x0/0x83 returned 0 after 0 usecs
calling  dmi_init+0x0/0x146 @ 1
initcall dmi_init+0x0/0x146 returned 0 after 0 usecs
calling  efisubsys_init+0x0/0x27f @ 1
initcall efisubsys_init+0x0/0x27f returned 0 after 0 usecs
calling  ras_init+0x0/0x13 @ 1
initcall ras_init+0x0/0x13 returned 0 after 0 usecs
calling  nvmem_init+0x0/0x15 @ 1
initcall nvmem_init+0x0/0x15 returned 0 after 1000 usecs
calling  proto_init+0x0/0x15 @ 1
initcall proto_init+0x0/0x15 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x620 @ 1
initcall net_dev_init+0x0/0x620 returned 0 after 1000 usecs
calling  neigh_init+0x0/0x89 @ 1
initcall neigh_init+0x0/0x89 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x15 @ 1
initcall fib_notifier_init+0x0/0x15 returned 0 after 0 usecs
calling  fib_rules_init+0x0/0xb6 @ 1
initcall fib_rules_init+0x0/0xb6 returned 0 after 0 usecs
calling  init_cgroup_netprio+0x0/0x18 @ 1
initcall init_cgroup_netprio+0x0/0x18 returned 0 after 0 usecs
calling  bpf_lwt_init+0x0/0x1a @ 1
initcall bpf_lwt_init+0x0/0x1a returned 0 after 0 usecs
calling  pktsched_init+0x0/0x117 @ 1
initcall pktsched_init+0x0/0x117 returned 0 after 0 usecs
calling  tc_filter_init+0x0/0x104 @ 1
initcall tc_filter_init+0x0/0x104 returned 0 after 0 usecs
calling  tc_action_init+0x0/0x59 @ 1
initcall tc_action_init+0x0/0x59 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x5c @ 1
initcall ethnl_init+0x0/0x5c returned 0 after 0 usecs
calling  nexthop_init+0x0/0xfa @ 1
initcall nexthop_init+0x0/0xfa returned 0 after 0 usecs
calling  cipso_v4_init+0x0/0xee @ 1
initcall cipso_v4_init+0x0/0xee returned 0 after 0 usecs
calling  netlbl_init+0x0/0x8c @ 1
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
initcall netlbl_init+0x0/0x8c returned 0 after 22000 usecs
calling  pci_subsys_init+0x0/0x122 @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x00091c00-0x0009ffff]
e820: reserve RAM buffer [mem 0xb30fb000-0xb3ffffff]
e820: reserve RAM buffer [mem 0xb3f00000-0xb3ffffff]
e820: reserve RAM buffer [mem 0x43f800000-0x43fffffff]
initcall pci_subsys_init+0x0/0x122 returned 0 after 67000 usecs
calling  vsprintf_init_hashval+0x0/0x13 @ 1
initcall vsprintf_init_hashval+0x0/0x13 returned 0 after 0 usecs
calling  efi_runtime_map_init+0x0/0x1dc @ 1
initcall efi_runtime_map_init+0x0/0x1dc returned 0 after 0 usecs
calling  vga_arb_device_init+0x0/0x7b @ 1
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
initcall vga_arb_device_init+0x0/0x7b returned 0 after 27000 usecs
calling  watchdog_init+0x0/0x13d @ 1
initcall watchdog_init+0x0/0x13d returned 0 after 0 usecs
calling  nmi_warning_debugfs+0x0/0x51 @ 1
initcall nmi_warning_debugfs+0x0/0x51 returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0xc7 @ 1
initcall save_microcode_in_initrd+0x0/0xc7 returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x173 @ 1
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
initcall hpet_late_init+0x0/0x173 returned 0 after 16000 usecs
calling  iomem_init_inode+0x0/0xab @ 1
initcall iomem_init_inode+0x0/0xab returned 0 after 1000 usecs
calling  clocksource_done_booting+0x0/0x48 @ 1
clocksource: Switched to clocksource tsc-early
initcall clocksource_done_booting+0x0/0x48 returned 0 after 6352 usecs
calling  tracer_init_tracefs+0x0/0x183 @ 1
initcall tracer_init_tracefs+0x0/0x183 returned 0 after 30 usecs
calling  init_trace_printk_function_export+0x0/0x2c @ 1
initcall init_trace_printk_function_export+0x0/0x2c returned 0 after 50 usecs
calling  init_graph_tracefs+0x0/0x2c @ 1
initcall init_graph_tracefs+0x0/0x2c returned 0 after 21 usecs
calling  trace_events_synth_init+0x0/0x4b @ 1
initcall trace_events_synth_init+0x0/0x4b returned 0 after 21 usecs
calling  bpf_event_init+0x0/0x13 @ 1
initcall bpf_event_init+0x0/0x13 returned 0 after 1 usecs
calling  init_kprobe_trace+0x0/0x312 @ 1
initcall init_kprobe_trace+0x0/0x312 returned 0 after 194151 usecs
calling  init_dynamic_event+0x0/0x2c @ 1
initcall init_dynamic_event+0x0/0x2c returned 0 after 32 usecs
calling  init_uprobe_trace+0x0/0x60 @ 1
initcall init_uprobe_trace+0x0/0x60 returned 0 after 41 usecs
calling  bpf_init+0x0/0x9d @ 1
initcall bpf_init+0x0/0x9d returned 0 after 13 usecs
calling  secretmem_init+0x0/0x60 @ 1
initcall secretmem_init+0x0/0x60 returned 0 after 0 usecs
calling  init_fs_stat_sysctls+0x0/0x32 @ 1
initcall init_fs_stat_sysctls+0x0/0x32 returned 0 after 27 usecs
calling  init_fs_exec_sysctls+0x0/0x26 @ 1
initcall init_fs_exec_sysctls+0x0/0x26 returned 0 after 10 usecs
calling  init_pipe_fs+0x0/0x68 @ 1
initcall init_pipe_fs+0x0/0x68 returned 0 after 202 usecs
calling  init_fs_namei_sysctls+0x0/0x26 @ 1
initcall init_fs_namei_sysctls+0x0/0x26 returned 0 after 11 usecs
calling  init_fs_dcache_sysctls+0x0/0x26 @ 1
initcall init_fs_dcache_sysctls+0x0/0x26 returned 0 after 6 usecs
calling  init_fs_namespace_sysctls+0x0/0x26 @ 1
initcall init_fs_namespace_sysctls+0x0/0x26 returned 0 after 6 usecs
calling  cgroup_writeback_init+0x0/0x2a @ 1
initcall cgroup_writeback_init+0x0/0x2a returned 0 after 21 usecs
calling  inotify_user_setup+0x0/0x18e @ 1
initcall inotify_user_setup+0x0/0x18e returned 0 after 41 usecs
calling  eventpoll_init+0x0/0x145 @ 1
initcall eventpoll_init+0x0/0x145 returned 0 after 63 usecs
calling  anon_inode_init+0x0/0x8e @ 1
initcall anon_inode_init+0x0/0x8e returned 0 after 192 usecs
calling  init_dax_wait_table+0x0/0x38 @ 1
initcall init_dax_wait_table+0x0/0x38 returned 0 after 270 usecs
calling  proc_locks_init+0x0/0x2c @ 1
initcall proc_locks_init+0x0/0x2c returned 0 after 9 usecs
calling  init_fs_coredump_sysctls+0x0/0x26 @ 1
initcall init_fs_coredump_sysctls+0x0/0x26 returned 0 after 9 usecs
calling  iomap_init+0x0/0x24 @ 1
initcall iomap_init+0x0/0x24 returned 0 after 253 usecs
calling  dquot_init+0x0/0x167 @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x167 returned 0 after 12555 usecs
calling  quota_init+0x0/0x28 @ 1
initcall quota_init+0x0/0x28 returned 0 after 62 usecs
calling  proc_cmdline_init+0x0/0x93 @ 1
initcall proc_cmdline_init+0x0/0x93 returned 0 after 7 usecs
calling  proc_consoles_init+0x0/0x29 @ 1
initcall proc_consoles_init+0x0/0x29 returned 0 after 6 usecs
calling  proc_cpuinfo_init+0x0/0x23 @ 1
initcall proc_cpuinfo_init+0x0/0x23 returned 0 after 24 usecs
calling  proc_devices_init+0x0/0x62 @ 1
initcall proc_devices_init+0x0/0x62 returned 0 after 14 usecs
calling  proc_interrupts_init+0x0/0x29 @ 1
initcall proc_interrupts_init+0x0/0x29 returned 0 after 6 usecs
calling  proc_loadavg_init+0x0/0x5f @ 1
initcall proc_loadavg_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_meminfo_init+0x0/0x5f @ 1
initcall proc_meminfo_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_stat_init+0x0/0x23 @ 1
initcall proc_stat_init+0x0/0x23 returned 0 after 6 usecs
calling  proc_uptime_init+0x0/0x5f @ 1
initcall proc_uptime_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_version_init+0x0/0x5f @ 1
initcall proc_version_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_softirqs_init+0x0/0x5f @ 1
initcall proc_softirqs_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_kcore_init+0x0/0x146 @ 1
initcall proc_kcore_init+0x0/0x146 returned 0 after 72 usecs
calling  vmcore_init+0x0/0x2f5 @ 1
initcall vmcore_init+0x0/0x2f5 returned 0 after 0 usecs
calling  proc_kmsg_init+0x0/0x26 @ 1
initcall proc_kmsg_init+0x0/0x26 returned 0 after 6 usecs
calling  proc_page_init+0x0/0x5a @ 1
initcall proc_page_init+0x0/0x5a returned 0 after 23 usecs
calling  init_ramfs_fs+0x0/0x15 @ 1
initcall init_ramfs_fs+0x0/0x15 returned 0 after 1 usecs
calling  init_hugetlbfs_fs+0x0/0x2a4 @ 1
initcall init_hugetlbfs_fs+0x0/0x2a4 returned 0 after 303 usecs
calling  dynamic_debug_init_control+0x0/0x80 @ 1
initcall dynamic_debug_init_control+0x0/0x80 returned 0 after 57 usecs
calling  acpi_event_init+0x0/0x65 @ 1
initcall acpi_event_init+0x0/0x65 returned 0 after 62 usecs
calling  pnp_system_init+0x0/0x15 @ 1
initcall pnp_system_init+0x0/0x15 returned 0 after 56 usecs
calling  pnpacpi_init+0x0/0xd6 @ 1
pnp: PnP ACPI init
system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:00: [mem 0xfe000000-0xfe01ffff] has been reserved
system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:01: [io  0x0680-0x069f] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0x1800-0x18fe] has been reserved
system 00:01: [io  0x164e-0x164f] has been reserved
system 00:02: [io  0x0800-0x087f] has been reserved
system 00:04: [io  0x1854-0x1857] has been reserved
system 00:08: [io  0x0200-0x023f] has been reserved
system 00:08: [mem 0xfedb0000-0xfedbffff] has been reserved
system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:09: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:09: [mem 0xfed45000-0xfed8ffff] could not be reserved
system 00:09: [mem 0xff000000-0xffffffff] could not be reserved
system 00:09: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:09: [mem 0xfedc0000-0xfeddffff] has been reserved
pnp: PnP ACPI: found 11 devices
initcall pnpacpi_init+0x0/0xd6 returned 0 after 224484 usecs
calling  chr_dev_init+0x0/0x135 @ 1
initcall chr_dev_init+0x0/0x135 returned 0 after 14458 usecs
calling  hwrng_modinit+0x0/0xea @ 1
initcall hwrng_modinit+0x0/0xea returned 0 after 248 usecs
calling  firmware_class_init+0x0/0x15f @ 1
initcall firmware_class_init+0x0/0x15f returned 0 after 51 usecs
calling  init_acpi_pm_clocksource+0x0/0xd6 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xd6 returned 0 after 14292 usecs
calling  powercap_init+0x0/0x26 @ 1
initcall powercap_init+0x0/0x26 returned 0 after 266 usecs
calling  sysctl_core_init+0x0/0x2f @ 1
initcall sysctl_core_init+0x0/0x2f returned 0 after 43 usecs
calling  eth_offload_init+0x0/0x18 @ 1
initcall eth_offload_init+0x0/0x18 returned 0 after 15 usecs
calling  ipv4_offload_init+0x0/0x78 @ 1
initcall ipv4_offload_init+0x0/0x78 returned 0 after 1 usecs
calling  inet_init+0x0/0x32f @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
TCP: Hash tables configured (established 131072 bind 65536)
MPTCP token hash table entries: 16384 (order: 8, 1441792 bytes, linear)
UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
initcall inet_init+0x0/0x32f returned 0 after 98283 usecs
calling  af_unix_init+0x0/0x19e @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x19e returned 0 after 6622 usecs
calling  ipv6_offload_init+0x0/0x83 @ 1
initcall ipv6_offload_init+0x0/0x83 returned 0 after 1 usecs
calling  init_sunrpc+0x0/0x8c @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x8c returned 0 after 26150 usecs
calling  vlan_offload_init+0x0/0x24 @ 1
initcall vlan_offload_init+0x0/0x24 returned 0 after 1 usecs
calling  xsk_init+0x0/0x1bc @ 1
NET: Registered PF_XDP protocol family
initcall xsk_init+0x0/0x1bc returned 0 after 5653 usecs
calling  pcibios_assign_resources+0x0/0x23a @ 1
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: resource 8 [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: resource 9 [mem 0xfd000000-0xfe7fffff window]
initcall pcibios_assign_resources+0x0/0x23a returned 0 after 46887 usecs
calling  pci_apply_final_quirks+0x0/0x330 @ 1
pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2d0 took 13985 usecs
pci 0000:00:1f.6: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:00:1f.6: quirk_e100_interrupt+0x0/0x290 took 0 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x330 returned 0 after 50634 usecs
calling  acpi_reserve_resources+0x0/0x277 @ 1
initcall acpi_reserve_resources+0x0/0x277 returned 0 after 21 usecs
calling  populate_rootfs+0x0/0x40 @ 1
initcall populate_rootfs+0x0/0x40 returned 0 after 86 usecs
Trying to unpack rootfs image as initramfs...
calling  pci_iommu_init+0x0/0x59 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000af0fb000-0x00000000b30fb000] (64MB)
initcall pci_iommu_init+0x0/0x59 returned 0 after 16086 usecs
calling  ir_dev_scope_init+0x0/0x71 @ 1
initcall ir_dev_scope_init+0x0/0x71 returned 0 after 0 usecs
calling  ia32_binfmt_init+0x0/0x18 @ 1
initcall ia32_binfmt_init+0x0/0x18 returned 0 after 23 usecs
calling  amd_ibs_init+0x0/0xfa @ 1
initcall amd_ibs_init+0x0/0xfa returned -19 after 0 usecs
calling  msr_init+0x0/0x80 @ 1
initcall msr_init+0x0/0x80 returned 0 after 30 usecs
calling  register_kernel_offset_dumper+0x0/0x1f @ 1
initcall register_kernel_offset_dumper+0x0/0x1f returned 0 after 1 usecs
calling  i8259A_init_ops+0x0/0x25 @ 1
initcall i8259A_init_ops+0x0/0x25 returned 0 after 1 usecs
calling  init_tsc_clocksource+0x0/0xe6 @ 1
initcall init_tsc_clocksource+0x0/0xe6 returned 0 after 6 usecs
calling  add_rtc_cmos+0x0/0x1f4 @ 1
initcall add_rtc_cmos+0x0/0x1f4 returned 0 after 2 usecs
calling  i8237A_init_ops+0x0/0x3b @ 1
initcall i8237A_init_ops+0x0/0x3b returned -19 after 2 usecs
calling  umwait_init+0x0/0xe1 @ 1
initcall umwait_init+0x0/0xe1 returned -19 after 0 usecs
calling  sgx_init+0x0/0x15d @ 1
initcall sgx_init+0x0/0x15d returned -19 after 0 usecs
calling  msr_init+0x0/0x101 @ 1
initcall msr_init+0x0/0x101 returned 0 after 1645 usecs
calling  cpuid_init+0x0/0x101 @ 1
initcall cpuid_init+0x0/0x101 returned 0 after 978 usecs
calling  ioapic_init_ops+0x0/0x18 @ 1
initcall ioapic_init_ops+0x0/0x18 returned 0 after 1 usecs
calling  register_e820_pmem+0x0/0x62 @ 1
initcall register_e820_pmem+0x0/0x62 returned 0 after 4 usecs
calling  add_pcspkr+0x0/0xd3 @ 1
initcall add_pcspkr+0x0/0xd3 returned 0 after 140 usecs
calling  start_periodic_check_for_corruption+0x0/0x40 @ 1
initcall start_periodic_check_for_corruption+0x0/0x40 returned 0 after 0 usecs
calling  audit_classes_init+0x0/0xb3 @ 1
initcall audit_classes_init+0x0/0xb3 returned 0 after 48 usecs
calling  sha1_ssse3_mod_init+0x0/0xeb @ 1
initcall sha1_ssse3_mod_init+0x0/0xeb returned 0 after 13 usecs
calling  sha256_ssse3_mod_init+0x0/0xff @ 1
initcall sha256_ssse3_mod_init+0x0/0xff returned 0 after 18 usecs
calling  iosf_mbi_init+0x0/0x2d @ 1
initcall iosf_mbi_init+0x0/0x2d returned 0 after 129 usecs
calling  proc_execdomains_init+0x0/0x26 @ 1
initcall proc_execdomains_init+0x0/0x26 returned 0 after 10 usecs
calling  register_warn_debugfs+0x0/0x28 @ 1
initcall register_warn_debugfs+0x0/0x28 returned 0 after 42 usecs
calling  cpuhp_sysfs_init+0x0/0x144 @ 1
initcall cpuhp_sysfs_init+0x0/0x144 returned 0 after 138 usecs
calling  ioresources_init+0x0/0x4e @ 1
initcall ioresources_init+0x0/0x4e returned 0 after 15 usecs
calling  lockdep_proc_init+0x0/0x64 @ 1
initcall lockdep_proc_init+0x0/0x64 returned 0 after 17 usecs
calling  snapshot_device_init+0x0/0x15 @ 1
initcall snapshot_device_init+0x0/0x15 returned 0 after 208 usecs
calling  irq_pm_init_ops+0x0/0x18 @ 1
initcall irq_pm_init_ops+0x0/0x18 returned 0 after 1 usecs
calling  klp_init+0x0/0x53 @ 1
initcall klp_init+0x0/0x53 returned 0 after 28 usecs
calling  map_benchmark_init+0x0/0x4e @ 1
initcall map_benchmark_init+0x0/0x4e returned 0 after 144 usecs
calling  proc_modules_init+0x0/0x23 @ 1
initcall proc_modules_init+0x0/0x23 returned 0 after 9 usecs
calling  timer_sysctl_init+0x0/0x1f @ 1
initcall timer_sysctl_init+0x0/0x1f returned 0 after 23 usecs
calling  timekeeping_init_ops+0x0/0x18 @ 1
initcall timekeeping_init_ops+0x0/0x18 returned 0 after 1 usecs
calling  init_clocksource_sysfs+0x0/0x28 @ 1
initcall init_clocksource_sysfs+0x0/0x28 returned 0 after 308 usecs
calling  init_timer_list_procfs+0x0/0x36 @ 1
initcall init_timer_list_procfs+0x0/0x36 returned 0 after 9 usecs
calling  alarmtimer_init+0x0/0x133 @ 1
initcall alarmtimer_init+0x0/0x133 returned 0 after 93 usecs
calling  init_posix_timers+0x0/0x2e @ 1
initcall init_posix_timers+0x0/0x2e returned 0 after 48 usecs
calling  clockevents_init_sysfs+0x0/0x19e @ 1
initcall clockevents_init_sysfs+0x0/0x19e returned 0 after 698 usecs
calling  proc_dma_init+0x0/0x26 @ 1
initcall proc_dma_init+0x0/0x26 returned 0 after 8 usecs
calling  kallsyms_init+0x0/0x26 @ 1
initcall kallsyms_init+0x0/0x26 returned 0 after 7 usecs
calling  pid_namespaces_init+0x0/0x44 @ 1
initcall pid_namespaces_init+0x0/0x44 returned 0 after 51 usecs
calling  ikconfig_init+0x0/0x46 @ 1
initcall ikconfig_init+0x0/0x46 returned 0 after 7 usecs
calling  audit_watch_init+0x0/0x40 @ 1
initcall audit_watch_init+0x0/0x40 returned 0 after 5 usecs
calling  audit_fsnotify_init+0x0/0x43 @ 1
initcall audit_fsnotify_init+0x0/0x43 returned 0 after 4 usecs
calling  audit_tree_init+0x0/0xcf @ 1
initcall audit_tree_init+0x0/0xcf returned 0 after 32 usecs
calling  seccomp_sysctl_init+0x0/0x30 @ 1
initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 24 usecs
calling  utsname_sysctl_init+0x0/0x18 @ 1
initcall utsname_sysctl_init+0x0/0x18 returned 0 after 20 usecs
calling  init_tracepoints+0x0/0x30 @ 1
initcall init_tracepoints+0x0/0x30 returned 0 after 16 usecs
calling  init_lstats_procfs+0x0/0x40 @ 1
initcall init_lstats_procfs+0x0/0x40 returned 0 after 18 usecs
calling  stack_trace_init+0x0/0xa8 @ 1
initcall stack_trace_init+0x0/0xa8 returned 0 after 67 usecs
calling  perf_event_sysfs_init+0x0/0x10c @ 1
initcall perf_event_sysfs_init+0x0/0x10c returned 0 after 1696 usecs
calling  system_trusted_keyring_init+0x0/0x8e @ 1
Initialise system trusted keyrings
initcall system_trusted_keyring_init+0x0/0x8e returned 0 after 5332 usecs
calling  blacklist_init+0x0/0x166 @ 1
Key type blacklist registered
initcall blacklist_init+0x0/0x166 returned 0 after 4881 usecs
calling  kswapd_init+0x0/0x64 @ 1
initcall kswapd_init+0x0/0x64 returned 0 after 179 usecs
calling  extfrag_debug_init+0x0/0x5b @ 1
initcall extfrag_debug_init+0x0/0x5b returned 0 after 74 usecs
calling  mm_compute_batch_init+0x0/0x57 @ 1
initcall mm_compute_batch_init+0x0/0x57 returned 0 after 2 usecs
calling  slab_proc_init+0x0/0x26 @ 1
initcall slab_proc_init+0x0/0x26 returned 0 after 25 usecs
calling  workingset_init+0x0/0xd4 @ 1
workingset: timestamp_bits=36 max_order=22 bucket_order=0
initcall workingset_init+0x0/0xd4 returned 0 after 7290 usecs
calling  proc_vmalloc_init+0x0/0x68 @ 1
initcall proc_vmalloc_init+0x0/0x68 returned 0 after 7 usecs
calling  procswaps_init+0x0/0x23 @ 1
initcall procswaps_init+0x0/0x23 returned 0 after 7 usecs
calling  init_frontswap+0x0/0x97 @ 1
initcall init_frontswap+0x0/0x97 returned 0 after 109 usecs
calling  slab_debugfs_init+0x0/0x52 @ 1
initcall slab_debugfs_init+0x0/0x52 returned 0 after 53 usecs
calling  init_zbud+0x0/0x24 @ 1
zbud: loaded
initcall init_zbud+0x0/0x24 returned 0 after 3363 usecs
calling  zs_init+0x0/0x77 @ 1
initcall zs_init+0x0/0x77 returned 0 after 63 usecs
calling  damon_dbgfs_init+0x0/0x389 @ 1
initcall damon_dbgfs_init+0x0/0x389 returned 0 after 279 usecs
calling  fcntl_init+0x0/0x2e @ 1
initcall fcntl_init+0x0/0x2e returned 0 after 31 usecs
calling  proc_filesystems_init+0x0/0x26 @ 1
initcall proc_filesystems_init+0x0/0x26 returned 0 after 25 usecs
calling  start_dirtytime_writeback+0x0/0x1b @ 1
initcall start_dirtytime_writeback+0x0/0x1b returned 0 after 2 usecs
calling  dio_init+0x0/0x31 @ 1
initcall dio_init+0x0/0x31 returned 0 after 34 usecs
calling  dnotify_init+0x0/0xa1 @ 1
initcall dnotify_init+0x0/0xa1 returned 0 after 55 usecs
calling  fanotify_user_setup+0x0/0x1fb @ 1
initcall fanotify_user_setup+0x0/0x1fb returned 0 after 84 usecs
calling  userfaultfd_init+0x0/0x4a @ 1
initcall userfaultfd_init+0x0/0x4a returned 0 after 256 usecs
calling  aio_setup+0x0/0x9c @ 1
initcall aio_setup+0x0/0x9c returned 0 after 291 usecs
calling  mbcache_init+0x0/0x35 @ 1
initcall mbcache_init+0x0/0x35 returned 0 after 20 usecs
calling  init_grace+0x0/0x15 @ 1
initcall init_grace+0x0/0x15 returned 0 after 28 usecs
calling  init_v2_quota_format+0x0/0x26 @ 1
initcall init_v2_quota_format+0x0/0x26 returned 0 after 26 usecs
calling  init_devpts_fs+0x0/0x30 @ 1
initcall init_devpts_fs+0x0/0x30 returned 0 after 1034 usecs
calling  ext4_init_fs+0x0/0x1a3 @ 1
initcall ext4_init_fs+0x0/0x1a3 returned 0 after 704 usecs
calling  journal_init+0x0/0x132 @ 1
initcall journal_init+0x0/0x132 returned 0 after 112 usecs
calling  init_nfs_fs+0x0/0x195 @ 1
initcall init_nfs_fs+0x0/0x195 returned 0 after 720 usecs
calling  init_nfs_v3+0x0/0x18 @ 1
initcall init_nfs_v3+0x0/0x18 returned 0 after 29 usecs
calling  init_nlm+0x0/0x66 @ 1
initcall init_nlm+0x0/0x66 returned 0 after 60 usecs
calling  init_nls_cp437+0x0/0x17 @ 1
initcall init_nls_cp437+0x0/0x17 returned 0 after 26 usecs
calling  init_nls_ascii+0x0/0x17 @ 1
initcall init_nls_ascii+0x0/0x17 returned 0 after 1 usecs
calling  init_autofs_fs+0x0/0x2e @ 1
initcall init_autofs_fs+0x0/0x2e returned 0 after 247 usecs
calling  efivarfs_init+0x0/0x25 @ 1
initcall efivarfs_init+0x0/0x25 returned -19 after 0 usecs
calling  ipc_init+0x0/0x29 @ 1
initcall ipc_init+0x0/0x29 returned 0 after 71 usecs
calling  ipc_sysctl_init+0x0/0x31 @ 1
initcall ipc_sysctl_init+0x0/0x31 returned 0 after 36 usecs
calling  init_mqueue_fs+0x0/0xcd @ 1
initcall init_mqueue_fs+0x0/0xcd returned 0 after 281 usecs
calling  key_proc_init+0x0/0x72 @ 1
tsc: Refined TSC clocksource calibration: 3312.000 MHz
initcall key_proc_init+0x0/0x72 returned 0 after 13 usecs
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fbd93f9e57, max_idle_ns: 440795263784 ns
calling  jent_mod_init+0x0/0x32 @ 1
clocksource: Switched to clocksource tsc
initcall jent_mod_init+0x0/0x32 returned 0 after 6745 usecs
calling  af_alg_init+0x0/0x45 @ 1
NET: Registered PF_ALG protocol family
initcall af_alg_init+0x0/0x45 returned 0 after 5623 usecs
calling  algif_hash_init+0x0/0x15 @ 1
initcall algif_hash_init+0x0/0x15 returned 0 after 55 usecs
calling  algif_skcipher_init+0x0/0x15 @ 1
initcall algif_skcipher_init+0x0/0x15 returned 0 after 4 usecs
calling  rng_init+0x0/0x15 @ 1
initcall rng_init+0x0/0x15 returned 0 after 3 usecs
calling  algif_aead_init+0x0/0x15 @ 1
initcall algif_aead_init+0x0/0x15 returned 0 after 4 usecs
calling  asymmetric_key_init+0x0/0x15 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x15 returned 0 after 4930 usecs
calling  x509_key_init+0x0/0x1d @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x1d returned 0 after 5740 usecs
calling  blkdev_init+0x0/0x24 @ 1
initcall blkdev_init+0x0/0x24 returned 0 after 49 usecs
calling  proc_genhd_init+0x0/0x46 @ 1
initcall proc_genhd_init+0x0/0x46 returned 0 after 16 usecs
calling  bsg_init+0x0/0x11b @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
initcall bsg_init+0x0/0x11b returned 0 after 8286 usecs
calling  throtl_init+0x0/0x45 @ 1
initcall throtl_init+0x0/0x45 returned 0 after 234 usecs
calling  deadline_init+0x0/0x15 @ 1
io scheduler mq-deadline registered
initcall deadline_init+0x0/0x15 returned 0 after 5351 usecs
calling  kyber_init+0x0/0x15 @ 1
io scheduler kyber registered
initcall kyber_init+0x0/0x15 returned 0 after 4802 usecs
calling  bfq_init+0x0/0x8f @ 1
io scheduler bfq registered
initcall bfq_init+0x0/0x8f returned 0 after 4745 usecs
calling  io_uring_init+0x0/0x36 @ 1
initcall io_uring_init+0x0/0x36 returned 0 after 40 usecs
calling  test_firmware_init+0x0/0x97 @ 1
test_firmware: interface ready
initcall test_firmware_init+0x0/0x97 returned 0 after 5296 usecs
calling  test_sysctl_init+0x0/0x516 @ 1
initcall test_sysctl_init+0x0/0x516 returned 0 after 24 usecs
calling  blake2s_mod_init+0x0/0xc @ 1
initcall blake2s_mod_init+0x0/0xc returned 0 after 0 usecs
calling  crc_t10dif_mod_init+0x0/0x75 @ 1
initcall crc_t10dif_mod_init+0x0/0x75 returned 0 after 110 usecs
calling  percpu_counter_startup+0x0/0x55 @ 1
initcall percpu_counter_startup+0x0/0x55 returned 0 after 87 usecs
calling  digsig_init+0x0/0x3d @ 1
initcall digsig_init+0x0/0x3d returned 0 after 12 usecs
calling  pcie_portdrv_init+0x0/0x4d @ 1
initcall pcie_portdrv_init+0x0/0x4d returned 0 after 315 usecs
calling  pci_proc_init+0x0/0x70 @ 1
initcall pci_proc_init+0x0/0x70 returned 0 after 102 usecs
calling  pci_hotplug_init+0x0/0xc @ 1
initcall pci_hotplug_init+0x0/0xc returned 0 after 0 usecs
calling  shpcd_init+0x0/0x61 @ 1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
initcall shpcd_init+0x0/0x61 returned 0 after 7614 usecs
calling  pci_stub_init+0x0/0x1ff @ 1
initcall pci_stub_init+0x0/0x1ff returned 0 after 79 usecs
calling  vmd_drv_init+0x0/0x1e @ 1
initcall vmd_drv_init+0x0/0x1e returned 0 after 87 usecs
calling  vesafb_driver_init+0x0/0x17 @ 1
initcall vesafb_driver_init+0x0/0x17 returned 0 after 53 usecs
calling  efifb_driver_init+0x0/0x17 @ 1
initcall efifb_driver_init+0x0/0x17 returned 0 after 58 usecs
calling  intel_idle_init+0x0/0x507 @ 1
initcall intel_idle_init+0x0/0x507 returned 0 after 3721 usecs
calling  ged_driver_init+0x0/0x17 @ 1
initcall ged_driver_init+0x0/0x17 returned 0 after 133 usecs
calling  acpi_ac_init+0x0/0x7c @ 1
initcall acpi_ac_init+0x0/0x7c returned 0 after 505 usecs
calling  acpi_button_driver_init+0x0/0xb3 @ 1
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xb3 returned 0 after 45209 usecs
calling  acpi_fan_driver_init+0x0/0x17 @ 1
initcall acpi_fan_driver_init+0x0/0x17 returned 0 after 61 usecs
calling  acpi_processor_driver_init+0x0/0xef @ 1
initcall acpi_processor_driver_init+0x0/0xef returned 0 after 2063 usecs
calling  acpi_thermal_init+0x0/0x86 @ 1
initcall acpi_thermal_init+0x0/0x86 returned 0 after 612 usecs
calling  acpi_battery_init+0x0/0x71 @ 1
initcall acpi_battery_init+0x0/0x71 returned 0 after 12 usecs
calling  acpi_hed_driver_init+0x0/0x15 @ 1
initcall acpi_hed_driver_init+0x0/0x15 returned 0 after 159 usecs
calling  bgrt_init+0x0/0x19f @ 1
initcall bgrt_init+0x0/0x19f returned -19 after 0 usecs
calling  erst_init+0x0/0x4c7 @ 1
initcall erst_init+0x0/0x4c7 returned 0 after 66 usecs
calling  gpio_clk_driver_init+0x0/0x17 @ 1
initcall gpio_clk_driver_init+0x0/0x17 returned 0 after 67 usecs
calling  plt_clk_driver_init+0x0/0x17 @ 1
initcall plt_clk_driver_init+0x0/0x17 returned 0 after 52 usecs
calling  dw_pci_driver_init+0x0/0x1e @ 1
initcall dw_pci_driver_init+0x0/0x1e returned 0 after 71 usecs
calling  virtio_pci_driver_init+0x0/0x1e @ 1
initcall virtio_pci_driver_init+0x0/0x1e returned 0 after 63 usecs
calling  n_null_init+0x0/0x1e @ 1
initcall n_null_init+0x0/0x1e returned 0 after 1 usecs
calling  pty_init+0x0/0x11 @ 1
initcall pty_init+0x0/0x11 returned 0 after 460 usecs
calling  sysrq_init+0x0/0x4e @ 1
initcall sysrq_init+0x0/0x4e returned 0 after 12 usecs
calling  serial8250_init+0x0/0x320 @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x320 returned 0 after 18635 usecs
calling  serial_pci_driver_init+0x0/0x1e @ 1
IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:1)
0000:00:16.3: ttyS1 at I/O 0x3080 (irq = 19, base_baud = 115200) is a 16550A
initcall serial_pci_driver_init+0x0/0x1e returned 0 after 22923 usecs
calling  exar_pci_driver_init+0x0/0x1e @ 1
initcall exar_pci_driver_init+0x0/0x1e returned 0 after 70 usecs
calling  dw8250_platform_driver_init+0x0/0x17 @ 1
initcall dw8250_platform_driver_init+0x0/0x17 returned 0 after 62 usecs
calling  lpss8250_pci_driver_init+0x0/0x1e @ 1
initcall lpss8250_pci_driver_init+0x0/0x1e returned 0 after 69 usecs
calling  mid8250_pci_driver_init+0x0/0x1e @ 1
initcall mid8250_pci_driver_init+0x0/0x1e returned 0 after 121 usecs
calling  pericom8250_pci_driver_init+0x0/0x1e @ 1
initcall pericom8250_pci_driver_init+0x0/0x1e returned 0 after 74 usecs
calling  random_sysctls_init+0x0/0x26 @ 1
initcall random_sysctls_init+0x0/0x26 returned 0 after 17 usecs
calling  hpet_init+0x0/0x76 @ 1
initcall hpet_init+0x0/0x76 returned 0 after 1330 usecs
calling  nvram_module_init+0x0/0x8d @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x8d returned 0 after 5310 usecs
calling  virtio_rng_driver_init+0x0/0x15 @ 1
initcall virtio_rng_driver_init+0x0/0x15 returned 0 after 112 usecs
calling  init_tis+0x0/0x14e @ 1
tpm_tis 00:0a: 1.2 TPM (device-id 0x1B, rev-id 16)
tpm tpm0: TPM is disabled/deactivated (0x7)
initcall init_tis+0x0/0x14e returned 0 after 35889 usecs
calling  crb_acpi_driver_init+0x0/0x15 @ 1
initcall crb_acpi_driver_init+0x0/0x15 returned 0 after 266 usecs
calling  cn_proc_init+0x0/0x3e @ 1
initcall cn_proc_init+0x0/0x3e returned 0 after 100 usecs
calling  topology_sysfs_init+0x0/0x30 @ 1
initcall topology_sysfs_init+0x0/0x30 returned 0 after 482 usecs
calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 2299 usecs
calling  lkdtm_module_init+0x0/0x2a8 @ 1
lkdtm: No crash points registered, enable through debugfs
initcall lkdtm_module_init+0x0/0x2a8 returned 0 after 7590 usecs
calling  intel_lpss_init+0x0/0x21 @ 1
initcall intel_lpss_init+0x0/0x21 returned 0 after 28 usecs
calling  intel_lpss_pci_driver_init+0x0/0x1e @ 1
initcall intel_lpss_pci_driver_init+0x0/0x1e returned 0 after 93 usecs
calling  intel_lpss_acpi_driver_init+0x0/0x17 @ 1
initcall intel_lpss_acpi_driver_init+0x0/0x17 returned 0 after 71 usecs
calling  system_heap_create+0x0/0xc0 @ 1
initcall system_heap_create+0x0/0xc0 returned 0 after 498 usecs
calling  udmabuf_dev_init+0x0/0xab @ 1
initcall udmabuf_dev_init+0x0/0xab returned 0 after 411 usecs
calling  mac_hid_init+0x0/0x2d @ 1
initcall mac_hid_init+0x0/0x2d returned 0 after 47 usecs
calling  rdac_init+0x0/0x79 @ 1
rdac: device handler registered
initcall rdac_init+0x0/0x79 returned 0 after 5388 usecs
calling  hp_sw_init+0x0/0x15 @ 1
hp_sw: device handler registered
initcall hp_sw_init+0x0/0x15 returned 0 after 5093 usecs
calling  clariion_init+0x0/0x37 @ 1
emc: device handler registered
initcall clariion_init+0x0/0x37 returned 0 after 4894 usecs
calling  alua_init+0x0/0x68 @ 1
alua: device handler registered
initcall alua_init+0x0/0x68 returned 0 after 5350 usecs
calling  macsec_init+0x0/0x6e @ 1
MACsec IEEE 802.1AE
initcall macsec_init+0x0/0x6e returned 0 after 4040 usecs
calling  blackhole_netdev_init+0x0/0xcf @ 1
initcall blackhole_netdev_init+0x0/0xcf returned 0 after 699 usecs
calling  phylink_init+0x0/0xaf @ 1
initcall phylink_init+0x0/0xaf returned 0 after 0 usecs
calling  phy_module_init+0x0/0x1c @ 1
initcall phy_module_init+0x0/0x1c returned 0 after 164 usecs
calling  fixed_mdio_bus_init+0x0/0x245 @ 1
initcall fixed_mdio_bus_init+0x0/0x245 returned 0 after 1147 usecs
calling  phy_module_init+0x0/0x1c @ 1
initcall phy_module_init+0x0/0x1c returned 0 after 919 usecs
calling  vrf_init_module+0x0/0x8b @ 1
initcall vrf_init_module+0x0/0x8b returned 0 after 82 usecs
calling  cavium_ptp_driver_init+0x0/0x1e @ 1
initcall cavium_ptp_driver_init+0x0/0x1e returned 0 after 69 usecs
calling  e1000_init_module+0x0/0x7b @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
initcall e1000_init_module+0x0/0x7b returned 0 after 12336 usecs
calling  e1000_init_module+0x0/0x36 @ 1
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 3c:52:82:5d:1e:ba
e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
initcall e1000_init_module+0x0/0x36 returned 0 after 204287 usecs
calling  igb_init_module+0x0/0x44 @ 1
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
initcall igb_init_module+0x0/0x44 returned 0 after 12750 usecs
calling  igc_init_module+0x0/0x44 @ 1
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
initcall igc_init_module+0x0/0x44 returned 0 after 10884 usecs
calling  ixgbe_init_module+0x0/0xad @ 1
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
initcall ixgbe_init_module+0x0/0xad returned 0 after 14187 usecs
calling  i40e_init_module+0x0/0xb8 @ 1
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
initcall i40e_init_module+0x0/0xb8 returned 0 after 14262 usecs
calling  rtl8169_pci_driver_init+0x0/0x1e @ 1
initcall rtl8169_pci_driver_init+0x0/0x1e returned 0 after 75 usecs
calling  rtl8152_driver_init+0x0/0x1e @ 1
usbcore: registered new interface driver r8152
initcall rtl8152_driver_init+0x0/0x1e returned 0 after 6374 usecs
calling  asix_driver_init+0x0/0x1e @ 1
usbcore: registered new interface driver asix
initcall asix_driver_init+0x0/0x1e returned 0 after 6304 usecs
calling  ax88179_178a_driver_init+0x0/0x1e @ 1
usbcore: registered new interface driver ax88179_178a
initcall ax88179_178a_driver_init+0x0/0x1e returned 0 after 6982 usecs
calling  usbnet_init+0x0/0x2f @ 1
initcall usbnet_init+0x0/0x2f returned 0 after 1 usecs
calling  usbport_trig_init+0x0/0x15 @ 1
initcall usbport_trig_init+0x0/0x15 returned 0 after 63 usecs
calling  mon_init+0x0/0x1af @ 1
initcall mon_init+0x0/0x1af returned 0 after 571 usecs
calling  ehci_hcd_init+0x0/0x1a0 @ 1
initcall ehci_hcd_init+0x0/0x1a0 returned 0 after 24 usecs
calling  ehci_pci_init+0x0/0x56 @ 1
initcall ehci_pci_init+0x0/0x56 returned 0 after 80 usecs
calling  ohci_hcd_mod_init+0x0/0xa9 @ 1
initcall ohci_hcd_mod_init+0x0/0xa9 returned 0 after 21 usecs
calling  ohci_pci_init+0x0/0x56 @ 1
initcall ohci_pci_init+0x0/0x56 returned 0 after 75 usecs
calling  uhci_hcd_init+0x0/0x12f @ 1
initcall uhci_hcd_init+0x0/0x12f returned 0 after 216 usecs
calling  xhci_hcd_init+0x0/0x28 @ 1
initcall xhci_hcd_init+0x0/0x28 returned 0 after 23 usecs
calling  xhci_pci_init+0x0/0x5d @ 1
initcall xhci_pci_init+0x0/0x5d returned 0 after 119 usecs
xhci_hcd 0000:00:14.0: xHCI Host Controller
calling  ucsi_acpi_platform_driver_init+0x0/0x17 @ 1
initcall ucsi_acpi_platform_driver_init+0x0/0x17 returned 0 after 68 usecs
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
calling  i8042_init+0x0/0x139 @ 1
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
serio: i8042 KBD port at 0x60,0x64 irq 1
xhci_hcd 0000:00:14.0: xHCI Host Controller
serio: i8042 AUX port at 0x60,0x64 irq 12
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
initcall i8042_init+0x0/0x139 returned 0 after 47142 usecs
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
calling  serport_init+0x0/0x30 @ 1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.02
initcall serport_init+0x0/0x30 returned 0 after 1 usecs
calling  input_leds_init+0x0/0x15 @ 1
initcall input_leds_init+0x0/0x15 returned 0 after 3 usecs
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
calling  mousedev_init+0x0/0x63 @ 1
mousedev: PS/2 mouse device common for all mice
usb usb1: Product: xHCI Host Controller
initcall mousedev_init+0x0/0x63 returned 0 after 15965 usecs
usb usb1: Manufacturer: Linux 6.2.0-rc1-00074-g9aedeaed6fc6 xhci-hcd
calling  evdev_init+0x0/0x15 @ 1
initcall evdev_init+0x0/0x15 returned 0 after 1119 usecs
usb usb1: SerialNumber: 0000:00:14.0
hub 1-0:1.0: USB hub found
calling  atkbd_init+0x0/0x2a @ 1
hub 1-0:1.0: 16 ports detected
initcall atkbd_init+0x0/0x2a returned 0 after 164 usecs
calling  psmouse_init+0x0/0x8a @ 1
initcall psmouse_init+0x0/0x8a returned 0 after 622 usecs
calling  cmos_init+0x0/0x74 @ 1
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: registered as rtc0
rtc_cmos 00:03: setting system clock to 2023-01-19T03:21:29 UTC (1674098489)
rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
initcall cmos_init+0x0/0x74 returned 0 after 30320 usecs
calling  thermal_throttle_init_device+0x0/0x53 @ 1
initcall thermal_throttle_init_device+0x0/0x53 returned 0 after 1164 usecs
calling  esb_driver_init+0x0/0x1e @ 1
initcall esb_driver_init+0x0/0x1e returned 0 after 124 usecs
calling  iTCO_wdt_driver_init+0x0/0x17 @ 1
initcall iTCO_wdt_driver_init+0x0/0x17 returned 0 after 63 usecs
calling  iTCO_vendor_init_module+0x0/0x35 @ 1
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.02
iTCO_vendor_support: vendor-support=0
initcall iTCO_vendor_init_module+0x0/0x35 returned 0 after 3 usecs
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
calling  ghes_edac_init+0x0/0xf4 @ 1
usb usb2: Product: xHCI Host Controller
initcall ghes_edac_init+0x0/0xf4 returned -19 after 1 usecs
usb usb2: Manufacturer: Linux 6.2.0-rc1-00074-g9aedeaed6fc6 xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
calling  intel_pstate_init+0x0/0x4bc @ 1
hub 2-0:1.0: USB hub found
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
hub 2-0:1.0: 10 ports detected
initcall intel_pstate_init+0x0/0x4bc returned 0 after 20836 usecs
calling  haltpoll_init+0x0/0xf3 @ 1
initcall haltpoll_init+0x0/0xf3 returned -19 after 0 usecs
calling  dmi_sysfs_init+0x0/0x14c @ 1
initcall dmi_sysfs_init+0x0/0x14c returned 0 after 5563 usecs
calling  fw_cfg_sysfs_init+0x0/0x8a @ 1
initcall fw_cfg_sysfs_init+0x0/0x8a returned 0 after 934 usecs
calling  sysfb_init+0x0/0x124 @ 1
initcall sysfb_init+0x0/0x124 returned 0 after 1139 usecs
calling  esrt_sysfs_init+0x0/0x446 @ 1
initcall esrt_sysfs_init+0x0/0x446 returned -38 after 0 usecs
calling  efivars_pstore_init+0x0/0x9d @ 1
initcall efivars_pstore_init+0x0/0x9d returned 0 after 0 usecs
calling  hid_init+0x0/0x66 @ 1
hid: raw HID events driver (C) Jiri Kosina
initcall hid_init+0x0/0x66 returned 0 after 6818 usecs
calling  hid_generic_init+0x0/0x1e @ 1
initcall hid_generic_init+0x0/0x1e returned 0 after 60 usecs
calling  magicmouse_driver_init+0x0/0x1e @ 1
initcall magicmouse_driver_init+0x0/0x1e returned 0 after 56 usecs
calling  sensor_hub_driver_init+0x0/0x1e @ 1
initcall sensor_hub_driver_init+0x0/0x1e returned 0 after 48 usecs
calling  hid_init+0x0/0x62 @ 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
initcall hid_init+0x0/0x62 returned 0 after 11078 usecs
calling  pmc_atom_init+0x0/0x73 @ 1
initcall pmc_atom_init+0x0/0x73 returned -19 after 15 usecs
calling  sock_diag_init+0x0/0x33 @ 1
initcall sock_diag_init+0x0/0x33 returned 0 after 127 usecs
calling  init_net_drop_monitor+0x0/0x1cd @ 1
drop_monitor: Initializing network drop monitor service
initcall init_net_drop_monitor+0x0/0x1cd returned 0 after 7181 usecs
calling  llc_init+0x0/0x24 @ 1
initcall llc_init+0x0/0x24 returned 0 after 2 usecs
calling  snap_init+0x0/0x3f @ 1
initcall snap_init+0x0/0x3f returned 0 after 51 usecs
calling  blackhole_init+0x0/0x15 @ 1
initcall blackhole_init+0x0/0x15 returned 0 after 1 usecs
calling  ingress_module_init+0x0/0x43 @ 1
initcall ingress_module_init+0x0/0x43 returned 0 after 1 usecs
calling  netem_module_init+0x0/0x21 @ 1
netem: version 1.3
initcall netem_module_init+0x0/0x21 returned 0 after 3885 usecs
calling  fq_codel_module_init+0x0/0x15 @ 1
initcall fq_codel_module_init+0x0/0x15 returned 0 after 1 usecs
calling  init_cgroup_cls+0x0/0x15 @ 1
initcall init_cgroup_cls+0x0/0x15 returned 0 after 18 usecs
calling  xt_init+0x0/0x2df @ 1
initcall xt_init+0x0/0x2df returned 0 after 137 usecs
calling  tcpudp_mt_init+0x0/0x1a @ 1
initcall tcpudp_mt_init+0x0/0x1a returned 0 after 119 usecs
calling  gre_offload_init+0x0/0x52 @ 1
initcall gre_offload_init+0x0/0x52 returned 0 after 0 usecs
calling  sysctl_ipv4_init+0x0/0x50 @ 1
initcall sysctl_ipv4_init+0x0/0x50 returned 0 after 108 usecs
calling  cubictcp_register+0x0/0x72 @ 1
initcall cubictcp_register+0x0/0x72 returned 0 after 1 usecs
calling  xfrm_user_init+0x0/0x34 @ 1
Initializing XFRM netlink socket
initcall xfrm_user_init+0x0/0x34 returned 0 after 5135 usecs
calling  inet6_init+0x0/0x4a8 @ 1
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
initcall inet6_init+0x0/0x4a8 returned 0 after 17818 usecs
calling  packet_init+0x0/0x83 @ 1
NET: Registered PF_PACKET protocol family
initcall packet_init+0x0/0x83 returned 0 after 5895 usecs
calling  strp_dev_init+0x0/0x37 @ 1
initcall strp_dev_init+0x0/0x37 returned 0 after 433 usecs
calling  vlan_proto_init+0x0/0xaa @ 1
8021q: 802.1Q VLAN Support v1.8
initcall vlan_proto_init+0x0/0xaa returned 0 after 5265 usecs
calling  init_p9+0x0/0x2e @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x2e returned 0 after 5251 usecs
calling  p9_trans_fd_init+0x0/0x30 @ 1
initcall p9_trans_fd_init+0x0/0x30 returned 0 after 27 usecs
calling  p9_virtio_init+0x0/0x52 @ 1
initcall p9_virtio_init+0x0/0x52 returned 0 after 174 usecs
calling  dcbnl_init+0x0/0x54 @ 1
initcall dcbnl_init+0x0/0x54 returned 0 after 14 usecs
calling  mpls_gso_init+0x0/0x30 @ 1
mpls_gso: MPLS GSO support
initcall mpls_gso_init+0x0/0x30 returned 0 after 4538 usecs
calling  nsh_init_module+0x0/0x18 @ 1
initcall nsh_init_module+0x0/0x18 returned 0 after 1 usecs
calling  pm_check_save_msr+0x0/0x70 @ 1
initcall pm_check_save_msr+0x0/0x70 returned 0 after 27 usecs
calling  plist_test+0x0/0x34b @ 1
start plist test
end plist test
initcall plist_test+0x0/0x34b returned 0 after 8681 usecs
calling  mcheck_init_device+0x0/0x20c @ 1
initcall mcheck_init_device+0x0/0x20c returned 0 after 1746 usecs
calling  dev_mcelog_init_device+0x0/0x160 @ 1
initcall dev_mcelog_init_device+0x0/0x160 returned 0 after 343 usecs
calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x26 @ 1
initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x26 returned 0 after 10 usecs
calling  tboot_late_init+0x0/0x22f @ 1
initcall tboot_late_init+0x0/0x22f returned 0 after 0 usecs
calling  sld_mitigate_sysctl_init+0x0/0x26 @ 1
initcall sld_mitigate_sysctl_init+0x0/0x26 returned 0 after 7 usecs
calling  mcheck_late_init+0x0/0x41 @ 1
initcall mcheck_late_init+0x0/0x41 returned 0 after 107 usecs
calling  severities_debugfs_init+0x0/0x2e @ 1
initcall severities_debugfs_init+0x0/0x2e returned 0 after 27 usecs
calling  microcode_init+0x0/0x246 @ 1
microcode: Microcode Update Driver: v2.2.
initcall microcode_init+0x0/0x246 returned 0 after 556 usecs
calling  resctrl_late_init+0x0/0x6e0 @ 1
initcall resctrl_late_init+0x0/0x6e0 returned -19 after 1 usecs
calling  hpet_insert_resource+0x0/0x27 @ 1
initcall hpet_insert_resource+0x0/0x27 returned 0 after 2 usecs
calling  start_sync_check_timer+0x0/0xb7 @ 1
initcall start_sync_check_timer+0x0/0xb7 returned 0 after 1 usecs
calling  update_mp_table+0x0/0x575 @ 1
initcall update_mp_table+0x0/0x575 returned 0 after 0 usecs
calling  lapic_insert_resource+0x0/0x47 @ 1
initcall lapic_insert_resource+0x0/0x47 returned 0 after 2 usecs
calling  print_ipi_mode+0x0/0x31 @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x31 returned 0 after 5067 usecs
calling  print_ICs+0x0/0x1d7 @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
000000000000000c000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000008001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0001), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(60), IRR(0), S(0), physical, D(0001), M(2)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin08, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0004), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(23), IRR(0), S(0), physical, D(0052), M(2)
pin0c, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0008), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0418), M(2)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(4000), M(2)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin26, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2c, disabled, edge , high, V(02), IRR(0), S(0), physical, D(2083), M(2)
pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(2)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin47, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin48, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0800), M(2)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(1508), M(2)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin67, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin70, disabled, edge , high, V(00), IRR(0), S(0), physical, D(1100), M(2)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0082), M(2)
pin74, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(0100),  Z(2)
pin77, disabled, edge , high, V(02), IRR(0), S(0), remapped, I(1040),  Z(2)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
.................................... done.
initcall print_ICs+0x0/0x1d7 returned 0 after 1246009 usecs
calling  setup_efi_kvm_sev_migration+0x0/0x28c @ 1
initcall setup_efi_kvm_sev_migration+0x0/0x28c returned 0 after 0 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x53 @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x53 returned 0 after 93 usecs
calling  pat_memtype_list_init+0x0/0x5c @ 1
initcall pat_memtype_list_init+0x0/0x5c returned 0 after 26 usecs
calling  create_init_pkru_value+0x0/0x58 @ 1
initcall create_init_pkru_value+0x0/0x58 returned 0 after 0 usecs
calling  aesni_init+0x0/0x223 @ 1
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
initcall aesni_init+0x0/0x223 returned 0 after 11467 usecs
calling  kernel_panic_sysctls_init+0x0/0x26 @ 1
initcall kernel_panic_sysctls_init+0x0/0x26 returned 0 after 12 usecs
calling  kernel_panic_sysfs_init+0x0/0x47 @ 1
initcall kernel_panic_sysfs_init+0x0/0x47 returned 0 after 61 usecs
calling  kernel_exit_sysctls_init+0x0/0x26 @ 1
initcall kernel_exit_sysctls_init+0x0/0x26 returned 0 after 10 usecs
calling  kernel_exit_sysfs_init+0x0/0x47 @ 1
initcall kernel_exit_sysfs_init+0x0/0x47 returned 0 after 9 usecs
calling  param_sysfs_builtin_init+0x0/0x96 @ 1
initcall param_sysfs_builtin_init+0x0/0x96 returned 0 after 30957 usecs
calling  reboot_ksysfs_init+0x0/0x94 @ 1
initcall reboot_ksysfs_init+0x0/0x94 returned 0 after 94 usecs
calling  sched_core_sysctl_init+0x0/0x2b @ 1
initcall sched_core_sysctl_init+0x0/0x2b returned 0 after 9 usecs
calling  sched_fair_sysctl_init+0x0/0x26 @ 1
initcall sched_fair_sysctl_init+0x0/0x26 returned 0 after 9 usecs
calling  sched_rt_sysctl_init+0x0/0x26 @ 1
initcall sched_rt_sysctl_init+0x0/0x26 returned 0 after 9 usecs
calling  sched_dl_sysctl_init+0x0/0x26 @ 1
initcall sched_dl_sysctl_init+0x0/0x26 returned 0 after 8 usecs
calling  sched_clock_init_late+0x0/0x138 @ 1
sched_clock: Marking stable (15536415996, 841992986)->(17462938192, -1084529210)
initcall sched_clock_init_late+0x0/0x138 returned 0 after 9460 usecs
calling  sched_init_debug+0x0/0x257 @ 1
initcall sched_init_debug+0x0/0x257 returned 0 after 1414 usecs
calling  kernel_lockdep_sysctls_init+0x0/0x21 @ 1
initcall kernel_lockdep_sysctls_init+0x0/0x21 returned 0 after 10 usecs
calling  cpu_latency_qos_init+0x0/0x3e @ 1
initcall cpu_latency_qos_init+0x0/0x3e returned 0 after 311 usecs
calling  pm_debugfs_init+0x0/0x28 @ 1
initcall pm_debugfs_init+0x0/0x28 returned 0 after 38 usecs
calling  printk_late_init+0x0/0x226 @ 1
initcall printk_late_init+0x0/0x226 returned 0 after 20 usecs
calling  rcu_verify_early_boot_tests+0x0/0x70 @ 1
initcall rcu_verify_early_boot_tests+0x0/0x70 returned 0 after 0 usecs
calling  rcu_tasks_verify_schedule_work+0x0/0x90 @ 1
initcall rcu_tasks_verify_schedule_work+0x0/0x90 returned 0 after 1 usecs
calling  init_srcu_module_notifier+0x0/0x30 @ 1
initcall init_srcu_module_notifier+0x0/0x30 returned 0 after 2 usecs
calling  swiotlb_create_default_debugfs+0x0/0x6c @ 1
initcall swiotlb_create_default_debugfs+0x0/0x6c returned 0 after 62 usecs
calling  tk_debug_sleep_time_init+0x0/0x28 @ 1
initcall tk_debug_sleep_time_init+0x0/0x28 returned 0 after 20 usecs
calling  bpf_ksym_iter_register+0x0/0x1f @ 1
initcall bpf_ksym_iter_register+0x0/0x1f returned 0 after 7 usecs
calling  kernel_acct_sysctls_init+0x0/0x26 @ 1
initcall kernel_acct_sysctls_init+0x0/0x26 returned 0 after 11 usecs
calling  kexec_core_sysctl_init+0x0/0x26 @ 1
initcall kexec_core_sysctl_init+0x0/0x26 returned 0 after 8 usecs
calling  bpf_rstat_kfunc_init+0x0/0x1a @ 1
initcall bpf_rstat_kfunc_init+0x0/0x1a returned 0 after 0 usecs
calling  debugfs_kprobe_init+0x0/0x78 @ 1
initcall debugfs_kprobe_init+0x0/0x78 returned 0 after 79 usecs
calling  kernel_delayacct_sysctls_init+0x0/0x26 @ 1
initcall kernel_delayacct_sysctls_init+0x0/0x26 returned 0 after 9 usecs
calling  taskstats_init+0x0/0x3f @ 1
registered taskstats version 1
initcall taskstats_init+0x0/0x3f returned 0 after 4978 usecs
calling  ftrace_sysctl_init+0x0/0x21 @ 1
initcall ftrace_sysctl_init+0x0/0x21 returned 0 after 9 usecs
calling  init_hwlat_tracer+0x0/0x116 @ 1
initcall init_hwlat_tracer+0x0/0x116 returned 0 after 533 usecs
calling  bpf_key_sig_kfuncs_init+0x0/0x15 @ 1
initcall bpf_key_sig_kfuncs_init+0x0/0x15 returned 0 after 0 usecs
calling  bpf_global_ma_init+0x0/0x23 @ 1
initcall bpf_global_ma_init+0x0/0x23 returned 0 after 318 usecs
calling  bpf_syscall_sysctl_init+0x0/0x26 @ 1
initcall bpf_syscall_sysctl_init+0x0/0x26 returned 0 after 57 usecs
calling  kfunc_init+0x0/0xf8 @ 1
initcall kfunc_init+0x0/0xf8 returned 0 after 1 usecs
calling  bpf_map_iter_init+0x0/0x30 @ 1
initcall bpf_map_iter_init+0x0/0x30 returned 0 after 199 usecs
calling  task_iter_init+0x0/0x2d5 @ 1
initcall task_iter_init+0x0/0x2d5 returned 0 after 12 usecs
calling  bpf_prog_iter_init+0x0/0x1f @ 1
initcall bpf_prog_iter_init+0x0/0x1f returned 0 after 3 usecs
calling  bpf_link_iter_init+0x0/0x1f @ 1
initcall bpf_link_iter_init+0x0/0x1f returned 0 after 4 usecs
calling  init_trampolines+0x0/0x6a @ 1
initcall init_trampolines+0x0/0x6a returned 0 after 1 usecs
calling  bpf_cgroup_iter_init+0x0/0x21 @ 1
initcall bpf_cgroup_iter_init+0x0/0x21 returned 0 after 4 usecs
calling  load_system_certificate_list+0x0/0x55 @ 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 3718f447b7bcb2f6a7cbf49796e22ef8fb07b12f'
initcall load_system_certificate_list+0x0/0x55 returned 0 after 17984 usecs
calling  fault_around_debugfs+0x0/0x28 @ 1
initcall fault_around_debugfs+0x0/0x28 returned 0 after 27 usecs
calling  max_swapfiles_check+0x0/0xc @ 1
initcall max_swapfiles_check+0x0/0xc returned 0 after 0 usecs
calling  init_zswap+0x0/0x3ad @ 1
zswap: loaded using pool lzo/zbud
initcall init_zswap+0x0/0x3ad returned 0 after 6616 usecs
calling  hugetlb_vmemmap_init+0x0/0x130 @ 1
initcall hugetlb_vmemmap_init+0x0/0x130 returned 0 after 10 usecs
calling  slab_sysfs_init+0x0/0xf4 @ 1
initcall slab_sysfs_init+0x0/0xf4 returned 0 after 41808 usecs
calling  kasan_cpu_quarantine_init+0x0/0x48 @ 1
initcall kasan_cpu_quarantine_init+0x0/0x48 returned 219 after 197 usecs
calling  split_huge_pages_debugfs+0x0/0x28 @ 1
initcall split_huge_pages_debugfs+0x0/0x28 returned 0 after 67 usecs
calling  gup_test_init+0x0/0x28 @ 1
initcall gup_test_init+0x0/0x28 returned 0 after 21 usecs
calling  pageowner_init+0x0/0x38 @ 1
page_owner is disabled
initcall pageowner_init+0x0/0x38 returned 0 after 4219 usecs
calling  check_early_ioremap_leak+0x0/0x89 @ 1
initcall check_early_ioremap_leak+0x0/0x89 returned 0 after 0 usecs
calling  set_hardened_usercopy+0x0/0x24 @ 1
initcall set_hardened_usercopy+0x0/0x24 returned 1 after 0 usecs
calling  fscrypt_init+0x0/0xbc @ 1
Key type .fscrypt registered
Key type fscrypt-provisioning registered
initcall fscrypt_init+0x0/0xbc returned 0 after 11267 usecs
calling  pstore_init+0x0/0x81 @ 1
initcall pstore_init+0x0/0x81 returned 0 after 12 usecs
calling  init_root_keyring+0x0/0x12 @ 1
initcall init_root_keyring+0x0/0x12 returned 0 after 258 usecs
calling  init_trusted+0x0/0x256 @ 1
Freeing initrd memory: 710664K
Key type trusted registered
initcall init_trusted+0x0/0x256 returned 0 after 18734325 usecs
calling  init_encrypted+0x0/0x151 @ 1
Key type encrypted registered
initcall init_encrypted+0x0/0x151 returned 0 after 31946 usecs
calling  integrity_fs_init+0x0/0x52 @ 1
initcall integrity_fs_init+0x0/0x52 returned 0 after 26 usecs
calling  crypto_algapi_init+0x0/0x11 @ 1
initcall crypto_algapi_init+0x0/0x11 returned 0 after 9 usecs
calling  blk_timeout_init+0x0/0x17 @ 1
initcall blk_timeout_init+0x0/0x17 returned 0 after 0 usecs
calling  init_error_injection+0x0/0x6e @ 1
initcall init_error_injection+0x0/0x6e returned 0 after 2702 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x1c @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x1c returned 0 after 11 usecs
calling  pci_sysfs_init+0x0/0x72 @ 1
initcall pci_sysfs_init+0x0/0x72 returned 0 after 307 usecs
calling  bert_init+0x0/0x653 @ 1
initcall bert_init+0x0/0x653 returned 0 after 4 usecs
calling  clk_debug_init+0x0/0x13b @ 1
initcall clk_debug_init+0x0/0x13b returned 0 after 110 usecs
calling  dmar_free_unused_resources+0x0/0x194 @ 1
initcall dmar_free_unused_resources+0x0/0x194 returned 0 after 6 usecs
calling  sync_state_resume_initcall+0x0/0x20 @ 1
initcall sync_state_resume_initcall+0x0/0x20 returned 0 after 1 usecs
calling  deferred_probe_initcall+0x0/0xd0 @ 1
initcall deferred_probe_initcall+0x0/0xd0 returned 0 after 278 usecs
calling  sync_debugfs_init+0x0/0x5f @ 1
initcall sync_debugfs_init+0x0/0x5f returned 0 after 128 usecs
calling  firmware_memmap_init+0x0/0x5e @ 1
initcall firmware_memmap_init+0x0/0x5e returned 0 after 636 usecs
calling  register_update_efi_random_seed+0x0/0x22 @ 1
initcall register_update_efi_random_seed+0x0/0x22 returned 0 after 0 usecs
calling  efi_shutdown_init+0x0/0x78 @ 1
initcall efi_shutdown_init+0x0/0x78 returned -19 after 12 usecs
calling  efi_earlycon_unmap_fb+0x0/0x65 @ 1
initcall efi_earlycon_unmap_fb+0x0/0x65 returned 0 after 12 usecs
calling  itmt_legacy_init+0x0/0x4d @ 1
initcall itmt_legacy_init+0x0/0x4d returned -19 after 0 usecs
calling  bpf_sockmap_iter_init+0x0/0x55 @ 1
initcall bpf_sockmap_iter_init+0x0/0x55 returned 0 after 4 usecs
calling  bpf_sk_storage_map_iter_init+0x0/0x55 @ 1
initcall bpf_sk_storage_map_iter_init+0x0/0x55 returned 0 after 6 usecs
calling  sch_default_qdisc+0x0/0x15 @ 1
initcall sch_default_qdisc+0x0/0x15 returned 0 after 2 usecs
calling  bpf_prog_test_run_init+0x0/0xf6 @ 1
initcall bpf_prog_test_run_init+0x0/0xf6 returned 0 after 0 usecs
calling  tcp_congestion_default+0x0/0x1c @ 1
initcall tcp_congestion_default+0x0/0x1c returned 0 after 1 usecs
calling  ip_auto_config+0x0/0x816 @ 1
e1000e 0000:00:1f.6 eth0: NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
e1000e 0000:00:1f.6 eth0: 10/100 speed: disabling TSO
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.3.1, my address is 192.168.3.101
IP-Config: Complete:
device=eth0, hwaddr=3c:52:82:5d:1e:ba, ipaddr=192.168.3.101, mask=255.255.255.0, gw=192.168.3.200
host=lkp-skl-d06, domain=lkp.intel.com, nis-domain=(none)
bootserver=192.168.3.200, rootserver=192.168.3.200, rootpath=
nameserver0=192.168.3.200
initcall ip_auto_config+0x0/0x816 returned 0 after 1821594 usecs
calling  tcp_bpf_v4_build_proto+0x0/0xef @ 1
initcall tcp_bpf_v4_build_proto+0x0/0xef returned 0 after 0 usecs
calling  udp_bpf_v4_build_proto+0x0/0x9d @ 1
initcall udp_bpf_v4_build_proto+0x0/0x9d returned 0 after 0 usecs
calling  bpf_tcp_ca_kfunc_init+0x0/0x1a @ 1
initcall bpf_tcp_ca_kfunc_init+0x0/0x1a returned 0 after 0 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xb9 @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xb9 returned 0 after 2 usecs
calling  software_resume+0x0/0x40 @ 1
initcall software_resume+0x0/0x40 returned -2 after 21 usecs
calling  ftrace_check_sync+0x0/0x18 @ 1
initcall ftrace_check_sync+0x0/0x18 returned 0 after 101 usecs
calling  latency_fsnotify_init+0x0/0x3c @ 1
initcall latency_fsnotify_init+0x0/0x3c returned 0 after 548 usecs
calling  trace_eval_sync+0x0/0x18 @ 1
initcall trace_eval_sync+0x0/0x18 returned 0 after 55 usecs
calling  late_trace_init+0x0/0xa0 @ 1
initcall late_trace_init+0x0/0xa0 returned 0 after 0 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xb9 @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xb9 returned 0 after 337 usecs
calling  fb_logo_late_init+0x0/0x13 @ 1
initcall fb_logo_late_init+0x0/0x13 returned 0 after 0 usecs
calling  clk_disable_unused+0x0/0x190 @ 1
initcall clk_disable_unused+0x0/0x190 returned 0 after 17 usecs
Freeing unused kernel image (initmem) memory: 3076K
Write protecting the kernel read-only data: 53248k
Freeing unused kernel image (rodata/data gap) memory: 816K
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6
branch=tip/sched/core
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 47 usecs


Star[   39.016592][  T109] fuse: init (API version 7.38)
d Kernel Module [   39.046897][  T107] ACPI: bus type drm_connector registered
[   39.048729][  T107] initcall drm_core_init+0x0/0xe3 [drm] returned 0 after 1965 usecs
calling  init_misc_binfmt+0x0/0x1000 [binfmt_misc] @ 141
initcall init_misc_binfmt+0x0/0x1000 [binfmt_misc] returned 0 after 6 usecs
calling  tpm_inf_pnp_driver_init+0x0/0x1000 [tpm_infineon] @ 145
0m] Reached targ[   40.310755][  T165] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 165
initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 16722 usecs
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
calling  pmc_core_driver_init+0x0/0x1000 [intel_pmc_core] @ 156
calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 163
intel_pmc_core INT33A1:00:  initialized
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 154
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
acpi PNP0C14:02: duplicate WMI GUID 2B814318-4BE8-4707-9D84-A190A859B5D0 (first instance was on PNP0C14:00)
acpi PNP0C14:02: duplicate WMI GUID 41227C2D-80E1-423F-8B8E-87E32755A0EB (first instance was on PNP0C14:00)
wmi_bus wmi_bus-PNP0C14:02: WQZZ data block query control method not found
initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 57474 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 130
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
calling  intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] @ 165
calling  acpi_video_init+0x0/0x1000 [video] @ 163
initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 18 usecs
IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:1)
initcall mei_init+0x0/0xb7 [mei] returned 0 after 18225 usecs
calling  ata_init+0x0/0x8a [libata] @ 145
initcall intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] returned 0 after 26911 usecs
libata version 3.00 loaded.
initcall ata_init+0x0/0x8a [libata] returned 0 after 17488 usecs
calling  ie31200_init+0x0/0x1000 [ie31200_edac] @ 156
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 160
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
calling  smbalert_driver_init+0x0/0x1000 [i2c_smbus] @ 159
initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 17230 usecs
EDAC MC0: Giving out device to module ie31200_edac controller IE31200: DEV 0000:00:00.0 (POLLED)
initcall ie31200_init+0x0/0x1000 [ie31200_edac] returned 0 after 21590 usecs
initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 39139 usecs
calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 145
initcall smbalert_driver_init+0x0/0x1000 [i2c_smbus] returned 0 after 62621 usecs
calling  intel_uncore_init+0x0/0x39e [intel_uncore] @ 163
ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
etadata Check Sn[   40.828156][  T161] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl RAID mode
ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part ems deso sadm sds apst 
initcall intel_uncore_init+0x0/0x39e [intel_uncore] returned 0 after 33261 usecs
initcall drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] returned 0 after 33723 usecs
calling  i2c_i801_init+0x0/0x1000 [i2c_i801] @ 159
calling  drm_buddy_module_init+0x0/0x1000 [drm_buddy] @ 129
initcall drm_buddy_module_init+0x0/0x1000 [drm_buddy] returned 0 after 372 usecs
calling  cstate_pmu_init+0x0/0x1000 [intel_cstate] @ 163
i801_smbus 0000:00:1f.4: SPD Write Disable is set
i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000
pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
pci 0000:00:1f.1: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 34
pci 0000:00:1f.1: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
initcall i2c_i801_init+0x0/0x1000 [i2c_i801] returned 0 after 50608 usecs
iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
calling  ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] @ 194
i2c i2c-0: 3/4 memory slots populated (from DMI)
initcall cstate_pmu_init+0x0/0x1000 [intel_cstate] returned 0 after 74605 usecs
IPMI message handler: version 39.2
i2c i2c-0: Successfully instantiated SPD at 0x51
initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 14569 usecs
i2c i2c-0: Successfully instantiated SPD at 0x52
scsi host0: ahci
calling  rapl_pmu_init+0x0/0xf0a [rapl] @ 153
initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 19389 usecs
calling  wmi_bmof_driver_init+0x0/0x1000 [wmi_bmof] @ 144
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 162
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
calling  mei_wdt_driver_init+0x0/0x1000 [mei_wdt] @ 130
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
initcall rapl_pmu_init+0x0/0xf0a [rapl] returned 0 after 25947 usecs
...
Startin[   41.287054][  T145] scsi host2: ahci
initcall mei_wdt_driver_init+0x0/0x1000 [mei_wdt] returned 0 after 100089 usecs
ernel image with[   41.340711][  T145] ata1: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c100 irq 123
ata2: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c180 irq 123
ata3: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c200 irq 123
ata4: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c280 irq 123
initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 153800 usecs
calling  init_ipmi_si+0x0/0x296 [ipmi_si] @ 209
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
initcall init_ipmi_si+0x0/0x296 [ipmi_si] returned -19 after 12684 usecs
calling  sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] @ 153
initcall sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] returned 0 after 29 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 167
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
LKP: ttyS0: 256: current_version: f0, target_ve[   41.760355][  T129] calling  i915_init+0x0/0x161 [i915] @ 129
rsion: f0
calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 168
LKP: ttyS0: 256: skip deploy intel ucode as ucod[   41.782263][  T168] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 4878 usecs
e is same
Console: switching to colour dummy device 80x25
[0m.
i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
See 'systemctl status openipmi.service' for deta[   41.893183][  T163] calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 163
ils.
initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 22 usecs
calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 166
initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 11 usecs
LKP: ttyS0: 256: Kernel tests: Boot OK!
LKP: ttyS0: 256: HOSTNAME lkp-skl-d06, MAC 3c:52:82:5d:1e:ba, kernel 6.2.0-rc1-00074-g9aedeaed6fc6 1
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] failed to retrieve link info, disabling eDP
ata1.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max UDMA/133
ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
[drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EARS-00Y 0A80 PQ: 0 ANSI: 5
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
initcall i915_init+0x0/0x161 [i915] returned 0 after 586381 usecs
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata2.00: ATA-9: INTEL SSDSC2BB012T4, G2010036, max UDMA/133
ata2.00: 2344225968 sectors, multi 1: LBA48 NCQ (depth 32)
ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB01 0036 PQ: 0 ANSI: 5
ata3: SATA link down (SStatus 4 SControl 300)
ata4: SATA link down (SStatus 4 SControl 300)
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 168
initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 1697 usecs
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
calling  init_sg+0x0/0x1000 [sg] @ 162
scsi 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 0
initcall init_sg+0x0/0x1000 [sg] returned 0 after 103813 usecs
calling  crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] @ 159
calling  kvm_x86_init+0x0/0x11 [kvm] @ 168
initcall kvm_x86_init+0x0/0x11 [kvm] returned 0 after 1 usecs
calling  crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] @ 397
initcall crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] returned 0 after 23 usecs
calling  vmx_init+0x0/0x26f [kvm_intel] @ 168
initcall crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] returned 0 after 13762 usecs
calling  init_sd+0x0/0x1000 [sd_mod] @ 159
initcall vmx_init+0x0/0x26f [kvm_intel] returned 0 after 8792 usecs
initcall init_sd+0x0/0x1000 [sd_mod] returned 0 after 18597 usecs
ata2.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 1:0:0:0: [sdb] 2344225968 512-byte logical blocks: (1.20 TB/1.09 TiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sdb] 4096-byte physical blocks
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
calling  coretemp_init+0x0/0x1000 [coretemp] @ 168
sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 22561 usecs
ata2.00: Enabling discard_zeroes_data
calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 163
sdb: sdb1 sdb2
initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 4366 usecs
sd 1:0:0:0: [sdb] Attached SCSI disk
sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 166
initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 41511 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 166
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 163
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 2 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 166
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 181 usecs
calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 419
initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 776 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 168
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 163
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 138 usecs
calling  init_module+0x0/0x1000 [raid6_pq] @ 419
raid6: avx2x4   gen() 30647 MB/s
raid6: avx2x2   gen() 29540 MB/s
raid6: avx2x1   gen() 23286 MB/s
raid6: using algorithm avx2x4 gen() 30647 MB/s
raid6: .... xor() 11143 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 99976 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 153
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 2 usecs
calling  rapl_init+0x0/0x1000 [intel_rapl_common] @ 166
calling  calibrate_xor_blocks+0x0/0xeae [xor] @ 420
initcall rapl_init+0x0/0x1000 [intel_rapl_common] returned 0 after 4369 usecs
xor: automatically using best checksumming function   avx       
initcall calibrate_xor_blocks+0x0/0xeae [xor] returned 0 after 4 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 168
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 153 usecs
calling  blake2b_mod_init+0x0/0x1000 [blake2b_generic] @ 420
initcall blake2b_mod_init+0x0/0x1000 [blake2b_generic] returned 0 after 331 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 153
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 143 usecs
calling  intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] @ 159
intel_rapl_common: Found RAPL domain package
calling  init_btrfs_fs+0x0/0x1e2 [btrfs] @ 419
intel_rapl_common: Found RAPL domain core
Btrfs loaded, crc32c=crc32c-intel, zoned=no, fsverity=no
intel_rapl_common: Found RAPL domain uncore
initcall init_btrfs_fs+0x0/0x1e2 [btrfs] returned 0 after 13503 usecs
intel_rapl_common: Found RAPL domain dram
initcall intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] returned 0 after 42041 usecs
BTRFS: device fsid d55d7a8b-1de5-425d-a4f4-c20d78b40a6b devid 1 transid 18465 /dev/sdb1 scanned by systemd-udevd (143)
BTRFS: device fsid 620c5088-9233-44b5-b8f3-c0b6df2acb29 devid 1 transid 91 /dev/sdb2 scanned by systemd-udevd (162)
BTRFS: device fsid 5386c76c-c4d1-423d-84f3-6165e2069a30 devid 1 transid 83 /dev/sda1 scanned by systemd-udevd (157)
BTRFS: device fsid 4feffc13-1a32-4f06-9d95-cce44c499ac2 devid 1 transid 8 /dev/sda2 scanned by systemd-udevd (128)
lkp: kernel tainted state: 0

LKP: stdout: 256: Kernel tests: Boot OK!

LKP: stdout: 256: HOSTNAME lkp-skl-d06, MAC 3c:52:82:5d:1e:ba, kernel 6.2.0-rc1-00074-g9aedeaed6fc6 1

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/gcc-12-base_12.2.0-13_amd64.deb

/opt/deb/libgcc-s1_12.2.0-13_amd64.deb

/opt/deb/python3-minimal_3.10.6-3+b1_amd64.deb

/opt/deb/python3_3.10.6-3+b1_amd64.deb

/opt/deb/python3.10_3.10.9-1_amd64.deb

/opt/deb/libpython3.10-stdlib_3.10.9-1_amd64.deb

/opt/deb/python3.10-minimal_3.10.9-1_amd64.deb

/opt/deb/libpython3.10-minimal_3.10.9-1_amd64.deb

/opt/deb/libpython3-stdlib_3.10.6-3+b1_amd64.deb

/opt/deb/openvswitch-common_3.1.0~git20221212.739bcf2-3_amd64.deb

/opt/deb/python3-netifaces_0.11.0-2_amd64.deb

/opt/deb/python3-sortedcontainers_2.4.0-2_all.deb

/opt/deb/python3-openvswitch_3.1.0~git20221212.739bcf2-3_amd64.deb

/opt/deb/uuid-runtime_2.38.1-4_amd64.deb

/opt/deb/openvswitch-switch_3.1.0~git20221212.739bcf2-3_amd64.deb

/opt/deb/libattr1_1%3a2.5.1-3_amd64.deb

/opt/deb/traceroute_1%3a2.1.1-1_amd64.deb

/opt/deb/attr_1%3a2.5.1-3_amd64.deb

/opt/deb/ebtables_2.0.11-5_amd64.deb

/opt/deb/libatomic1_12.2.0-13_amd64.deb

/opt/deb/libquadmath0_12.2.0-13_amd64.deb

/opt/deb/libgcc-12-dev_12.2.0-13_amd64.deb

/opt/deb/gcc-12_12.2.0-13_amd64.deb

/opt/deb/gcc_4%3a12.2.0-2+b1_amd64.deb

/opt/deb/g++-12_12.2.0-13_amd64.deb

/opt/deb/g++_4%3a12.2.0-2+b1_amd64.deb

/opt/deb/gcc-11-base_11.3.0-8_amd64.deb

/opt/deb/lib32gcc-s1_12.2.0-13_amd64.deb

/opt/deb/libx32gcc-s1_12.2.0-13_amd64.deb

/opt/deb/lib32atomic1_12.2.0-13_amd64.deb

/opt/deb/libx32atomic1_12.2.0-13_amd64.deb

/opt/deb/lib32quadmath0_12.2.0-13_amd64.deb

/opt/deb/libx32quadmath0_12.2.0-13_amd64.deb

/opt/deb/lib32gcc-12-dev_12.2.0-13_amd64.deb

/opt/deb/libx32gcc-12-dev_12.2.0-13_amd64.deb

/opt/deb/gcc-12-multilib_12.2.0-13_amd64.deb

/opt/deb/gcc-multilib_4%3a12.2.0-2+b1_amd64.deb

/opt/deb/libasound2-data_1.2.8-1_all.deb

/opt/deb/libdeflate0_1.14-1_amd64.deb

/opt/deb/libpython3.10_3.10.9-1_amd64.deb

/opt/deb/libwireshark-data_4.0.2-1_all.deb

/opt/deb/python3-pkg-resources_65.5.0-1.1_all.deb

/opt/deb/python3-pygments_2.13.0+dfsg-1_all.deb

/opt/deb/python3-yaml_6.0-3+b1_amd64.deb

/opt/deb/netcat-openbsd_1.219-1_amd64.deb

/opt/deb/python3-roman_3.3-3_all.deb

/opt/deb/python3-docutils_0.17.1+dfsg-3_all.deb

/opt/deb/python3-scapy_2.4.5+g9420c22-2_all.deb

/opt/deb/socat_1.7.4.4-2_amd64.deb

/opt/deb/tcpdump_4.99.2-1_amd64.deb

(Reading database ... 16792 files and directories currently installed.)

Preparing to unpack .../gcc-12-base_12.2.0-13_amd64.deb ...

Unpacking gcc-12-base:amd64 (12.2.0-13) over (12.2.0-9) ...

Preparing to unpack .../libgcc-s1_12.2.0-13_amd64.deb ...

Unpacking libgcc-s1:amd64 (12.2.0-13) over (12.2.0-9) ...

Preparing to unpack .../python3-minimal_3.10.6-3+b1_amd64.deb ...

Unpacking python3-minimal (3.10.6-3+b1) over (3.10.6-1) ...

Preparing to unpack .../python3_3.10.6-3+b1_amd64.deb ...

running python pre-rtupdate hooks for python3.10...

Unpacking python3 (3.10.6-3+b1) over (3.10.6-1) ...

Preparing to unpack .../python3.10_3.10.9-1_amd64.deb ...

Unpacking python3.10 (3.10.9-1) over (3.10.8-3) ...

Preparing to unpack .../libpython3.10-stdlib_3.10.9-1_amd64.deb ...

Unpacking libpython3.10-stdlib:amd64 (3.10.9-1) over (3.10.8-3) ...

Preparing to unpack .../python3.10-minimal_3.10.9-1_amd64.deb ...

Unpacking python3.10-minimal (3.10.9-1) over (3.10.8-3) ...

Preparing to unpack .../libpython3.10-minimal_3.10.9-1_amd64.deb ...

Unpacking libpython3.10-minimal:amd64 (3.10.9-1) over (3.10.8-3) ...

Preparing to unpack .../libpython3-stdlib_3.10.6-3+b1_amd64.deb ...

Unpacking libpython3-stdlib:amd64 (3.10.6-3+b1) over (3.10.6-1) ...

Selecting previously unselected package openvswitch-common.

Preparing to unpack .../openvswitch-common_3.1.0~git20221212.739bcf2-3_amd64.deb ...

Unpacking openvswitch-common (3.1.0~git20221212.739bcf2-3) ...

Selecting previously unselected package python3-netifaces:amd64.

Preparing to unpack .../python3-netifaces_0.11.0-2_amd64.deb ...

0m] Listening on[   62.418203][  T286] 

Preparing to unpack .../python3-sortedcontainers_2.4.0-2_all.deb ...

Unpacking python3-sortedcontainers (2.4.0-2) ...

Selecting previously unselected package python3-openvswitch.

Preparing to unpack .../python3-openvswitch_3.1.0~git20221212.739bcf2-3_amd64.deb ...

Unpacking python3-openvswitch (3.1.0~git20221212.739bcf2-3) ...

Selecting previously unselected package uuid-runtime.

Preparing to unpack .../uuid-runtime_2.38.1-4_amd64.deb ...

Unpacking uuid-runtime (2.38.1-4) ...

Selecting previously unselected package openvswitch-switch.

Preparing to unpack .../openvswitch-switch_3.1.0~git20221212.739bcf2-3_amd64.deb ...

Unpacking openvswitch-switch (3.1.0~git20221212.739bcf2-3) ...

Preparing to unpack .../libattr1_1%3a2.5.1-3_amd64.deb ...

Unpacking libattr1:amd64 (1:2.5.1-3) over (1:2.5.1-1) ...

Selecting previously unselected package traceroute.

Preparing to unpack .../traceroute_1%3a2.1.1-1_amd64.deb ...

Unpacking traceroute (1:2.1.1-1) ...

Selecting previously unselected package attr.

Preparing to unpack .../deb/attr_1%3a2.5.1-3_amd64.deb ...

Unpacking attr (1:2.5.1-3) ...

Selecting previously unselected package ebtables.

Preparing to unpack .../ebtables_2.0.11-5_amd64.deb ...

Unpacking ebtables (2.0.11-5) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_12.2.0-13_amd64.deb ...

Unpacking libatomic1:amd64 (12.2.0-13) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_12.2.0-13_amd64.deb ...

Unpacking libquadmath0:amd64 (12.2.0-13) ...

Selecting previously unselected package libgcc-12-dev:amd64.

Preparing to unpack .../libgcc-12-dev_12.2.0-13_amd64.deb ...

Unpacking libgcc-12-dev:amd64 (12.2.0-13) ...

Selecting previously unselected package gcc-12.

Preparing to unpack .../deb/gcc-12_12.2.0-13_amd64.deb ...

Unpacking gcc-12 (12.2.0-13) ...

Selecting previously unselected package gcc.

Preparing to unpack .../gcc_4%3a12.2.0-2+b1_amd64.deb ...

Unpacking gcc (4:12.2.0-2+b1) ...

Selecting previously unselected package g++-12.

Preparing to unpack .../deb/g++-12_12.2.0-13_amd64.deb ...

Unpacking g++-12 (12.2.0-13) ...

Selecting previously unselected package g++.

Preparing to unpack .../g++_4%3a12.2.0-2+b1_amd64.deb ...

Unpacking g++ (4:12.2.0-2+b1) ...

Selecting previously unselected package gcc-11-base:amd64.

Preparing to unpack .../gcc-11-base_11.3.0-8_amd64.deb ...

Unpacking gcc-11-base:amd64 (11.3.0-8) ...

Selecting previously unselected package lib32gcc-s1.

Preparing to unpack .../lib32gcc-s1_12.2.0-13_amd64.deb ...

Unpacking lib32gcc-s1 (12.2.0-13) ...

Selecting previously unselected package libx32gcc-s1.

Preparing to unpack .../libx32gcc-s1_12.2.0-13_amd64.deb ...

Unpacking libx32gcc-s1 (12.2.0-13) ...

Selecting previously unselected package lib32atomic1.

Preparing to unpack .../lib32atomic1_12.2.0-13_amd64.deb ...

Unpacking lib32atomic1 (12.2.0-13) ...

Selecting previously unselected package libx32atomic1.

Preparing to unpack .../libx32atomic1_12.2.0-13_amd64.deb ...

Unpacking libx32atomic1 (12.2.0-13) ...

Selecting previously unselected package lib32quadmath0.

Preparing to unpack .../lib32quadmath0_12.2.0-13_amd64.deb ...

Unpacking lib32quadmath0 (12.2.0-13) ...

Selecting previously unselected package libx32quadmath0.

Preparing to unpack .../libx32quadmath0_12.2.0-13_amd64.deb ...

Unpacking libx32quadmath0 (12.2.0-13) ...

Selecting previously unselected package lib32gcc-12-dev.

Preparing to unpack .../lib32gcc-12-dev_12.2.0-13_amd64.deb ...

Unpacking lib32gcc-12-dev (12.2.0-13) ...

Selecting previously unselected package libx32gcc-12-dev.

Preparing to unpack .../libx32gcc-12-dev_12.2.0-13_amd64.deb ...

Unpacking libx32gcc-12-dev (12.2.0-13) ...

Selecting previously unselected package gcc-12-multilib.

Preparing to unpack .../gcc-12-multilib_12.2.0-13_amd64.deb ...

Unpacking gcc-12-multilib (12.2.0-13) ...

Selecting previously unselected package gcc-multilib.

Preparing to unpack .../gcc-multilib_4%3a12.2.0-2+b1_amd64.deb ...

Unpacking gcc-multilib (4:12.2.0-2+b1) ...

Selecting previously unselected package libasound2-data.

Preparing to unpack .../libasound2-data_1.2.8-1_all.deb ...

Unpacking libasound2-data (1.2.8-1) ...

Selecting previously unselected package libdeflate0:amd64.

Preparing to unpack .../libdeflate0_1.14-1_amd64.deb ...

Unpacking libdeflate0:amd64 (1.14-1) ...

Selecting previously unselected package libpython3.10:amd64.

Preparing to unpack .../libpython3.10_3.10.9-1_amd64.deb ...

Unpacking libpython3.10:amd64 (3.10.9-1) ...

Selecting previously unselected package libwireshark-data.

Preparing to unpack .../libwireshark-data_4.0.2-1_all.deb ...

Unpacking libwireshark-data (4.0.2-1) ...

Selecting previously unselected package python3-pkg-resources.

Preparing to unpack .../python3-pkg-resources_65.5.0-1.1_all.deb ...

Unpacking python3-pkg-resources (65.5.0-1.1) ...

Selecting previously unselected package python3-pygments.

Preparing to unpack .../python3-pygments_2.13.0+dfsg-1_all.deb ...

Unpacking python3-pygments (2.13.0+dfsg-1) ...

Selecting previously unselected package python3-yaml.

Preparing to unpack .../python3-yaml_6.0-3+b1_amd64.deb ...

Unpacking python3-yaml (6.0-3+b1) ...

Selecting previously unselected package netcat-openbsd.

Preparing to unpack .../netcat-openbsd_1.219-1_amd64.deb ...

Unpacking netcat-openbsd (1.219-1) ...

Selecting previously unselected package python3-roman.

Preparing to unpack .../python3-roman_3.3-3_all.deb ...

Unpacking python3-roman (3.3-3) ...

Selecting previously unselected package python3-docutils.

Preparing to unpack .../python3-docutils_0.17.1+dfsg-3_all.deb ...

Unpacking python3-docutils (0.17.1+dfsg-3) ...

Selecting previously unselected package python3-scapy.

Preparing to unpack .../python3-scapy_2.4.5+g9420c22-2_all.deb ...

Unpacking python3-scapy (2.4.5+g9420c22-2) ...

Selecting previously unselected package socat.

Preparing to unpack .../deb/socat_1.7.4.4-2_amd64.deb ...

Unpacking socat (1.7.4.4-2) ...

Selecting previously unselected package tcpdump.

Preparing to unpack .../deb/tcpdump_4.99.2-1_amd64.deb ...

Unpacking tcpdump (4.99.2-1) ...

Setting up gcc-12-base:amd64 (12.2.0-13) ...

Setting up libgcc-s1:amd64 (12.2.0-13) ...

Setting up libpython3.10-minimal:amd64 (3.10.9-1) ...

Setting up libattr1:amd64 (1:2.5.1-3) ...

Setting up traceroute (1:2.1.1-1) ...

update-alternatives: using /usr/bin/traceroute.db to provide /usr/bin/traceroute (traceroute) in auto mode

update-alternatives: using /usr/bin/traceroute6.db to provide /usr/bin/traceroute6 (traceroute6) in auto mode

update-alternatives: using /usr/bin/lft.db to provide /usr/bin/lft (lft) in auto mode

update-alternatives: using /usr/bin/traceproto.db to provide /usr/bin/traceproto (traceproto) in auto mode

update-alternatives: using /usr/sbin/tcptraceroute.db to provide /usr/sbin/tcptraceroute (tcptraceroute) in auto mode

Setting up attr (1:2.5.1-3) ...

Setting up ebtables (2.0.11-5) ...

update-alternatives: using /usr/sbin/ebtables-legacy to provide /usr/sbin/ebtables (ebtables) in auto mode

Setting up libatomic1:amd64 (12.2.0-13) ...

Setting up libquadmath0:amd64 (12.2.0-13) ...

Setting up gcc-11-base:amd64 (11.3.0-8) ...

Setting up libasound2-data (1.2.8-1) ...

Setting up libdeflate0:amd64 (1.14-1) ...

Setting up libwireshark-data (4.0.2-1) ...

Setting up netcat-openbsd (1.219-1) ...

update-alternatives: using /bin/nc.openbsd to provide /bin/nc (nc) in auto mode

Setting up socat (1.7.4.4-2) ...

Setting up libpython3.10-stdlib:amd64 (3.10.9-1) ...

Setting up python3.10-minimal (3.10.9-1) ...

Setting up libpython3-stdlib:amd64 (3.10.6-3+b1) ...

Setting up libpython3.10:amd64 (3.10.9-1) ...

Setting up python3-minimal (3.10.6-3+b1) ...

Setting up python3.10 (3.10.9-1) ...

Setting up python3 (3.10.6-3+b1) ...

running python rtupdate hooks for python3.10...

Setting up uuid-runtime (2.38.1-4) ...

Adding group `uuidd' (GID 109) ...

Done.

Setting up openvswitch-switch (3.1.0~git20221212.739bcf2-3) ...

update-alternatives: using /usr/lib/openvswitch-switch/ovs-vswitchd to provide /usr/sbin/ovs-vswitchd (ovs-vswitchd) in auto mode

calling  nf_defrag_init+0x0/0x1000 [nf_defrag_ipv4] @ 1150
initcall nf_defrag_init+0x0/0x1000 [nf_defrag_ipv4] returned 0 after 2 usecs
calling  nf_defrag_init+0x0/0x1000 [nf_defrag_ipv6] @ 1150
initcall nf_defrag_init+0x0/0x1000 [nf_defrag_ipv6] returned 0 after 521 usecs
calling  nf_conntrack_standalone_init+0x0/0x1000 [nf_conntrack] @ 1150
initcall nf_conntrack_standalone_init+0x0/0x1000 [nf_conntrack] returned 0 after 1276 usecs
calling  nf_nat_init+0x0/0x1000 [nf_nat] @ 1150
initcall nf_nat_init+0x0/0x1000 [nf_nat] returned 0 after 324 usecs
calling  nf_conncount_modinit+0x0/0x1000 [nf_conncount] @ 1150
initcall nf_conncount_modinit+0x0/0x1000 [nf_conncount] returned 0 after 649 usecs
calling  dp_init+0x0/0x192 [openvswitch] @ 1150
openvswitch: Open vSwitch switching datapath
initcall dp_init+0x0/0x192 [openvswitch] returned 0 after 8599 usecs
Setting up libgcc-12-dev:amd64 (12.2.0-13) ...

Setting up gcc-12 (12.2.0-13) ...

Setting up gcc (4:12.2.0-2+b1) ...

Setting up g++-12 (12.2.0-13) ...

Setting up g++ (4:12.2.0-2+b1) ...

update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in auto mode

Setting up lib32gcc-s1 (12.2.0-13) ...

Setting up libx32gcc-s1 (12.2.0-13) ...

Setting up lib32atomic1 (12.2.0-13) ...

Setting up libx32atomic1 (12.2.0-13) ...

Setting up lib32quadmath0 (12.2.0-13) ...

Setting up libx32quadmath0 (12.2.0-13) ...

Setting up lib32gcc-12-dev (12.2.0-13) ...

Setting up libx32gcc-12-dev (12.2.0-13) ...

Setting up gcc-12-multilib (12.2.0-13) ...

Setting up gcc-multilib (4:12.2.0-2+b1) ...

Setting up python3-pkg-resources (65.5.0-1.1) ...

Setting up python3-pygments (2.13.0+dfsg-1) ...

Setting up python3-yaml (6.0-3+b1) ...

Setting up python3-roman (3.3-3) ...

Setting up python3-docutils (0.17.1+dfsg-3) ...

Setting up python3-scapy (2.4.5+g9420c22-2) ...

Setting up tcpdump (4.99.2-1) ...

Setting up openvswitch-common (3.1.0~git20221212.739bcf2-3) ...

Setting up python3-netifaces:amd64 (0.11.0-2) ...

Setting up python3-sortedcontainers (2.4.0-2) ...

Setting up python3-openvswitch (3.1.0~git20221212.739bcf2-3) ...

Processing triggers for libc-bin (2.36-5) ...

Processing triggers for systemd (252.1-1) ...

dpkg: regarding .../python3_3.10.6-3+b1_amd64.deb containing python3, pre-dependency problem:

python3 pre-depends on python3-minimal (= 3.10.6-3+b1)

python3-minimal latest configured version is 3.10.6-1.



dpkg: warning: ignoring pre-dependency problem!

dpkg-query: package 'linux-perf' is not installed

Use dpkg --contents (= dpkg-deb --contents) to list archive files contents.

Traceback (most recent call last):

File "/usr/bin/py3clean", line 210, in <module>

main()

File "/usr/bin/py3clean", line 196, in main

pfiles = set(dpf.from_package(options.package))

File "/usr/share/python3/debpython/files.py", line 53, in from_package

raise Exception("cannot get content of %s" % package_name)

Exception: cannot get content of linux-perf

error running python rtupdate hook linux-perf

dpkg: error processing package python3 (--install):

installed python3 package post-installation script subprocess returned error exit status 4

dpkg: uuid-runtime: dependency problems, but configuring anyway as you requested:

uuid-runtime depends on libuuid1 (>= 2.38.1-2~); however:

Version of libuuid1:amd64 on system is 2.38.1-1.1+b1.




uuidd.service is a disabled or a static unit, not starting it.

dpkg: openvswitch-switch: dependency problems, but configuring anyway as you requested:

openvswitch-switch depends on openvswitch-common (= 3.1.0~git20221212.739bcf2-3).

openvswitch-switch depends on python3-netifaces.

openvswitch-switch depends on python3-openvswitch (>= 3.1.0~git20221212.739bcf2-3).

openvswitch-switch depends on python3:any; however:

Package python3 is not configured yet.

openvswitch-switch depends on libnuma1 (>= 2.0.11); however:

Package libnuma1 is not installed.

openvswitch-switch depends on libunbound8 (>= 1.8.0); however:

Package libunbound8 is not installed.

openvswitch-switch depends on libxdp1 (>= 1.2.9~); however:

Package libxdp1 is not installed.



BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdb1): using free space tree
BTRFS info (device sdb1): enabling ssd optimizations
BTRFS info (device sdb1): auto enabling async discard
LKP: ttyS0: 256:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml


dpkg: libgcc-12-dev:amd64: dependency problems, but configuring anyway as you requested:

libgcc-12-dev:amd64 depends on libgomp1 (>= 12.2.0-13); however:

Package libgomp1 is not installed.

libgcc-12-dev:amd64 depends on libitm1 (>= 12.2.0-13); however:

Package libitm1 is not installed.

libgcc-12-dev:amd64 depends on libasan8 (>= 12.2.0-13); however:

Package libasan8 is not installed.

libgcc-12-dev:amd64 depends on liblsan0 (>= 12.2.0-13); however:

Package liblsan0 is not installed.

libgcc-12-dev:amd64 depends on libtsan2 (>= 12.2.0-13); however:

Package libtsan2 is not installed.

libgcc-12-dev:amd64 depends on libubsan1 (>= 12.2.0-13); however:

Package libubsan1 is not installed.



dpkg: gcc-12: dependency problems, but configuring anyway as you requested:

gcc-12 depends on cpp-12 (= 12.2.0-13); however:

Package cpp-12 is not installed.

gcc-12 depends on libcc1-0 (>= 12.2.0-13); however:

Package libcc1-0 is not installed.

gcc-12 depends on binutils (>= 2.39.90.20221231); however:

Package binutils is not installed.

gcc-12 depends on libisl23 (>= 0.15); however:

Package libisl23 is not installed.

gcc-12 depends on libmpc3 (>= 1.1.0); however:

Package libmpc3 is not installed.

gcc-12 depends on libmpfr6 (>= 3.1.3); however:

Package libmpfr6 is not installed.



dpkg: gcc: dependency problems, but configuring anyway as you requested:

gcc depends on cpp (= 4:12.2.0-2+b1); however:

Package cpp is not installed.



dpkg: g++-12: dependency problems, but configuring anyway as you requested:

g++-12 depends on libstdc++-12-dev (= 12.2.0-13); however:

Package libstdc++-12-dev is not installed.

g++-12 depends on libisl23 (>= 0.15); however:

Package libisl23 is not installed.

g++-12 depends on libmpc3 (>= 1.1.0); however:

Package libmpc3 is not installed.

g++-12 depends on libmpfr6 (>= 3.1.3); however:

Package libmpfr6 is not installed.



dpkg: g++: dependency problems, but configuring anyway as you requested:

g++ depends on cpp (= 4:12.2.0-2+b1); however:

Package cpp is not installed.



dpkg: lib32gcc-s1: dependency problems, but configuring anyway as you requested:

lib32gcc-s1 depends on libc6-i386 (>= 2.35); however:

Package libc6-i386 is not installed.



dpkg: libx32gcc-s1: dependency problems, but configuring anyway as you requested:

libx32gcc-s1 depends on libc6-x32 (>= 2.35); however:

Package libc6-x32 is not installed.



dpkg: lib32atomic1: dependency problems, but configuring anyway as you requested:

lib32atomic1 depends on libc6-i386 (>= 2.1.3); however:

Package libc6-i386 is not installed.



dpkg: libx32atomic1: dependency problems, but configuring anyway as you requested:

libx32atomic1 depends on libc6-x32 (>= 2.16); however:

Package libc6-x32 is not installed.



dpkg: lib32quadmath0: dependency problems, but configuring anyway as you requested:

lib32quadmath0 depends on libc6-i386 (>= 2.23); however:

Package libc6-i386 is not installed.



dpkg: libx32quadmath0: dependency problems, but configuring anyway as you requested:

libx32quadmath0 depends on libc6-x32 (>= 2.23); however:

Package libc6-x32 is not installed.



dpkg: lib32gcc-12-dev: dependency problems, but configuring anyway as you requested:

lib32gcc-12-dev depends on lib32gomp1 (>= 12.2.0-13); however:

Package lib32gomp1 is not installed.

lib32gcc-12-dev depends on libx32gomp1 (>= 12.2.0-13); however:

Package libx32gomp1 is not installed.

lib32gcc-12-dev depends on lib32itm1 (>= 12.2.0-13); however:

Package lib32itm1 is not installed.

lib32gcc-12-dev depends on libx32itm1 (>= 12.2.0-13); however:

Package libx32itm1 is not installed.

lib32gcc-12-dev depends on lib32asan8 (>= 12.2.0-13); however:

Package lib32asan8 is not installed.

lib32gcc-12-dev depends on libx32asan8 (>= 12.2.0-13); however:

Package libx32asan8 is not installed.

lib32gcc-12-dev depends on lib32ubsan1 (>= 12.2.0-13); however:

Package lib32ubsan1 is not installed.

lib32gcc-12-dev depends on libx32ubsan1 (>= 12.2.0-13); however:

Package libx32ubsan1 is not installed.



dpkg: libx32gcc-12-dev: dependency problems, but configuring anyway as you requested:

libx32gcc-12-dev depends on lib32gomp1 (>= 12.2.0-13); however:

Package lib32gomp1 is not installed.

libx32gcc-12-dev depends on libx32gomp1 (>= 12.2.0-13); however:

Package libx32gomp1 is not installed.

libx32gcc-12-dev depends on lib32itm1 (>= 12.2.0-13); however:

Package lib32itm1 is not installed.

libx32gcc-12-dev depends on libx32itm1 (>= 12.2.0-13); however:

Package libx32itm1 is not installed.

libx32gcc-12-dev depends on lib32asan8 (>= 12.2.0-13); however:

Package lib32asan8 is not installed.

libx32gcc-12-dev depends on libx32asan8 (>= 12.2.0-13); however:

Package libx32asan8 is not installed.

libx32gcc-12-dev depends on lib32ubsan1 (>= 12.2.0-13); however:

Package lib32ubsan1 is not installed.

libx32gcc-12-dev depends on libx32ubsan1 (>= 12.2.0-13); however:

Package libx32ubsan1 is not installed.



dpkg: gcc-12-multilib: dependency problems, but configuring anyway as you requested:

gcc-12-multilib depends on libc6-dev-i386 (>= 2.23-1~); however:

Package libc6-dev-i386 is not installed.

gcc-12-multilib depends on libc6-dev-x32 (>= 2.23-1~); however:

Package libc6-dev-x32 is not installed.



dpkg: gcc-multilib: dependency problems, but configuring anyway as you requested:

gcc-multilib depends on cpp (= 4:12.2.0-2+b1); however:

Package cpp is not installed.

gcc-multilib depends on linux-libc-dev (>= 3.0.0-2); however:

Package linux-libc-dev is not installed.



dpkg: python3-pkg-resources: dependency problems, but configuring anyway as you requested:

python3-pkg-resources depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-pygments: dependency problems, but configuring anyway as you requested:

python3-pygments depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-yaml: dependency problems, but configuring anyway as you requested:

python3-yaml depends on python3 (<< 3.12); however:

Package python3 is not configured yet.

python3-yaml depends on python3 (>= 3.10~); however:

Package python3 is not configured yet.

python3-yaml depends on python3:any; however:

Package python3 is not configured yet.

python3-yaml depends on libyaml-0-2 (>= 0.2.2~); however:

Package libyaml-0-2 is not installed.



dpkg: python3-roman: dependency problems, but configuring anyway as you requested:

python3-roman depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-docutils: dependency problems, but configuring anyway as you requested:

python3-docutils depends on docutils-common (= 0.17.1+dfsg-3); however:

Package docutils-common is not installed.

python3-docutils depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-scapy: dependency problems, but configuring anyway as you requested:

python3-scapy depends on python3:any; however:

Package python3 is not configured yet.



dpkg: tcpdump: dependency problems, but configuring anyway as you requested:

tcpdump depends on libpcap0.8 (>= 1.9.0); however:

Package libpcap0.8 is not installed.



dpkg: openvswitch-common: dependency problems, but configuring anyway as you requested:

openvswitch-common depends on python3:any; however:

Package python3 is not configured yet.

openvswitch-common depends on libnuma1 (>= 2.0.11); however:

Package libnuma1 is not installed.

LKP: ttyS0: 1397: current_versio[   76.702110][  T286]  openvswitch-common depends on libunbound8 (>= 1.8.0); however:
n: f0, target_ve[   76.702122][  T286] 
rsion: f0
Package libunbound8 is not installed.

openvswitch-common depends on libxdp1 (>= 1.2.9~); however:

Package libxdp1 is not installed.



dpkg: python3-netifaces:amd64: dependency problems, but configuring anyway as you requested:

python3-netifaces:amd64 depends on python3 (<< 3.12); however:

Package python3 is not configured yet.

python3-netifaces:amd64 depends on python3 (>= 3.10~); however:

Package python3 is not configured yet.



dpkg: python3-sortedcontainers: dependency problems, but configuring anyway as you requested:

python3-sortedcontainers depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-openvswitch: dependency problems, but configuring anyway as you requested:

python3-openvswitch depends on python3 (<< 3.12); however:

Package python3 is not configured yet.

python3-openvswitch depends on python3 (>= 3.10~); however:

Package python3 is not configured yet.

python3-openvswitch depends on python3:any; however:

Package python3 is not configured yet.

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3a22000-0xb3a22fff], got write-back
python3-openvswitch depends on libnuma1 (>= 2.0.11); however:

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Package libnuma1 is not installed.

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
python3-openvswitch depends on libunbound8 (>= 1.8.0); however:

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
Package libunbound8 is not installed.
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

python3-openvswitch depends on libxdp1 (>= 1.2.9~); however:
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
Package libxdp1 is not installed.
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Errors were encountered while processing:
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

python3
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
handle /opt/deb/keep-deb.kernel-selftests...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/gcc-12-base_12.2.0-13_amd64.deb
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
Preparing to unpack .../gcc-12-base_12.2.0-13_amd64.deb ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
Unpacking gcc-12-base:amd64 (12.2.0-13) over (12.2.0-13) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
Setting up gcc-12-base:amd64 (12.2.0-13) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libgcc-s1_12.2.0-13_amd64.deb
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

Preparing to unpack .../libgcc-s1_12.2.0-13_amd64.deb ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Unpacking libgcc-s1:amd64 (12.2.0-13) over (12.2.0-13) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

Setting up libgcc-s1:amd64 (12.2.0-13) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
Processing triggers for libc-bin (2.36-5) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-minimal_3.10.6-3+b1_amd64.deb
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
Preparing to unpack .../python3-minimal_3.10.6-3+b1_amd64.deb ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

Unpacking python3-minimal (3.10.6-3+b1) over (3.10.6-3+b1) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

Setting up python3-minimal (3.10.6-3+b1) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3_3.10.6-3+b1_amd64.deb
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
Preparing to unpack .../python3_3.10.6-3+b1_amd64.deb ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3a22000-0xb3a22fff], got write-back
running python pre-rtupdate hooks for python3.10...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Unpacking python3 (3.10.6-3+b1) over (3.10.6-3+b1) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

Setting up python3 (3.10.6-3+b1) ...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
running python rtupdate hooks for python3.10...
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
dpkg-query: package 'linux-perf' is not installed
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

Use dpkg --contents (= dpkg-deb --contents) to list archive files contents.
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

Traceback (most recent call last):
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
File "/usr/bin/py3clean", line 210, in <module>
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

main()
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
File "/usr/bin/py3clean", line 196, in main
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
pfiles = set(dpf.from_package(options.package))
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

File "/usr/share/python3/debpython/files.py", line 53, in from_package
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

raise Exception("cannot get content of %s" % package_name)
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Exception: cannot get content of linux-perf
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
error running python rtupdate hook linux-perf
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
dpkg: error processing package python3 (--install):
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
installed python3 package post-installation script subprocess returned error exit status 4
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

Errors were encountered while processing:
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
python3
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3a22000-0xb3a22fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1466 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
error: dpkg -i /opt/deb/python3_3.10.6-3+b1_amd64.deb failed.

LKP: stdout: 256:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml

RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8

job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/8, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml

/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230119-15299-c5hfhi-1.yaml&job_state=running -O /dev/null

target ucode: 0xf0

LKP: stdout: 1397: current_version: f0, target_version: f0

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91

2023-01-19 03:22:33 ln -sf /usr/bin/clang

2023-01-19 03:22:33 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables

2023-01-19 03:22:33 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables

2023-01-19 03:22:33 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh

LKP WARN miss config CONFIG_PREEMPT_TRACER= of ftrace/config

2023-01-19 03:22:34 make -C ftrace

make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/tools/testing/selftests/ftrace'

make: Nothing to be done for 'all'.

make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/tools/testing/selftests/ftrace'

2023-01-19 03:22:34 make quicktest=1 run_tests -C ftrace

make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/tools/testing/selftests/ftrace'

TAP version 13

1..1

# selftests: ftrace: ftracetest

# === Ftrace unit tests ===

# [1] Basic trace file check	[PASS]

# [2] Basic test for tracersIPMI BMC is not supported on this machine, skip bmc-watchdog setup!

	[PASS]

# [3] Basic trace clock test	[PASS]

# [4] Basic event tracing check	[PASS]

# [5] Change the ringbuffer size	[PASS]

# [6] Snapshot and tracing setting	[PASS]

# [7] trace_pipe and trace_marker	[PASS]


**********************************************************
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**                                                      **
** trace_printk() being used. Allocating extra memory.  **
**                                                      **
** This means that this is a DEBUG kernel and it is     **
** unsafe for production use.                           **
**                                                      **
** If you see this message and you are not debugging    **
** the kernel, report this immediately to your vendor!  **
**                                                      **
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**********************************************************
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1938
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11110 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1951
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10576 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1954
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11729 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1959
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10007 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1962
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10047 usecs



=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Not tainted
-----------------------------
include/trace/events/lock.h:24 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
lock_acquire.cold+0x1f/0x40
? rcu_read_unlock+0x40/0x40
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/module/internal.h:115 __module_address+0x182/0x200
Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs intel_rapl_msr blake2b_generic xor intel_rapl_common raid6_pq zstd_compress libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic crc64_rocksoft crc64 kvm sg irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 mei_wdt ipmi_devintf wmi_bmof i915 rapl ipmi_msghandler intel_cstate drm_buddy intel_gtt drm_display_helper i2c_i801 ttm ahci intel_uncore drm_kms_helper libahci mei_me serio_raw i2c_smbus syscopyarea sysfillrect libata ie31200_edac mei sysimgblt intel_pch_thermal video wmi intel_pmc_core acpi_pad tpm_infineon binfmt_misc drm fuse ip_tables [last unloaded: ftrace_direct]
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
RIP: 0010:__module_address+0x182/0x200
Code: 01 00 00 48 01 da 48 39 d5 0f 82 69 ff ff ff 0f 0b be ff ff ff ff 48 c7 c7 48 56 9f 84 e8 e6 88 3b 02 85 c0 0f 85 d1 fe ff ff <0f> 0b e9 ca fe ff ff 48 83 c4 08 31 c0 5b 5d c3 48 c7 c7 cc 15 29
RSP: 0018:ffffffff84406b40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffffff84406d38 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff849f5648
RBP: ffffffffa03e6086 R08: 0000000000000000 R09: ffff88837f43f943
R10: ffffed106fe87f28 R11: 0000000000000001 R12: ffffffff84406c30
R13: ffffffff84406c10 R14: ffffffffa03e6086 R15: ffffffff84406c70
FS:  0000000000000000(0000) GS:ffff88837f400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000451c00 CR3: 000000043ce2a003 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>

=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Not tainted
-----------------------------
include/linux/rcupdate.h:765 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
#0: ffffffff84925b40 (rcu_read_lock){....}-{1:2}, at: __bpf_address_lookup+0x9/0x200

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
? 0xffffffffa03e6085
__bpf_address_lookup+0x177/0x200
? 0xffffffffa03e6085
? ftrace_regs_caller_end+0x55/0x55
kallsyms_lookup_buildid+0x187/0x220
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
__sprint_symbol+0xaf/0x1c0
? prepare_ftrace_return+0x162/0x230
? kallsyms_lookup_buildid+0x220/0x220
? 0xffffffffa03e6087
? ftrace_return_to_handler+0x260/0x390
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
symbol_string+0x2e1/0x390
? rb_handle_head_page+0x1b0/0x2d0
? ip6_addr_string+0x2e0/0x2e0
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? move_right+0x60/0x60
? 0xffffffffa03e6086
pointer+0x444/0x9c0
? resource_string+0x1590/0x1590
? rb_commit+0xe7/0x850
vsnprintf+0x44f/0x15e0
? pointer+0x9c0/0x9c0
? __trace_graph_entry+0x155/0x1a0
vprintk_store+0x21f/0x820
? ftrace_graph_stop+0x10/0x10
? printk_sprint+0x230/0x230
? vprintk+0x4/0x50
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6086
? 0xffffffffa03e6087
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
vprintk+0x38/0x50
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? 0xffffffffa03e6086
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
show_trace_log_lvl+0x22f/0x2c9
? 0xffffffffa03e6086
? 0xffffffffa03e6086
? module_address_lookup+0x36/0x110
? __module_address+0x182/0x200
? ftrace_regs_caller_end+0x55/0x55
__warn+0xcd/0x180
? __module_address+0x182/0x200
? ftrace_regs_caller_end+0x55/0x55
report_bug+0x15e/0x1c0
handle_bug+0x3c/0x70
exc_invalid_op+0x18/0x50
asm_exc_invalid_op+0x1a/0x20
RIP: 0010:__module_address+0x182/0x200
Code: 01 00 00 48 01 da 48 39 d5 0f 82 69 ff ff ff 0f 0b be ff ff ff ff 48 c7 c7 48 56 9f 84 e8 e6 88 3b 02 85 c0 0f 85 d1 fe ff ff <0f> 0b e9 ca fe ff ff 48 83 c4 08 31 c0 5b 5d c3 48 c7 c7 cc 15 29
RSP: 0018:ffffffff84406b40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffffff84406d38 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff849f5648
RBP: ffffffffa03e6086 R08: 0000000000000000 R09: ffff88837f43f943
R10: ffffed106fe87f28 R11: 0000000000000001 R12: ffffffff84406c30
R13: ffffffff84406c10 R14: ffffffffa03e6086 R15: ffffffff84406c70
? 0xffffffffa03e6086
? 0xffffffffa03e6086
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
module_address_lookup+0x36/0x110
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
kallsyms_lookup_buildid+0x153/0x220
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
__sprint_symbol+0xaf/0x1c0
? prepare_ftrace_return+0x162/0x230
? kallsyms_lookup_buildid+0x220/0x220
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
symbol_string+0x2e1/0x390
? ip6_addr_string+0x2e0/0x2e0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? move_right+0x60/0x60
? 0xffffffffa03e6087
pointer+0x444/0x9c0
? resource_string+0x1590/0x1590
? rb_commit+0xe7/0x850
vsnprintf+0x44f/0x15e0
? pointer+0x9c0/0x9c0
? __trace_graph_entry+0x155/0x1a0
vprintk_store+0x21f/0x820
? ftrace_graph_stop+0x10/0x10
? printk_sprint+0x230/0x230
? vprintk+0x4/0x50
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk+0x38/0x50
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
show_trace_log_lvl+0x22f/0x2c9
? 0xffffffffa03e6087
? _raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
lock_acquire.cold+0x1f/0x40
? rcu_read_unlock+0x40/0x40
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? function_graph_enter+0x490/0x490
? ftrace_regs_caller_end+0x55/0x55
_raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
down_trylock+0x17/0x70
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
__down_trylock_console_sem+0x24/0x90
? ftrace_regs_caller_end+0x55/0x55
console_trylock_spinning+0x13/0x220
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x193/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? printk_sprint+0x177/0x230
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
printk_sprint+0x1f7/0x230
? printk_sprint+0x5/0x230
? ftrace_regs_caller_end+0x55/0x55
vprintk_store+0x2e3/0x820
? printk_sprint+0x230/0x230
? vprintk_emit+0x4/0x280
? function_graph_enter+0x2f7/0x490
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x157/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
module_address_lookup+0x36/0x110
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
kallsyms_lookup_buildid+0x153/0x220
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
__sprint_symbol+0xaf/0x1c0
? prepare_ftrace_return+0x162/0x230
? kallsyms_lookup_buildid+0x220/0x220
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
symbol_string+0x2e1/0x390
? ip6_addr_string+0x2e0/0x2e0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? move_right+0x60/0x60
? 0xffffffffa03e6087
pointer+0x444/0x9c0
? resource_string+0x1590/0x1590
? rb_commit+0xe7/0x850
vsnprintf+0x44f/0x15e0
? pointer+0x9c0/0x9c0
? __trace_graph_entry+0x155/0x1a0
vprintk_store+0x21f/0x820
? ftrace_graph_stop+0x10/0x10
? printk_sprint+0x230/0x230
? vprintk+0x4/0x50
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk+0x38/0x50
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
show_trace_log_lvl+0x22f/0x2c9
? 0xffffffffa03e6087
? _raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
lock_acquire.cold+0x1f/0x40
? rcu_read_unlock+0x40/0x40
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? function_graph_enter+0x490/0x490
? ftrace_regs_caller_end+0x55/0x55
_raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
down_trylock+0x17/0x70
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
__down_trylock_console_sem+0x24/0x90
? ftrace_regs_caller_end+0x55/0x55
console_trylock_spinning+0x13/0x220
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x193/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? printk_sprint+0x177/0x230
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
printk_sprint+0x1f7/0x230
? printk_sprint+0x5/0x230
? ftrace_regs_caller_end+0x55/0x55
vprintk_store+0x2e3/0x820
? printk_sprint+0x230/0x230
? vprintk_emit+0x4/0x280
? function_graph_enter+0x2f7/0x490
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x157/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>
irq event stamp: 1692312
hardirqs last  enabled at (1692311): [<ffffffff8380148a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
hardirqs last disabled at (1692312): [<ffffffff81564600>] trace_graph_entry+0x500/0x7f0
softirqs last  enabled at (1692250): [<ffffffff810f6810>] return_to_handler+0x0/0x40
softirqs last disabled at (1692157): [<ffffffff810f6810>] return_to_handler+0x0/0x40
---[ end trace 0000000000000000 ]---

=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Not tainted
-----------------------------
include/trace/events/error_report.h:69 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? __module_address+0x182/0x200
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
__warn.cold+0x17e/0x180
? __module_address+0x182/0x200
? ftrace_regs_caller_end+0x55/0x55
report_bug+0x15e/0x1c0
handle_bug+0x3c/0x70
exc_invalid_op+0x18/0x50
asm_exc_invalid_op+0x1a/0x20
RIP: 0010:__module_address+0x182/0x200
Code: 01 00 00 48 01 da 48 39 d5 0f 82 69 ff ff ff 0f 0b be ff ff ff ff 48 c7 c7 48 56 9f 84 e8 e6 88 3b 02 85 c0 0f 85 d1 fe ff ff <0f> 0b e9 ca fe ff ff 48 83 c4 08 31 c0 5b 5d c3 48 c7 c7 cc 15 29
RSP: 0018:ffffffff84406b40 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffffff84406d38 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff849f5648
RBP: ffffffffa03e6086 R08: 0000000000000000 R09: ffff88837f43f943
R10: ffffed106fe87f28 R11: 0000000000000001 R12: ffffffff84406c30
R13: ffffffff84406c10 R14: ffffffffa03e6086 R15: ffffffff84406c70
? 0xffffffffa03e6086
? 0xffffffffa03e6086
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
module_address_lookup+0x36/0x110
? 0xffffffffa03e6086
? ftrace_regs_caller_end+0x55/0x55
kallsyms_lookup_buildid+0x153/0x220
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
__sprint_symbol+0xaf/0x1c0
? prepare_ftrace_return+0x162/0x230
? kallsyms_lookup_buildid+0x220/0x220
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
symbol_string+0x2e1/0x390
? ip6_addr_string+0x2e0/0x2e0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? ring_buffer_lock_reserve+0x392/0xd80
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? __rb_reserve_next+0x488/0x14c0
? move_right+0x60/0x60
? 0xffffffffa03e6087
pointer+0x444/0x9c0
? resource_string+0x1590/0x1590
? rb_commit+0xe7/0x850
vsnprintf+0x44f/0x15e0
? pointer+0x9c0/0x9c0
? __trace_graph_entry+0x155/0x1a0
vprintk_store+0x21f/0x820
? ftrace_graph_stop+0x10/0x10
? printk_sprint+0x230/0x230
? vprintk+0x4/0x50
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk+0x38/0x50
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
show_trace_log_lvl+0x22f/0x2c9
? 0xffffffffa03e6087
? _raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
lock_acquire.cold+0x1f/0x40
? rcu_read_unlock+0x40/0x40
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? function_graph_enter+0x490/0x490
? ftrace_regs_caller_end+0x55/0x55
_raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
down_trylock+0x17/0x70
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
__down_trylock_console_sem+0x24/0x90
? ftrace_regs_caller_end+0x55/0x55
console_trylock_spinning+0x13/0x220
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x193/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? printk_sprint+0x177/0x230
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
printk_sprint+0x1f7/0x230
? printk_sprint+0x5/0x230
? ftrace_regs_caller_end+0x55/0x55
vprintk_store+0x2e3/0x820
? printk_sprint+0x230/0x230
? vprintk_emit+0x4/0x280
? function_graph_enter+0x2f7/0x490
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x157/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>
? 0xffffffffa03e6087
? 0xffffffffa03e6087
? function_graph_enter+0x490/0x490
? ftrace_regs_caller_end+0x55/0x55
_raw_spin_lock_irqsave+0x3f/0x60
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
down_trylock+0x17/0x70
? ftrace_regs_caller_end+0x55/0x55
? ftrace_regs_caller_end+0x55/0x55
__down_trylock_console_sem+0x24/0x90
? ftrace_regs_caller_end+0x55/0x55
console_trylock_spinning+0x13/0x220
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x193/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? printk_sprint+0x177/0x230
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
printk_sprint+0x1f7/0x230
? printk_sprint+0x5/0x230
? ftrace_regs_caller_end+0x55/0x55
vprintk_store+0x2e3/0x820
? printk_sprint+0x230/0x230
? vprintk_emit+0x4/0x280
? function_graph_enter+0x2f7/0x490
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x157/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>
=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Tainted: G        W         
-----------------------------
include/trace/events/printk.h:10 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
printk_sprint+0x1f7/0x230
? printk_sprint+0x5/0x230
? ftrace_regs_caller_end+0x55/0x55
vprintk_store+0x2e3/0x820
? printk_sprint+0x230/0x230
? vprintk_emit+0x4/0x280
? function_graph_enter+0x2f7/0x490
? vprintk_store+0x4/0x820
? prepare_ftrace_return+0x162/0x230
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x157/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>

=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Tainted: G        W         
-----------------------------
include/linux/rcupdate.h:765 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
5 locks held by swapper/0/0:
#0: ffffffff84913e20 (console_lock){+.+.}-{0:0}, at: return_to_handler+0x0/0x40
#1: ffffffff84914218 (console_srcu){....}-{0:0}, at: console_flush_all+0x88/0x500
#2: ffffffff845937c0 (console_owner){....}-{0:0}, at: console_emit_next_record+0x22a/0x780
#3: ffffffff84e44c58 (printing_lock){....}-{2:2}, at: return_to_handler+0x0/0x40
#4: ffffffff84925b40 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_chain+0x9/0x1c0

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
atomic_notifier_call_chain+0x150/0x1c0
? ftrace_regs_caller_end+0x55/0x55
vt_console_print+0x4ef/0xda0
? function_graph_enter+0x490/0x490
? unblank_screen+0x10/0x10
? ftrace_regs_caller_end+0x55/0x55
console_emit_next_record+0x2e5/0x780
? devkmsg_read+0x680/0x680
? devkmsg_read+0x680/0x680
? prepare_ftrace_return+0x162/0x230
? trace_graph_return+0x1de/0x2f0
? ftrace_regs_caller_end+0x55/0x55
console_flush_all+0x3a8/0x500
? ftrace_regs_caller_end+0x55/0x55
console_unlock+0x9a/0x150
? console_flush_all+0x500/0x500
? vprintk_emit+0x193/0x280
? console_unlock+0x9/0x150
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x1b4/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>

=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Tainted: G        W         
-----------------------------
include/linux/rcupdate.h:793 rcu_read_unlock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
5 locks held by swapper/0/0:
#0: ffffffff84913e20 (console_lock){+.+.}-{0:0}, at: return_to_handler+0x0/0x40
#1: ffffffff84914218 (console_srcu){....}-{0:0}, at: console_flush_all+0x88/0x500
#2: ffffffff845937c0 (console_owner){....}-{0:0}, at: console_emit_next_record+0x22a/0x780
#3: ffffffff84e44c58 (printing_lock){....}-{2:2}, at: return_to_handler+0x0/0x40
#4: ffffffff84925b40 (rcu_read_lock){....}-{1:2}, at: atomic_notifier_call_chain+0x9/0x1c0

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
atomic_notifier_call_chain+0x186/0x1c0
? ftrace_regs_caller_end+0x55/0x55
vt_console_print+0x4ef/0xda0
? function_graph_enter+0x490/0x490
? unblank_screen+0x10/0x10
? ftrace_regs_caller_end+0x55/0x55
console_emit_next_record+0x2e5/0x780
? devkmsg_read+0x680/0x680
? devkmsg_read+0x680/0x680
? prepare_ftrace_return+0x162/0x230
? trace_graph_return+0x1de/0x2f0
? ftrace_regs_caller_end+0x55/0x55
console_flush_all+0x3a8/0x500
? ftrace_regs_caller_end+0x55/0x55
console_unlock+0x9a/0x150
? console_flush_all+0x500/0x500
? vprintk_emit+0x193/0x280
? console_unlock+0x9/0x150
? ftrace_regs_caller_end+0x55/0x55
vprintk_emit+0x1b4/0x280
? ftrace_regs_caller_end+0x55/0x55
_printk+0xb6/0xe7
? record_print_text.cold+0x11/0x11
? trace_hardirqs_off+0xd6/0x120
? ftrace_return_to_handler+0x260/0x390
? ftrace_regs_caller_end+0x55/0x55
lockdep_rcu_suspicious+0x66/0x165
? trace_graph_entry+0x500/0x7f0
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>
=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Tainted: G        W         
-----------------------------
include/trace/events/preemptirq.h:36 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
trace_hardirqs_off+0x115/0x120
trace_graph_entry+0x500/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>

=============================
WARNING: suspicious RCU usage
6.2.0-rc1-00074-g9aedeaed6fc6 #1 Tainted: G        W         
-----------------------------
include/trace/events/preemptirq.h:40 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
trace_irq_enable+0xfc/0x110
trace_hardirqs_on+0x26/0x50
trace_graph_entry+0x38a/0x7f0
? cpuidle_poll_time+0x4/0x1a0
function_graph_enter+0x2f7/0x490
? ftrace_return_to_handler+0x260/0x390
? ftrace_graph_stop+0x10/0x10
? cpuidle_poll_time+0x4/0x1a0
? trace_irq_enable+0x26/0x110
? cpuidle_poll_time+0x4/0x1a0
prepare_ftrace_return+0x162/0x230
0xffffffffa03e6087
? asm_sysvec_apic_timer_interrupt+0x1a/0x20
? cpuidle_poll_time+0x9/0x1a0
cpuidle_poll_time+0x9/0x1a0
poll_idle+0x43/0x9e
cpuidle_enter_state+0x1e3/0xd30
? ftrace_regs_caller_end+0x55/0x55
cpuidle_enter+0x4e/0xa0
? ftrace_regs_caller_end+0x55/0x55
cpuidle_idle_call+0x1ab/0x270
? arch_cpu_idle_exit+0x40/0x40
? trace_graph_return+0x1de/0x2f0
? do_idle+0xa8/0x1a0
? ftrace_regs_caller_end+0x55/0x55
do_idle+0xf3/0x1a0
? ftrace_regs_caller_end+0x55/0x55
cpu_startup_entry+0x1d/0x20
rest_init+0x15a/0x220
arch_call_rest_init+0x13/0x1d
start_kernel+0x386/0x3a4
secondary_startup_64_no_verify+0xe0/0xeb
</TASK>
watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [ftracetest:1918]
Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs intel_rapl_msr blake2b_generic xor intel_rapl_common raid6_pq zstd_compress libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic crc64_rocksoft crc64 kvm sg irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 mei_wdt ipmi_devintf wmi_bmof i915 rapl ipmi_msghandler intel_cstate drm_buddy intel_gtt drm_display_helper i2c_i801 ttm ahci intel_uncore drm_kms_helper libahci mei_me serio_raw i2c_smbus syscopyarea sysfillrect libata ie31200_edac mei sysimgblt intel_pch_thermal video wmi intel_pmc_core acpi_pad tpm_infineon binfmt_misc drm fuse ip_tables [last unloaded: ftrace_direct]
irq event stamp: 8257722
hardirqs last  enabled at (8257721): [<ffffffff8156448a>] trace_graph_entry+0x38a/0x7f0
hardirqs last disabled at (8257722): [<ffffffff8377d35f>] sysvec_apic_timer_interrupt+0xf/0x90
softirqs last  enabled at (8250334): [<ffffffff810f6810>] return_to_handler+0x0/0x40
softirqs last disabled at (8250205): [<ffffffff810f6810>] return_to_handler+0x0/0x40
CPU: 3 PID: 1918 Comm: ftracetest Tainted: G        W          6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
RIP: 0010:trace_graph_entry+0x53/0x7f0
Code: 00 00 48 89 fa 48 83 ec 08 4c 8b 2d 47 f1 3f 05 48 c1 ea 03 80 3c 02 00 0f 85 59 06 00 00 f6 83 41 2c 00 00 80 74 15 45 31 e4 <48> 83 c4 08 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8d 5d 07
RSP: 0018:ffffc900028bf5c0 EFLAGS: 00000202
RAX: 00000000007e00b9 RBX: ffff88837f5bf940 RCX: 1ffffffff0c9b386
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8156448a
RBP: ffffc900028bf628 R08: 0000000000000001 R09: ffffffff864d9287
R10: fffffbfff0c9b250 R11: 0000000000000001 R12: 0000000000000001
R13: ffffffff84a5cc80 R14: 0000000000000200 R15: 0000000000000003
FS:  00007f0605246740(0000) GS:ffff88837f580000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555ba219f608 CR3: 000000019d7be005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? _raw_spin_lock+0x4/0x40
function_graph_enter+0x2f7/0x490
? ftrace_graph_stop+0x10/0x10
? _raw_spin_lock+0x4/0x40
? mark_held_locks+0x9e/0xe0
? _raw_spin_lock+0x4/0x40
prepare_ftrace_return+0x162/0x230
? trace_graph_return+0x1f6/0x2f0
0xffffffffa03e6087
? function_graph_enter+0x490/0x490
? _raw_spin_lock+0x9/0x40
? return_to_handler+0x15/0x40
_raw_spin_lock+0x9/0x40
__get_locked_pte+0x173/0x320
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? ftrace_regs_caller_end+0x55/0x55
__text_poke+0x1ed/0x9a0
? setup_data_read+0x210/0x210
? function_graph_enter+0x490/0x490
? text_poke_memset+0x70/0x70
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? setup_data_read+0x210/0x210
? ftrace_regs_caller_end+0x55/0x55
text_poke_bp_batch+0x44e/0x6d0
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? do_sync_core+0x30/0x30
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
text_poke_flush+0x88/0xb0
? btrfs_ref_to_path+0x4/0x360 [btrfs]
? ftrace_regs_caller_end+0x55/0x55
text_poke_queue+0x22/0x70
? ftrace_regs_caller_end+0x55/0x55
ftrace_replace_code+0x254/0x4b0
ftrace_modify_all_code+0xbd/0x170
? ftrace_graph_func+0x50/0x50
ftrace_startup+0x17f/0x300
? __trace_graph_entry+0x1a0/0x1a0
register_ftrace_graph+0x147/0x190
graph_trace_init+0x63/0x80
tracing_set_tracer+0x592/0x840
? lock_is_held_type+0x9c/0x110
? trace_printk_init_buffers+0x30/0x30
? __might_fault+0xc0/0x160
? lock_release+0xe3/0x250
tracing_set_trace_write+0x128/0x1e0
? tracing_set_tracer+0x840/0x840
? rcu_read_unlock+0x40/0x40
? mark_lock+0xca/0xac0
? check_prev_add+0x20d0/0x20d0
? lock_is_held_type+0x9c/0x110
vfs_write+0x211/0xc00
? kernel_write+0x500/0x500
? do_dup2+0x21a/0x500
? find_held_lock+0x2c/0x110
? __fget_light+0x51/0x220
ksys_write+0xf7/0x1d0
? __ia32_sys_read+0xb0/0xb0
do_syscall_64+0x5a/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x350
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f0605341190
Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffcae73e178 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00007f0605341190
RDX: 000000000000000f RSI: 0000555ba2128440 RDI: 0000000000000001
RBP: 0000555ba2128440 R08: 0000000000000007 R09: 0000000000000073
R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000f
R13: 00007f060541c760 R14: 000000000000000f R15: 00007f06054179e0
</TASK>
Kernel panic - not syncing: softlockup: hung tasks
CPU: 3 PID: 1918 Comm: ftracetest Tainted: G        W    L     6.2.0-rc1-00074-g9aedeaed6fc6 #1
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<IRQ>
? ftrace_regs_caller_end+0x55/0x55
dump_stack_lvl+0x49/0x5d
panic+0x222/0x45c
? panic_print_sys_info+0x73/0x73
? function_graph_enter+0x490/0x490
? trace_graph_return+0x1de/0x2f0
? trace_graph_return+0x1de/0x2f0
? ftrace_regs_caller_end+0x55/0x55
watchdog_timer_fn.cold+0x11/0x1b
? lockup_detector_update_enable+0x50/0x50
? ftrace_regs_caller_end+0x55/0x55
__hrtimer_run_queues+0x18f/0x8e0
? trace_hrtimer_cancel+0x170/0x170
? ftrace_regs_caller_end+0x55/0x55
hrtimer_interrupt+0x2c3/0x740
? ftrace_regs_caller_end+0x55/0x55
__sysvec_apic_timer_interrupt+0xf5/0x3f0
? ftrace_regs_caller_end+0x55/0x55
sysvec_apic_timer_interrupt+0x6e/0x90
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:trace_graph_entry+0x53/0x7f0
Code: 00 00 48 89 fa 48 83 ec 08 4c 8b 2d 47 f1 3f 05 48 c1 ea 03 80 3c 02 00 0f 85 59 06 00 00 f6 83 41 2c 00 00 80 74 15 45 31 e4 <48> 83 c4 08 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8d 5d 07
RSP: 0018:ffffc900028bf5c0 EFLAGS: 00000202
RAX: 00000000007e00b9 RBX: ffff88837f5bf940 RCX: 1ffffffff0c9b386
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8156448a
RBP: ffffc900028bf628 R08: 0000000000000001 R09: ffffffff864d9287
R10: fffffbfff0c9b250 R11: 0000000000000001 R12: 0000000000000001
R13: ffffffff84a5cc80 R14: 0000000000000200 R15: 0000000000000003
? trace_graph_entry+0x38a/0x7f0
? _raw_spin_lock+0x4/0x40
function_graph_enter+0x2f7/0x490
? ftrace_graph_stop+0x10/0x10
? _raw_spin_lock+0x4/0x40
? mark_held_locks+0x9e/0xe0
? _raw_spin_lock+0x4/0x40
prepare_ftrace_return+0x162/0x230
? trace_graph_return+0x1f6/0x2f0
0xffffffffa03e6087
? function_graph_enter+0x490/0x490
? _raw_spin_lock+0x9/0x40
? return_to_handler+0x15/0x40
_raw_spin_lock+0x9/0x40
__get_locked_pte+0x173/0x320
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? ftrace_regs_caller_end+0x55/0x55
__text_poke+0x1ed/0x9a0
? setup_data_read+0x210/0x210
? function_graph_enter+0x490/0x490
? text_poke_memset+0x70/0x70
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? setup_data_read+0x210/0x210
? ftrace_regs_caller_end+0x55/0x55
text_poke_bp_batch+0x44e/0x6d0
? scrub_missing_raid56_pages+0x890/0x890 [btrfs]
? do_sync_core+0x30/0x30
? 0xffffffffa03e6087
? ftrace_regs_caller_end+0x55/0x55
text_poke_flush+0x88/0xb0
? btrfs_ref_to_path+0x4/0x360 [btrfs]
? ftrace_regs_caller_end+0x55/0x55
text_poke_queue+0x22/0x70
? ftrace_regs_caller_end+0x55/0x55
ftrace_replace_code+0x254/0x4b0
ftrace_modify_all_code+0xbd/0x170
? ftrace_graph_func+0x50/0x50
ftrace_startup+0x17f/0x300
? __trace_graph_entry+0x1a0/0x1a0
register_ftrace_graph+0x147/0x190
graph_trace_init+0x63/0x80
tracing_set_tracer+0x592/0x840
? lock_is_held_type+0x9c/0x110
? trace_printk_init_buffers+0x30/0x30
? __might_fault+0xc0/0x160
? lock_release+0xe3/0x250
tracing_set_trace_write+0x128/0x1e0
? tracing_set_tracer+0x840/0x840
? rcu_read_unlock+0x40/0x40
? mark_lock+0xca/0xac0
? check_prev_add+0x20d0/0x20d0
? lock_is_held_type+0x9c/0x110
vfs_write+0x211/0xc00
? kernel_write+0x500/0x500
? do_dup2+0x21a/0x500
? find_held_lock+0x2c/0x110
? __fget_light+0x51/0x220
ksys_write+0xf7/0x1d0
? __ia32_sys_read+0xb0/0xb0
do_syscall_64+0x5a/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x350
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f0605341190
Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffcae73e178 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00007f0605341190
RDX: 000000000000000f RSI: 0000555ba2128440 RDI: 0000000000000001
RBP: 0000555ba2128440 R08: 0000000000000007 R09: 0000000000000073
R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000f
R13: 00007f060541c760 R14: 000000000000000f R15: 00007f06054179e0
</TASK>
Kernel Offset: disabled
early console in extract_kernel
input_data: 0x000000043dfed3a8
input_len: 0x00000000016058bc
output: 0x0000000439a00000
output_len: 0x000000000513c9f8
kernel_total_size: 0x0000000005c28000
needed_size: 0x0000000005e00000
trampoline_32bit: 0x000000000008f000


--xzgWY3NTp4GxXFlv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: ftrace
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d06
tbox_group: lkp-skl-d06
submit_id: 63c7d6c9471e0f9c9d818bd4
job_file: "/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230118-40093-12wz893-0.yaml"
id: d50e8ee9b5b8d5a75b5497a0442ef3d6ae10de4f
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d06
model: Skylake
nr_cpu: 4
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1"
brand: Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/queue/cyclic
commit: 9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91

#! include/testbox/lkp-skl-d06
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true

#! include/kernel-selftests
need_kconfig:
- FTRACE: y
- KPROBES: y
- FUNCTION_PROFILER: y
- TRACER_SNAPSHOT: y
- STACK_TRACER: y
- HIST_TRIGGERS: y
- SCHED_TRACER: y
- IRQSOFF_TRACER: y
- PREEMPTIRQ_DELAY_TEST: m
- MODULES: y
- MODULE_UNLOAD: y
- SAMPLES: y
- SAMPLE_FTRACE_DIRECT: m
- SAMPLE_TRACE_PRINTK: m
- KALLSYMS_ALL: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-01-18 19:23:54.343053603 +08:00
_id: 63c7d6c9471e0f9c9d818bd4
_rt: "/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 160bb02a598f1f5b1bc814e1f008dbc1fe7a0130
base_commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
branch: linux-devel/devel-hourly-20230117-072835
result_root: "/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6
- branch=linux-devel/devel-hourly-20230117-072835
- job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91-20230118-40093-12wz893-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91
- kvm-intel.unrestricted_guest=0
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230117110146/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.2.0-rc4-00775-g9aac31600ae2
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/9aedeaed6fc6fe8452b9b8225e95cc2b8631ff91/vmlinuz-6.2.0-rc1-00074-g9aedeaed6fc6"
dequeue_time: 2023-01-18 19:55:46.850097775 +08:00

#! /db/releases/20230118165850/lkp-src/include/site/lkp-wsx01
job_state: running

--xzgWY3NTp4GxXFlv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -C ftrace
make quicktest=1 run_tests -C ftrace

--xzgWY3NTp4GxXFlv--
