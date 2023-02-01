Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED03685FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBAGcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBAGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:32:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B20F5357D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675233151; x=1706769151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lsgX9jj2SQTGQzuKW+9YJ2mYfxRFP1CC0+glqSiQn7c=;
  b=FLPBNiRS5nfYitXdnjZrE49h6jSthhtGwywq5Y6cI03AdzXbEQQRhsT7
   VyjT3I10pYv0sjiM0sRgzLXYy1LYmR6JrT+MjHsW7F9REQyMtoUYWRuj6
   SlgnObPpvoAnui15MmDUgRxW82Gu5tpmK/6klHZKKaQQ/G/eklXfHMRxp
   Ruq6oBq21faujbcBQ1KSq+9CNmq5ze4o0B3U5r1IzE3ti2nKWCZgO3FIj
   gBBkHOzBwNsXGnlrYuBB2Nva2YE51WNYm3FvEdjbQV9rMbW6XEiN6iz4K
   /MuOPdS5seQeYCXw7NjwsL8HIkjPDTrhMejWYjaVHnEGF3XFct79X4Vn7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="328070741"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="328070741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 22:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="695240524"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="695240524"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2023 22:32:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 22:32:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 22:32:29 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 22:32:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbOQScKAJXdRZZZ1lmBAIq7FB84iGzwIKVK95ZZcMHOQ4LVKxXtzj5zFxiBecA7Yz5MGuGC0Xa+U7b9tLlQ/FWBmKaUIxu4UD8hjPeTsHWxEvkCssNpY2uWywfZtdCgxN1+IfxpAYQtnSwB+01Jlx4PfyVj871WmXAiaNtn+z0zEKhLWvExs0SwXRsssWYANthlW9F4sC9DnFATUpp/4iAxQVHJq2bR5JF+FFarYqI7+yKikWU/eb9E5yRyPQ4wmqiApgIBfOtGxgNmBPjxZT9HjiVe5w74GakrBMayhU+8yqpHzDRDvv+TIjh5WpVaXhFd3ehZirye1c9HyBMWIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJIBLZwCfWZR9TC6yHqTuuSJ/r+x2M5E5C6nLw07ra0=;
 b=U4eYlCzapitxdTKj38qqY3c00Njei+oYrdJ3c76yg+Rwe5Dbn/wwkhl/Ng6ydDgCCPUYXGUIYxzBAiyqe74v2We6jeYuYZhoBHKEkbUUBXHW7/ccrEt+wpvSF2g90ii2FFwqznUkxbhVGhkptryKDzpvBRODZKPjCdbdeotB1fEpEnrGt6Ijjf7Fz/6o3Tj+NKvwGNtpqeUbHxAEow0pNMjdZXgGV1BDu5mOiol2qLcmFHaQ5ixjSeirbf1MQRJFj4AXj412KolBpruF1FLCtx3n9mji7TUGHcp6memGDuN+8C+fGJ0S6UgDbFOOoV/4wNk+8Pioe7nLW0m2mAoZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 06:32:25 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%7]) with mapi id 15.20.6043.033; Wed, 1 Feb 2023
 06:32:25 +0000
Date:   Wed, 1 Feb 2023 14:32:15 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [linux-next:master] [locking/lockdep]  90d0a9b894:
 WARNING:at_kernel/locking/lockdep.c:#__lock_acquire
Message-ID: <202302011445.9d99dae2-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="/bJnoHZfdKSZfzc7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e40820d-7924-4127-11a7-08db041e14db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WX3q3yqAshCSdU2foN94Rsq/31KVFTcAv2gUL+woNSRkwwty+5cMuS+qeyZxjfCCjuI2pViN3z7Jo+LE82pX1lusPi8EUpxBEbVMUkpvo3I45Ar09HCszRk3KWWK12/jK0xvYBLyvrW+mcz1QzEV9YaMzXxVau45zC6dI0w6UkJvlxcsgSnDc5PzyxzqWr6vg8HIKGCdr0qppEg+8Fv/9UarFJrEJVVG2fWHOYQfxUnZ40U9k3A4BchWSQIoCqWjVPtkMiv/YISre/Glnzaq9OCFelCnet91y2gluAxcUjz8j9FxCV+UqiTLwtNSp8FCGEXMnX/6u4CEHx4NUcQLwbJ4gNprqgtwSx5kiVkiwMsVwQ3sLJlypy2w8oiGuXWwEwBUWE5F/9vFj+Lz8ydbha+80YfbBhnnlkhOwDD7oeqPyx1u0fLvFYuwGvOmoCjS5hwpJgIeYcyJvZqzmaKgRuPexzcK1yWC4iEPxcIwlRyA1qw3jqwHpjz7YU0CHvqxd1I4B6dEnG3b66W3Q9K7kSZeTaRPgwSsmaXe5dA7XyMmkoD9D+F15kFRh9E+9GYbeN1ioZv63cpO2NH4ebVKUxH3goSwFJv/AQehcRIKj7pOQlmG2ylIGTwKjO2nYdXFbcPGA2ZKWxlxfD4AOIYYWUhMTdGXLXas7Ya0wPKUjGoSe18b+c+Dc4H41LM3AOub3cdKZHCpOKk4USi5COjTDQhWX6Iu2DEvo2f2Aq6kF9YXmqtt1dV5qtQREZBVoGMMHl3qOKlPI+LGmQkyX+Zc4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(6666004)(41300700001)(36756003)(6916009)(54906003)(66946007)(8676002)(316002)(4326008)(66476007)(8936002)(66556008)(5660300002)(235185007)(38100700002)(86362001)(82960400001)(44144004)(6506007)(186003)(6512007)(1076003)(966005)(26005)(2906002)(21490400003)(478600001)(45080400002)(6486002)(83380400001)(2616005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NXG5DCoN/f88SV3Hq6O8J0wxtzP7iaF2KNfcQgNOW+ZrleZkDmZoz+Pik7W1?=
 =?us-ascii?Q?sfhHK+qr9r5Xsv4yxrU3n7kaAQpgbUkj+t86cUL+V6qyDZManGYCEF+q/v9E?=
 =?us-ascii?Q?/80BZ521Ntv4cWPNJfos9Y1K09DD6CNwZs/yw/ZRplKqmlvYgN2nqKLqLajv?=
 =?us-ascii?Q?4LYQWdIzvB7AxYf6kUcqQXqkKORqYWtTstgZ6gwPEqnMcjSYIObRFI3tsMKV?=
 =?us-ascii?Q?eyWXe2ojB8IdQvfizBoKDYbFkfkZXF5GHtLUL8pLElsi9iqmhvEOXDYNRmr8?=
 =?us-ascii?Q?EOL9T4NdtoU3PKDhOD+JOhjSObJMB2VMK25a2C+p050dP6Y3A9L2bFcpLeJz?=
 =?us-ascii?Q?WpdFfkC0A0xGQq6L8dvw+kXebUlCd6KTVHJFOfQMd/lvCo2SpLJQe27GV5xO?=
 =?us-ascii?Q?PjIEUZtc5IwKdH0SRLOt3e4jCOnleFAg/kLKgO+LjJeHtmZHokmPYSAreLgs?=
 =?us-ascii?Q?PjZ1QknHnSiQUWnxO1MYv+hdc5bd4oGWrYo5LQwvkUL/UNhR5X1OBYFRht8a?=
 =?us-ascii?Q?43VvEGRQ34a+x1N/M2UG4yyeh3evNe0qncAMcQi6cuMTMN9EsqFR/Gdw39tf?=
 =?us-ascii?Q?t6SwSSzYDM4n1F/1JzgbUezkmbmuWw+zUO30Y5d9IegJ7plIV0kr0qLbyZWh?=
 =?us-ascii?Q?Yq2lfhsI3WOPYhZaFogJh8PogWQOH3/RBtYqBEcLwYd85L+77g+G48UYNas4?=
 =?us-ascii?Q?gZNJsxqqgLag8IpW2ybAXKU1qRJhZH5DogA0tMvVcwy4S+jkJB4p4XAU9Uhi?=
 =?us-ascii?Q?uCZJ5+QxjsEV1xgowOYgqlqOvABb/evkkKJz0spv5HR9v1V8UOmMsJjme9n7?=
 =?us-ascii?Q?dUApmzWogRS+2uyO9aDYW5yJux2xpUQxckmrxwXsOu+Et7Xc9EsSxM2JxHbn?=
 =?us-ascii?Q?XT67Jjtm0hQXyHVIu+NkjSLcR5Wtw7d/xagLv5rSUp+bq8qGeZfDBZW/twvT?=
 =?us-ascii?Q?DyxzbMC/g21fg1ZjGR5IKg9SEw9iPBO4cUseFk9wuQA+UqlxAUc1HQfqs4cU?=
 =?us-ascii?Q?YESJnU2i8tK0G9ZUFeHN53njZ0pr8ScNEaIwQqNwylt7m8ASvEdJ43clcnLV?=
 =?us-ascii?Q?PfSDtFGiGOSQi5gDBegPyFCO1lfHWP+3hPNHbWMZvVnZekWrjl0D2uTF/DCk?=
 =?us-ascii?Q?hpkE5La9t9liWJyDZUv23bh1dRFGggAt3G3Gjvtx57AEgBVKwb09zyXp2a0T?=
 =?us-ascii?Q?rxyryNpZ+LrxyzxefTMLLgK2ef41OUBZLu1bttepPKtC502ZASpWO+2hcUJl?=
 =?us-ascii?Q?qe3tNRU2Ivf4XZTmFvQOi/QgC9Ryso1IIoskdl/MLyhIzWuyJA0biqWTqdPS?=
 =?us-ascii?Q?O4MSLErJOx2P1yKj9UEichGzYlmbydNQb9QVdiSjc0UvzQmQuiEA/jXKWj6P?=
 =?us-ascii?Q?JTjgOMRuQocWC7yTEjvHbiKZOUDvzF8ppp3HEJzlS/pZ4icx4K4iaEXyvrPo?=
 =?us-ascii?Q?LxNzreIzP1XpKapuXHp604fjHMtP/qFzqKCPH2A5CAwPAeOwM47e5RT13GYW?=
 =?us-ascii?Q?ME0zG8ghwCDzMOKJSNQJqPRWMg0m1QPkRZt09i7mGTUYx+12PXvJaJipnwzG?=
 =?us-ascii?Q?Laucv4qR9JtwvBSXBvKmLeJFzZ8sqpcU1r8v71d/OQeUCojRBEId8seg6hmJ?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e40820d-7924-4127-11a7-08db041e14db
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 06:32:25.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFJVpoQ+Bp0tHjOv6/G46cIbhMvlzaSjnf52T8O0UXLybnCJTF2E9z45jMciseGngIbQ5HevQDppJMxukAJOGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/bJnoHZfdKSZfzc7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_kernel/locking/lockdep.c:#__lock_acquire due to commit (built with gcc-11):

commit: 90d0a9b894dd6b859a48fc21d52b0cf21b080d32 ("locking/lockdep: Improve the deadlock scenario print for sync and read lock")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 80bd9028fecadae4e8e3a278cd32d74badc2a6e0]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-d4cf28ee-1_20230110
with following parameters:

	group: locking

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202302011445.9d99dae2-oliver.sang@intel.com


[   84.353969][   T36] ------------[ cut here ]------------
[   84.359311][   T36] DEBUG_LOCKS_WARN_ON(hlock->references < references)
[   84.359317][   T36] WARNING: CPU: 2 PID: 36 at kernel/locking/lockdep.c:4992 __lock_acquire+0xdc0/0x1840
[   84.375456][   T36] Modules linked in: test_ww_mutex(+) openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs blake2b_generic xor raid6_pq intel_rapl_msr zstd_compress libcrc32c intel_rapl_common x86_pkg_temp_thermal intel_powerclamp sd_mod t10_pi coretemp crc64_rocksoft_generic kvm_intel crc64_rocksoft crc64 sg kvm ipmi_devintf irqbypass crct10dif_pclmul ipmi_msghandler crc32_pclmul i915 crc32c_intel ghash_clmulni_intel drm_buddy sha512_ssse3 intel_gtt mei_wdt drm_display_helper rapl ahci ttm libahci intel_cstate mei_me wmi_bmof drm_kms_helper intel_uncore syscopyarea serio_raw i2c_i801 sysfillrect video libata mei sysimgblt i2c_smbus intel_pch_thermal ie31200_edac intel_pmc_core wmi acpi_pad tpm_infineon binfmt_misc fuse drm ip_tables
[   84.443239][   T36] CPU: 2 PID: 36 Comm: kworker/u8:3 Not tainted 6.2.0-rc1-00188-g90d0a9b894dd #1
[   84.452223][   T36] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[   84.461817][   T36] Workqueue: test-ww_mutex stress_inorder_work [test_ww_mutex]
[   84.469249][   T36] RIP: 0010:__lock_acquire+0xdc0/0x1840
[   84.474682][   T36] Code: d2 0f 85 92 09 00 00 44 8b 25 74 77 f7 03 45 85 e4 0f 85 ee fd ff ff 48 c7 c6 80 80 a9 83 48 c7 c7 60 50 a9 83 e8 4a ad 35 02 <0f> 0b e9 d7 fd ff ff 41 bf 02 00 00 00 e9 e6 f7 ff ff e8 e9 14 e3
[   84.494184][   T36] RSP: 0018:ffffc900002df8a8 EFLAGS: 00010086
[   84.500122][   T36] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   84.507976][   T36] RDX: 0000000000000027 RSI: 0000000000000004 RDI: fffff5200005bf07
[   84.515826][   T36] RBP: ffff888100a20000 R08: 0000000000000001 R09: ffff88837f52898b
[   84.523691][   T36] R10: ffffed106fea5131 R11: 0000000000000001 R12: 0000000000000000
[   84.531554][   T36] R13: 0000000000000000 R14: 00000000000000a0 R15: 0000000000000000
[   84.539407][   T36] FS:  0000000000000000(0000) GS:ffff88837f500000(0000) knlGS:0000000000000000
[   84.548215][   T36] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.554697][   T36] CR2: 0000561259596932 CR3: 000000043ce2a003 CR4: 00000000003706e0
[   84.562552][   T36] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.570407][   T36] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.578261][   T36] Call Trace:
[   84.581421][   T36]  <TASK>
[   84.584228][   T36]  lock_acquire+0x19a/0x500
[   84.588604][   T36]  ? stress_inorder_work+0x273/0x6a0 [test_ww_mutex]
[   84.595156][   T36]  ? lock_sync+0x170/0x170
[   84.599447][   T36]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   84.605479][   T36]  ? lock_is_held_type+0x9c/0x110
[   84.610380][   T36]  __ww_mutex_lock+0x1c3/0x2de0
[   84.616144][   T36]  ? stress_inorder_work+0x273/0x6a0 [test_ww_mutex]
[   84.622697][   T36]  ? lock_is_held_type+0x9c/0x110
[   84.627610][   T36]  ? stress_inorder_work+0x273/0x6a0 [test_ww_mutex]
[   84.634161][   T36]  ? stress_inorder_work+0x302/0x6a0 [test_ww_mutex]
[   84.640713][   T36]  ? mutex_lock_interruptible_nested+0x20/0x20
[   84.646766][   T36]  ? __mutex_unlock_slowpath+0x161/0x5e0
[   84.652270][   T36]  ? bit_wait_timeout+0x170/0x170
[   84.657167][   T36]  ? lock_is_held_type+0x9c/0x110
[   84.662067][   T36]  ? ww_mutex_lock+0x3c/0x150
[   84.666616][   T36]  ww_mutex_lock+0x3c/0x150
[   84.670985][   T36]  stress_inorder_work+0x273/0x6a0 [test_ww_mutex]
[   84.677367][   T36]  ? get_random_order+0x150/0x150 [test_ww_mutex]
[   84.683652][   T36]  ? ethnl_set_rings+0x7a0/0x1170
[   84.688548][   T36]  ? lock_is_held_type+0x9c/0x110
[   84.693448][   T36]  process_one_work+0x7dc/0x12e0
[   84.698259][   T36]  ? lock_sync+0x170/0x170
[   84.702548][   T36]  ? pwq_dec_nr_in_flight+0x230/0x230
[   84.707795][   T36]  ? rwlock_bug+0x90/0x90
[   84.712605][   T36]  worker_thread+0x5b0/0xed0
[   84.717072][   T36]  ? __kthread_parkme+0xd9/0x1d0
[   84.721879][   T36]  ? schedule+0x152/0x230
[   84.726075][   T36]  ? process_one_work+0x12e0/0x12e0
[   84.731148][   T36]  ? process_one_work+0x12e0/0x12e0
[   84.736215][   T36]  kthread+0x293/0x330
[   84.740155][   T36]  ? kthread_complete_and_exit+0x30/0x30
[   84.745656][   T36]  ret_from_fork+0x1f/0x30
[   84.749967][   T36]  </TASK>
[   84.752863][   T36] irq event stamp: 20089
[   84.756971][   T36] hardirqs last  enabled at (20089): [<ffffffff8380148a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   84.767608][   T36] hardirqs last disabled at (20088): [<ffffffff8379dd2f>] sysvec_apic_timer_interrupt+0xf/0x90
[   84.777807][   T36] softirqs last  enabled at (14440): [<ffffffff837cbf37>] __do_softirq+0x527/0x87c
[   84.786961][   T36] softirqs last disabled at (14435): [<ffffffff811c8e4b>] __irq_exit_rcu+0x18b/0x1f0
[   84.796289][   T36] ---[ end trace 0000000000000000 ]---



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



--/bJnoHZfdKSZfzc7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=-32
	export kernel_cmdline='erst_disable'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d06'
	export tbox_group='lkp-skl-d06'
	export submit_id='63d9b6e03c7931618aacc7cf'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-locking-debian-12-x86_64-20220629.cgz-90d0a9b894dd6b859a48fc21d52b0cf21b080d32-20230201-24970-15gmb75-4.yaml'
	export id='7d75403494428632b3855a07ef6d3a7b8364e39a'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=4
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1'
	export brand='Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz'
	export commit='90d0a9b894dd6b859a48fc21d52b0cf21b080d32'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export need_kconfig='{"BLOCK"=>"y"}
{"BTRFS_FS"=>"m"}
{"EFI"=>"y"}
EFIVAR_FS
{"FTRACE"=>"y"}
{"IP_ADVANCED_ROUTER"=>"y"}
{"IP_MULTIPLE_TABLES"=>"y"}
{"RC_CORE"=>"y"}
{"RC_DECODERS"=>"y"}
{"RC_DEVICES"=>"y"}
{"RUNTIME_TESTING_MENU"=>"y"}
{"STAGING"=>"y"}
{"SYNC_FILE"=>"y"}
TEST_FIRMWARE
{"TEST_KMOD"=>"m"}
{"TEST_LKM"=>"m"}
TEST_USER_COPY
{"TUN"=>"m"}
{"XFS_FS"=>"m"}
GPIO_CDEV
OVERLAY_FS
PERF_EVENTS
SCHED_DEBUG
SHMEM
TMPFS_XATTR
TMPFS'
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-02-01 08:48:33 +0800'
	export _id='63d9b6f63c7931618aacc7d1'
	export _rt='/result/kernel-selftests/locking/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='f52288aef9267161e6b4a3da559f1211ddceb673'
	export base_commit='2241ab53cbb5cdb08a6b2d4688feb13971058f65'
	export branch='linux-next/master'
	export result_root='/result/kernel-selftests/locking/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/locking/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/vmlinuz-6.2.0-rc1-00188-g90d0a9b894dd
branch=linux-next/master
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-locking-debian-12-x86_64-20220629.cgz-90d0a9b894dd6b859a48fc21d52b0cf21b080d32-20230201-24970-15gmb75-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=90d0a9b894dd6b859a48fc21d52b0cf21b080d32
erst_disable
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.2.0-rc5-00004-gb436430c2a11'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.WARNING:at_kernel/locking/lockdep.c:#__lock_acquire'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/vmlinuz-6.2.0-rc1-00188-g90d0a9b894dd'
	export dequeue_time='2023-02-01 08:52:07 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-locking-debian-12-x86_64-20220629.cgz-90d0a9b894dd6b859a48fc21d52b0cf21b080d32-20230201-24970-15gmb75-4.cgz'

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

	run_test group='locking' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='locking' $LKP_SRC/stats/wrapper kernel-selftests
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

--/bJnoHZfdKSZfzc7
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
5wKAxxH/eG5dscRn+wIAAAAABFla

--/bJnoHZfdKSZfzc7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32
2023-02-01 00:52:54 ln -sf /usr/bin/clang
2023-02-01 00:52:54 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-02-01 00:52:54 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-02-01 00:52:54 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
locking test: not in Makefile
2023-02-01 00:52:54 make TARGETS=locking
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32/tools/testing/selftests/locking'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32/tools/testing/selftests/locking'
2023-02-01 00:52:54 make -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32/tools/testing/selftests/locking'
make: Nothing to be done for 'all'.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32/tools/testing/selftests/locking'
2023-02-01 00:52:54 make quicktest=1 run_tests -C locking
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32/tools/testing/selftests/locking'
TAP version 13
1..1
# selftests: locking: ww_mutex.sh
# locking/ww_mutex: ok
ok 1 selftests: locking: ww_mutex.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-90d0a9b894dd6b859a48fc21d52b0cf21b080d32/tools/testing/selftests/locking'

--/bJnoHZfdKSZfzc7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 2G
need_cpu: -32
kernel-selftests:
  group: locking
kernel_cmdline: erst_disable
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d06
tbox_group: lkp-skl-d06
submit_id: 63d9ac9302bfa90ed7097738
job_file: "/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-locking-debian-12-x86_64-20220629.cgz-90d0a9b894dd6b859a48fc21d52b0cf21b080d32-20230201-3799-12oqg15-0.yaml"
id: '0118d568f40ae7e885dd2634982b1e70f9667eac'
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
commit: 90d0a9b894dd6b859a48fc21d52b0cf21b080d32

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
- BLOCK: y
- BTRFS_FS: m
- EFI: y
- EFIVAR_FS
- FTRACE: y
- IP_ADVANCED_ROUTER: y
- IP_MULTIPLE_TABLES: y
- RC_CORE: y
- RC_DECODERS: y
- RC_DEVICES: y
- RUNTIME_TESTING_MENU: y
- STAGING: y
- SYNC_FILE: y
- TEST_FIRMWARE
- TEST_KMOD: m
- TEST_LKM: m
- TEST_USER_COPY
- TUN: m
- XFS_FS: m
- GPIO_CDEV
- OVERLAY_FS
- PERF_EVENTS
- SCHED_DEBUG
- SHMEM
- TMPFS_XATTR
- TMPFS
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-02-01 08:04:35.717435730 +08:00
_id: 63d9ac9302bfa90ed7097738
_rt: "/result/kernel-selftests/locking/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: f52288aef9267161e6b4a3da559f1211ddceb673
base_commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
branch: linux-devel/devel-hourly-20230129-114149
result_root: "/result/kernel-selftests/locking/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/locking/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/vmlinuz-6.2.0-rc1-00188-g90d0a9b894dd
- branch=linux-devel/devel-hourly-20230129-114149
- job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-locking-debian-12-x86_64-20220629.cgz-90d0a9b894dd6b859a48fc21d52b0cf21b080d32-20230201-3799-12oqg15-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=90d0a9b894dd6b859a48fc21d52b0cf21b080d32
- erst_disable
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230130194127/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.2.0-rc6
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/90d0a9b894dd6b859a48fc21d52b0cf21b080d32/vmlinuz-6.2.0-rc1-00188-g90d0a9b894dd"
dequeue_time: 2023-02-01 08:16:57.400124976 +08:00

#! /db/releases/20230131215915/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 3.10 1.00 0.35 1/146 1687
start_time: '1675210700'
end_time: '1675210708'
version: "/lkp/lkp/.src-20230120-005110:3637c1aba:678144fc5"

--/bJnoHZfdKSZfzc7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make TARGETS=locking
make -C locking
make quicktest=1 run_tests -C locking

--/bJnoHZfdKSZfzc7--
