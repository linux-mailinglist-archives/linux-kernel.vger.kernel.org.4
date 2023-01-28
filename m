Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B876B67F4E1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjA1FJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjA1FJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:09:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A27241D8;
        Fri, 27 Jan 2023 21:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674882541; x=1706418541;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=lvr66kZZsdRc2jq6VEkKu550NGUbViWPm4pjv7lfXzI=;
  b=g+bcgkMS1St4vWSJPaHVZ5d2nljIl0aGHAKQT2zq4wyS71hwdXXalZcB
   sc4tB+95Swrvezn9yWN/WchmHAyU+EV0I7BoR+K4IQf041ckk3G4uRhIe
   Lvtfh6ne0Q2ATWJwtKy7gk+fGorEW0CdYl29cQ9XuiFHEHvJYCI8WFR9x
   m6cz82Ht3FSpCCoF97L7pOjvQIhJjFJp98POO/Sqk77YWfAWAicnxCA0d
   bcrDPJpEVVgdz6IGr5ft2YM7I+oyZGtztFqbylXf0NOp5EZNpJI6+gag9
   VQb9dtywejsXtN+qZhe6Y1Tu6vrL2ijKnEja5M8vWgGSXBkJdoyhrSffv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="315218637"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="315218637"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 21:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="732103712"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="732103712"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2023 21:08:57 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 21:08:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 21:08:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 21:08:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr+zs0iidfp1W6dx56r5w+OTXpmBUdvyLOdc2LM43PPqubDkP3t+R6zhOioVPpDr4Kef45h3Fq5sQLNdAGrNKGSEZxyCxme+6aW6dg5QDorUVrTD8o/1evlqC4f8EQDwWVXS576q42qGG9o65nY6zbueKRsEg65FTZ3e1rHU166e0JszFF9rgjnZ0xyZ2OOWRyWiy6InlHSBnoByBsMVd0N6GX7JcdU3rw+aLH2V8G6WN5ObkWUfv3clyIT8QSzgsBIG2+qLEHllda6c4HS+h5CQaWnMOZRUls1fTwEAi3rf417LSvBZtOlUBHDzSo4FOxHo7Mr/Ciab3AmDFMYutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vixrzcVigolcDa6YLiwwsg0wXJezz54yfnpJwsXVG0=;
 b=UF7Ro0a9i1D4FLuO7nAQuVWF9EnMbhvXpyL0oVj5ZF1lVsI9OZF0Ay7I6N5xzMiNXPTZKTh2wP3PHIk8Rqa4cF0S06zNZN4dmafvbrY7ywPvDXh1z0L7YzEvulJI4Vm5x/sV9oqxhA5FE0K3SqAiCP7IHVbr3CpyT9mIhv1Osyc9vM8ICYBhsyirfVlS/t9yrbfuCU95rbNFfODDf+eWWJwG47VJ2lovSXOXu0xqxhJYK98yQ0G3iZnIrtNjhu2hcZbg/V8tbdTROyy+vQkmrjqAFJ6E8Udt/V3TYAHxcAUUnX/qeknLEqFcxAXTBhbLcPVOwjzYJXb6480JtzPa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 05:08:52 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%5]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 05:08:52 +0000
Date:   Sat, 28 Jan 2023 13:08:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [RESEND PATCH] clk: Warn and add workaround on misuse of
 .parent_data with .name only
Message-ID: <202301280943.6a383af9-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="jA4K3bP4o8S3U350"
Content-Disposition: inline
In-Reply-To: <20230111193957.27650-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b594168-0f5e-4596-060d-08db00edbeb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuOLgNVaIIdOiddLCoY4KKt/yBBJHWV4WDGja56wbt9wNH07KQ9HWQZOUPJJjgUKhROVUeJcQ782VxRBymMOEd31WahpCaHgLzymuvTgB1BETvdJtEwo60goL340qMdPG8jgbvuNR39Tu98l6PEtkeyunRCVVORr5FE7upUkBxsblCRDgtP8V9GKxNfOiYnw3lBvpEfbMbnwmzf4cX8ZDaTZRv/WN5/3RCdPuT/oWhQeOKG+dOy4DRzRulRjgxB3NOYVRJyHHEHAkptBQEGhz20qC9887sYQM1qjg/a9w/UvyqF9YZkX4Pg1RBSpQNsPwmJP33Z57g87WT78HGgxk4ZMPBglb9c7ugo35YyI+m9EDEHbdOT5B3a/fyUoowXBARrK90NzUAClBRdKgqVCm8xmJop83Smq/3iHAOvSOhyqzqNCyot8yw3rvyUndEl4/8d5fey/TnCrDotOjWgxRKqCMKrbPbyKWSuND7Zr1n7z8OgaikR2AVcvFCOUx+8NE3oxlFEPhCMKmZ5SJtQfkKRq7tcBczRXmiMUmF1NWh7FpT8v7CBU8AHidlUzlJ8z8Ydco7GdnyjfJoVYz+5plE5TZW0IWGh9kcYWp8hLwyS21RJYcZO5BACH8QJoCv5VAnqqILJwhgrA4cXp7f5sjdPpuOuBcH8kJP0q23VLwbGzL0SCDvjWpJS0Pe4evFsmwocmxqVhG2AMGLwiGRrysNtG4zUUkCrFpxMRBn8QfL81xOabhWW4HYm3ew/q0xOdZYHiSyWXPn91I087rFvtT8Ee80DlzPjOdzybOAd1HBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(36756003)(8676002)(54906003)(45080400002)(6486002)(38100700002)(6506007)(44144004)(30864003)(5660300002)(478600001)(6666004)(316002)(2906002)(1076003)(4326008)(235185007)(41300700001)(8936002)(6916009)(966005)(66556008)(66946007)(82960400001)(83380400001)(21490400003)(186003)(86362001)(6512007)(26005)(66476007)(2616005)(142923001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CiOsDuovfa5E9AGR/jAMYSg8z0khAW4GblFmWvEqV5IcbvLz1x/4DJyNGU+x?=
 =?us-ascii?Q?qRK+bBjmiMy00RcElwKGWhHdX8ZaiiO0noMtrU6ma1Gqlsv2HfBkknHleIZo?=
 =?us-ascii?Q?s5xWZcuTFMVO+KEXpqPg/IZKgc0iHb2aLnYxRJ6bQ4go0gxtIfGelJWj/dnL?=
 =?us-ascii?Q?ESm0zoRuqO+ok8Q9sutwfaGEvI43J6AwsqDExODpt4lEBkqr9j8RP59bYYns?=
 =?us-ascii?Q?dBRw1G4i2CIl/Yb3lnTRfunXbYsKCrEQPgXU4g3XwVU92ktHCpfxryqAGIt4?=
 =?us-ascii?Q?MspuTbT2KiZyqMbF0gtvOU0yyx5yNHmMNNi75AT2KyDo5JzwODEA3IMRj1+y?=
 =?us-ascii?Q?qzN43hu3/fjOUxO/AM1CODUsU65N/KCo9MbfPYVl8jnTNrEcQMtHYenu18E+?=
 =?us-ascii?Q?F6w0RnH6QWjhHvR8AVu6Yzx2JDTGq53lyGGV/l8F3ytZOKYzXgtc5OWdEX+N?=
 =?us-ascii?Q?IXy2mUFyf1OWnwiVjni9uAnLZAtNz6zpAVsyEF8dViZSA5IxNDul4bXg/LeN?=
 =?us-ascii?Q?Ea4I4SjjSuUlAdSKud7faRJueP2VNBZHLoBsjkiF0vBGbat8OSYj8H7rsHEF?=
 =?us-ascii?Q?qQSDPG2zNggUFQL32fQlbzdmdFvE2/gNCbiB5tMMVHlUnj9BdkF4g2Xm1Mi3?=
 =?us-ascii?Q?WV5p9+qlG2A+s4ojJTIzrQKhZlqJI1qXucFS4TlSk0X418s9/eLz6AkWD+qa?=
 =?us-ascii?Q?ivqE5GKhuNkS/AVJM0K0C5tlQ/u86jQj35mzjkj0kgxeaYdoliDuKzwRusrY?=
 =?us-ascii?Q?xpQ615RGrBEdsnJfcuw4LgmS0R4AAPyj7AQTCVtMBRG/Xl7lHJlC0QR3+/Rq?=
 =?us-ascii?Q?+5T077rS/9hC8T5pLhPpCezTq82Y0iDZE1+Vc2rj1a+dPvOYa38isV69L4yO?=
 =?us-ascii?Q?Pxlh23ii46qQd2Udt75i/C13ScoGs4MYRWRHeEugh0LCQHJH84F0HRKh+DfE?=
 =?us-ascii?Q?1Llgq77GknEhMysLQqKlLe6ZNcHOJK0y7FDo4YvwJFcNuYP+VaWhotBSuFWd?=
 =?us-ascii?Q?qokz9pfKDU5Q8JMTCDO14QDAJlrtbDMehgsPLuDSWpyQbE6OOyRgqkrQgOWT?=
 =?us-ascii?Q?vA6UXuLewQsaC+wieKX2PzGwYDknxp12uCsimFauNCDL7adoGd4CiW7CgwPO?=
 =?us-ascii?Q?eGTlsuMUJ+Te9LjfKs5dW6TsirDHNl1oic7I+x51FuPG8gVpVwVKGjv8cacp?=
 =?us-ascii?Q?12rdiPRFnbVSBTtDOkDFyuVUj/LUiYMPAcnHXiEvKpq6xRLyRgKWAr41DbPh?=
 =?us-ascii?Q?yy7U0RKXfhkZgazJOR8wWGi2eJWYJH2n5kiCKtwtwcUbMzZRkRdAmNMSJxcX?=
 =?us-ascii?Q?c9Bs4CdxFLvn+seCZHGbfjRwBDwZSm0pykKjYYlXeENn73y/8TMAIIKUqXC5?=
 =?us-ascii?Q?05nfvArJh+Yuq/fSU5MAi+DfAJ4GuznjwKfQtqTi/+dKWQXOVskqBTqPsX3e?=
 =?us-ascii?Q?GPVCXUWiZHtDn2SR6Mm12o6pabh+ERMPG6J39CDBtCmVC+EuCsZZ6AabzimD?=
 =?us-ascii?Q?C2eFUldiM9lk8QzzkBBs/CvAbwunoJx6Dzz6O1wMBcIPMmkHuu8wbwwty4DY?=
 =?us-ascii?Q?n7pLCVr1wjRouyR6jJk2uk1PIgTPYc4kXD3BZjGH1lQm4/CVmaY0/uEZAylx?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b594168-0f5e-4596-060d-08db00edbeb4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 05:08:52.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w17NGJqda++OhL/4TSOyvimFHZ1X/Ec1szQCGP39jDatPLFHUrhmbkPyd9Qf5bIpPjgIW2SZEmAqDZQd6GVlqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jA4K3bP4o8S3U350
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_drivers/clk/clk.c:#clk_core_populate_parent_map due to commit (built with gcc-11):

commit: cc3ff324b29f06b124b57f745fcc4ec624c87d16 ("[RESEND PATCH] clk: Warn and add workaround on misuse of .parent_data with .name only")
url: https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048
base: https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git clk-next
patch link: https://lore.kernel.org/all/20230111193957.27650-1-ansuelsmth@gmail.com/
patch subject: [RESEND PATCH] clk: Warn and add workaround on misuse of .parent_data with .name only

in testcase: kunit
version: 
with following parameters:

	group: group-02



on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202301280943.6a383af9-oliver.sang@intel.com


[   81.119809][  T621] ------------[ cut here ]------------
[   81.130925][  T621] Empty .fw_name with .name in test_gate's .parent_data. Using .name for .fw_name declaration.
[ 81.141019][ T621] WARNING: CPU: 7 PID: 621 at drivers/clk/clk.c:4057 clk_core_populate_parent_map+0x405/0x610 
[   81.152038][  T621] Modules linked in: clk_gate_test intel_rapl_msr intel_rapl_common btrfs blake2b_generic xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp i915 coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic crc64_rocksoft crc64 intel_gtt sg kvm drm_display_helper ipmi_devintf irqbypass ipmi_msghandler crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy ttm ahci rapl mei_wdt libahci drm_kms_helper intel_cstate syscopyarea mei_me sysfillrect libata intel_uncore video mei sysimgblt wmi drm fuse ip_tables
[   81.200885][  T621] CPU: 7 PID: 621 Comm: kunit_try_catch Tainted: G                 N 6.2.0-rc1-00001-gcc3ff324b29f #1
[   81.211561][  T621] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[ 81.219409][ T621] RIP: clk_core_populate_parent_map+0x405/0x610 
[ 81.226916][ T621] Code: 3c 24 00 0f 84 e8 fd ff ff 48 8b 44 24 20 80 38 00 0f 85 a3 01 00 00 48 8b 04 24 48 c7 c7 20 78 eb 83 48 8b 30 e8 8b 77 1d 01 <0f> 0b 4c 89 e0 48 c1 e8 03 42 80 3c 38 00 0f 85 6f 01 00 00 49 8b
All code
========
   0:	3c 24                	cmp    $0x24,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	84 e8                	test   %ch,%al
   6:	fd                   	std    
   7:	ff                   	(bad)  
   8:	ff 48 8b             	decl   -0x75(%rax)
   b:	44 24 20             	rex.R and $0x20,%al
   e:	80 38 00             	cmpb   $0x0,(%rax)
  11:	0f 85 a3 01 00 00    	jne    0x1ba
  17:	48 8b 04 24          	mov    (%rsp),%rax
  1b:	48 c7 c7 20 78 eb 83 	mov    $0xffffffff83eb7820,%rdi
  22:	48 8b 30             	mov    (%rax),%rsi
  25:	e8 8b 77 1d 01       	callq  0x11d77b5
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	4c 89 e0             	mov    %r12,%rax
  2f:	48 c1 e8 03          	shr    $0x3,%rax
  33:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  38:	0f 85 6f 01 00 00    	jne    0x1ad
  3e:	49                   	rex.WB
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	4c 89 e0             	mov    %r12,%rax
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   e:	0f 85 6f 01 00 00    	jne    0x183
  14:	49                   	rex.WB
  15:	8b                   	.byte 0x8b
[   81.246189][  T621] RSP: 0018:ffffc90000b17bb8 EFLAGS: 00010282
[   81.252058][  T621] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   81.259819][  T621] RDX: 0000000000000004 RSI: 0000000000000008 RDI: fffff52000162f69
[   81.267588][  T621] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffc90000b179ef
[   81.275349][  T621] R10: fffff52000162f3d R11: 0000000000000001 R12: ffffc90000b17e60
[   81.283111][  T621] R13: 0000000000000000 R14: ffff88841e5f9180 R15: dffffc0000000000
[   81.290858][  T621] FS:  0000000000000000(0000) GS:ffff8883b8980000(0000) knlGS:0000000000000000
[   81.299564][  T621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.305953][  T621] CR2: 00007fb2ba883550 CR3: 000000041ce14004 CR4: 00000000001706e0
[   81.313714][  T621] DR0: ffffffff86045121 DR1: ffffffff86045122 DR2: ffffffff86045123
[   81.321473][  T621] DR3: ffffffff86045123 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   81.329231][  T621] Call Trace:
[   81.332363][  T621]  <TASK>
[ 81.335150][ T621] __clk_register (drivers/clk/clk.c:4150) 
[ 81.339656][ T621] clk_hw_register (include/linux/err.h:60 drivers/clk/clk.c:4242) 
[ 81.344063][ T621] __clk_hw_register_gate (drivers/clk/clk-gate.c:172) 
[ 81.349252][ T621] ? devm_clk_hw_release_gate (drivers/clk/clk-gate.c:134) 
[ 81.354612][ T621] ? update_curr (include/linux/cgroup.h:424 include/linux/cgroup.h:493 include/linux/cgroup.h:722 kernel/sched/fair.c:930) 
[ 81.359029][ T621] ? load_balance (kernel/sched/fair.c:11511) 
[ 81.363706][ T621] clk_gate_register_test_parent_data_legacy (drivers/clk/clk-gate_test.c:78 (discriminator 1)) clk_gate_test
[ 81.371901][ T621] ? clk_gate_register_test_parent_hw (drivers/clk/clk-gate_test.c:68) clk_gate_test
[ 81.379494][ T621] ? io_schedule_timeout (kernel/sched/core.c:6437) 
[ 81.384601][ T621] ? set_cpus_allowed_ptr (kernel/sched/core.c:2971) 
[ 81.389609][ T621] ? migrate_enable (kernel/sched/core.c:2971) 
[ 81.394274][ T621] kunit_try_run_case (lib/kunit/test.c:397) 
[ 81.399121][ T621] ? kunit_catch_run_case (lib/kunit/test.c:382) 
[ 81.404138][ T621] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30) 
[ 81.410187][ T621] ? kunit_try_catch_throw (lib/kunit/try-catch.c:25) 
[ 81.415277][ T621] kthread (kernel/kthread.c:376) 
[ 81.419182][ T621] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 81.424617][ T621] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[   81.428863][  T621]  </TASK>
[   81.431732][  T621] ---[ end trace 0000000000000000 ]---
[   81.437519][  T617]     ok 4 clk_gate_register_test_parent_data_legacy
[   81.438007][  T617]     ok 5 clk_gate_register_test_parent_hw
[   81.444626][  T623] gate bit exceeds LOWORD field
[   81.454990][  T617]     ok 6 clk_gate_register_test_hiword_invalid
[   81.454995][  T617] # clk-gate-register-test: pass:6 fail:0 skip:0 total:6
[   81.461124][  T617] # Totals: pass:6 fail:0 skip:0 total:6
[   81.467942][  T617] ok 1 clk-gate-register-test
[   81.477887][  T617]     KTAP version 1
[   81.481605][  T617]     # Subtest: clk-gate-test
[   81.481607][  T617]     1..3
[   81.486715][  T617]     ok 1 clk_gate_test_parent_rate
[   81.489938][  T625] clk_unregister: unregistering prepared clock: test_gate
[   81.501985][  T625] clk_unregister: unregistering prepared clock: test_parent
[   81.509082][  T617]     ok 2 clk_gate_test_enable
[   81.509592][  T617]     ok 3 clk_gate_test_disable
[   81.514273][  T617] # clk-gate-test: pass:3 fail:0 skip:0 total:3
[   81.519038][  T617] # Totals: pass:3 fail:0 skip:0 total:3
[   81.525093][  T617] ok 2 clk-gate-test
[   81.534272][  T617]     KTAP version 1
[   81.537994][  T617]     # Subtest: clk-gate-invert-test
[   81.537997][  T617]     1..2
[   81.543646][  T627] clk_unregister: unregistering prepared clock: test_gate
[   81.553473][  T627] clk_unregister: unregistering prepared clock: test_parent
[   81.560568][  T617]     ok 1 clk_gate_test_invert_enable
[   81.561066][  T617]     ok 2 clk_gate_test_invert_disable
[   81.566341][  T617] # clk-gate-invert-test: pass:2 fail:0 skip:0 total:2
[   81.571695][  T617] # Totals: pass:2 fail:0 skip:0 total:2
[   81.578336][  T617] ok 3 clk-gate-invert-test
[   81.588104][  T617]     KTAP version 1
[   81.591826][  T617]     # Subtest: clk-gate-hiword-test
[   81.591829][  T617]     1..2
[   81.597377][  T629] clk_unregister: unregistering prepared clock: test_gate
[   81.607364][  T629] clk_unregister: unregistering prepared clock: test_parent
[   81.614472][  T617]     ok 1 clk_gate_test_hiword_enable
[   81.614987][  T617]     ok 2 clk_gate_test_hiword_disable
[   81.620270][  T617] # clk-gate-hiword-test: pass:2 fail:0 skip:0 total:2
[   81.625629][  T617] # Totals: pass:2 fail:0 skip:0 total:2
[   81.632270][  T617] ok 4 clk-gate-hiword-test
[   81.642073][  T617]     KTAP version 1
[   81.645796][  T617]     # Subtest: clk-gate-is_enabled-test
[   81.645798][  T617]     1..4
[   81.651734][  T617]     ok 1 clk_gate_test_is_enabled
[   81.654866][  T617]     ok 2 clk_gate_test_is_disabled
[   81.660199][  T617]     ok 3 clk_gate_test_is_enabled_inverted
[   81.665624][  T617]     ok 4 clk_gate_test_is_disabled_inverted
[   81.671423][  T617] # clk-gate-is_enabled-test: pass:4 fail:0 skip:0 total:4
[   81.677294][  T617] # Totals: pass:4 fail:0 skip:0 total:4
[   81.684286][  T617] ok 5 clk-gate-is_enabled-test
[   81.737822][  T641]     KTAP version 1
[   81.741540][  T641]     # Subtest: clk-leaf-mux-set-rate-parent
[   81.741543][  T641]     1..1
[   81.748253][  T641]     ok 1 clk_leaf_mux_set_rate_parent_determine_rate
[   81.751119][  T641] ok 1 clk-leaf-mux-set-rate-parent
[   81.762775][  T641]     KTAP version 1
[   81.766498][  T641]     # Subtest: clk-test
[   81.766502][  T641]     1..4
[   81.770991][  T641]     ok 1 clk_test_get_rate
[   81.774516][  T641]     ok 2 clk_test_set_get_rate
[   81.779284][  T641]     ok 3 clk_test_set_set_get_rate
[   81.784257][  T641]     ok 4 clk_test_round_set_get_rate
[   81.789343][  T641] # clk-test: pass:4 fail:0 skip:0 total:4
[   81.794613][  T641] # Totals: pass:4 fail:0 skip:0 total:4
[   81.800234][  T641] ok 2 clk-test
[   81.808994][  T641]     KTAP version 1
[   81.812718][  T641]     # Subtest: clk-multiple-parents-mux-test
[   81.812721][  T641]     1..3
[   81.819246][  T641]     ok 1 clk_test_multiple_parents_mux_get_parent
[   81.822643][  T641]     ok 2 clk_test_multiple_parents_mux_has_parent
[   81.829698][  T641]     ok 3 clk_test_multiple_parents_mux_set_range_set_parent_get_rate # SKIP This needs to be fixed in the core.
[   81.836074][  T641] # clk-multiple-parents-mux-test: pass:2 fail:0 skip:1 total:3
[   81.847794][  T641] # Totals: pass:2 fail:0 skip:1 total:3
[   81.855207][  T641] ok 3 clk-multiple-parents-mux-test
[   81.865764][  T641]     KTAP version 1
[   81.869487][  T641]     # Subtest: clk-mux-notifier
[   81.869491][  T641]     1..1
[   81.878469][  T641]     ok 1 clk_mux_notifier_set_parent_test
[   81.881330][  T641] ok 4 clk-mux-notifier
[   81.891344][  T641]     KTAP version 1
[   81.895065][  T641]     # Subtest: clk-orphan-transparent-multiple-parent-mux-test
[   81.895069][  T641]     1..9
[   81.903098][  T641]     ok 1 clk_test_orphan_transparent_multiple_parent_mux_get_parent


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



--jA4K3bP4o8S3U350
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc1-00001-gcc3ff324b29f"

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
CONFIG_TIME_KUNIT_TEST=m
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
# CONFIG_CHECKPOINT_RESTORE is not set
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
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

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
# CONFIG_X86_CPU_RESCTRL is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
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
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
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
# CONFIG_X86_SGX is not set
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
CONFIG_CPU_IBPB_ENTRY=y
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
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
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
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
CONFIG_KVM_INTEL=m
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
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
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
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
CONFIG_BINFMT_ELF_KUNIT_TEST=y
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
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
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
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
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
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
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
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
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
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP_KUNIT_TEST=m
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
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
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
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
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
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
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
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
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
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
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
CONFIG_NETDEV_ADDR_LIST_TEST=m

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
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DRIVER_PE_KUNIT_TEST=y
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
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
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
# CONFIG_ZRAM is not set
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
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
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
# CONFIG_USB4_NET is not set
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
# CONFIG_KEYBOARD_ADC is not set
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
# CONFIG_KEYBOARD_CROS_EC is not set
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
CONFIG_I2C_SMBUS=y
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
CONFIG_I2C_I801=y
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
# CONFIG_I2C_CROS_EC_TUNNEL is not set
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
CONFIG_SPI_LOOPBACK_TEST=m
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
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
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
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_CROS_PCHG=m
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
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
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
# CONFIG_SENSORS_IIO_HWMON is not set
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
CONFIG_SENSORS_NTC_THERMISTOR=m
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

# CONFIG_GENERIC_ADC_THERMAL is not set
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
CONFIG_MFD_CROS_EC_DEV=m
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
CONFIG_LPC_ICH=y
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
CONFIG_RC_CORE=m
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
# CONFIG_IR_SHARP_DECODER is not set
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

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

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
CONFIG_DRM_KUNIT_TEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
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
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y
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
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
# CONFIG_SND_HDA_CODEC_HDMI is not set
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
# CONFIG_SND_HDA_GENERIC is not set
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
# CONFIG_SND_ISIGHT is not set
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
# CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST is not set
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
# CONFIG_SND_SOC_INTEL_SKL is not set
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT298 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_SPI is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS42L83 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DA7213 is not set
# CONFIG_SND_SOC_DMIC is not set
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
# CONFIG_SND_SOC_ES8316 is not set
# CONFIG_SND_SOC_ES8326 is not set
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
# CONFIG_SND_SOC_MAX98357A is not set
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98520 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98390 is not set
# CONFIG_SND_SOC_MAX98396 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
# CONFIG_SND_SOC_RT5640 is not set
# CONFIG_SND_SOC_RT5659 is not set
# CONFIG_SND_SOC_RT9120 is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS2780 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS5805M is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8731_SPI is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8940 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8961 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
# CONFIG_SND_VIRTIO is not set

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
# CONFIG_HID_PRODIKEYS is not set
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
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
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
CONFIG_HID_KUNIT_TEST=m
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
CONFIG_RTC_LIB_KUNIT_TEST=m
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
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
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
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
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
# CONFIG_STAGING is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_ISHTP is not set
# CONFIG_CROS_EC_SPI is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
# CONFIG_CROS_HPS_I2C is not set
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_CROS_TYPEC_SWITCH=m
CONFIG_CROS_KUNIT=m
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
# CONFIG_AMD_HSMP is not set
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
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
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
# CONFIG_ACPI_TOSHIBA is not set
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
CONFIG_CLK_KUNIT_TEST=m
CONFIG_CLK_GATE_KUNIT_TEST=m
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
CONFIG_IIO=m
# CONFIG_IIO_BUFFER is not set
# CONFIG_IIO_CONFIGFS is not set
# CONFIG_IIO_TRIGGER is not set
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_BMI088_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
# CONFIG_HID_SENSOR_ACCEL_3D is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_SCA3300 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD4130 is not set
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7280 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX11205 is not set
# CONFIG_MAX11410 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_TI_TSC2046 is not set
# CONFIG_VF610_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74115 is not set
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_ADA4250 is not set
# CONFIG_HMC425 is not set
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
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

#
# Hid Sensor IIO Common
#
# CONFIG_HID_SENSOR_IIO_COMMON is not set
# end of Hid Sensor IIO Common

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC2688 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7293 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# CONFIG_ADMV8818 is not set
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# CONFIG_ADF4377 is not set
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_HID_SENSOR_ALS is not set
# CONFIG_HID_SENSOR_PROX is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LTRF216A is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
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
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

CONFIG_IIO_RESCALE_KUNIT_TEST=m
CONFIG_IIO_FORMAT_KUNIT_TEST=m

#
# Linear and angular position sensors
#
# CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_CROS_EC_MKBP_PROXIMITY is not set
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX30208 is not set
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

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
# CONFIG_PWM_CROS_EC is not set
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
# CONFIG_PHY_CPCAP_USB is not set
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
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_KUNIT_TEST=y
# CONFIG_USB4_DMA_TEST is not set

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
# CONFIG_TEE is not set
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
CONFIG_EXT4_KUNIT_TESTS=m
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
CONFIG_FAT_KUNIT_TEST=m
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
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
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=m
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
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
# CONFIG_CRYPTO_SM4_GENERIC is not set
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
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
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
CONFIG_FIPS_SIGNATURE_SELFTEST=y

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
CONFIG_LINEAR_RANGES=m
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
CONFIG_CRC32_SELFTEST=m
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
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
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
CONFIG_OBJTOOL=y
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
CONFIG_KASAN_KUNIT_TEST=m
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
# CONFIG_KFENCE_DEFERRABLE is not set
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
CONFIG_KFENCE_KUNIT_TEST=m
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
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

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
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
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
CONFIG_FTRACE_SORT_STARTUP_TEST=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
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
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_KUNIT_ALL_TESTS=m
CONFIG_KUNIT_DEFAULT_ENABLED=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_CPUMASK_KUNIT_TEST=m
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_MIN_HEAP=m
CONFIG_TEST_SORT=m
CONFIG_TEST_DIV64=m
# CONFIG_KPROBES_SANITY_TEST is not set
CONFIG_FPROBE_SANITY_TEST=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_STRING_SELFTEST=m
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
CONFIG_TEST_XARRAY=m
# CONFIG_TEST_MAPLE_TREE is not set
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_IDA=m
# CONFIG_TEST_LKM is not set
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_SLUB_KUNIT_TEST=m
CONFIG_RATIONAL_KUNIT_TEST=m
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
CONFIG_FORTIFY_KUNIT_TEST=m
CONFIG_HW_BREAKPOINT_KUNIT_TEST=y
CONFIG_STRSCPY_KUNIT_TEST=m
CONFIG_SIPHASH_KUNIT_TEST=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
CONFIG_TEST_MEMCAT_P=m
CONFIG_TEST_LIVEPATCH=m
CONFIG_TEST_MEMINIT=m
CONFIG_TEST_HMM=m
CONFIG_TEST_FREE_PAGES=m
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

--jA4K3bP4o8S3U350
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kunit'
	export testcase='kunit'
	export category='functional'
	export job_origin='kunit.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='vip'
	export testbox='lkp-hsw-d03'
	export tbox_group='lkp-hsw-d03'
	export submit_id='63cbdc5c50daa6561dfc0e9d'
	export job_file='/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml'
	export id='17f25473efcbd2b91fa1f9ae84ec937e34193f22'
	export queuer_version='/zday/lkp'
	export model='Haswell'
	export nr_node=1
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST31000524AS_6VPHDMY6-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G6_BTWA6075012T480FGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G6_BTWA6075012T480FGN-part2'
	export brand='Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz'
	export commit='cc3ff324b29f06b124b57f745fcc4ec624c87d16'
	export ucode='0x28'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export bisect_dmesg=true
	export need_kconfig=\{\"BINFMT_ELF_KUNIT_TEST\"\=\>\"y\"\}'
'\{\"CLK_GATE_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"CLK_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"CPUMASK_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"CHROME_PLATFORMS\"\=\>\"y\"\}'
'\{\"CROS_EC\"\=\>\"m\"\}'
'\{\"CROS_KUNIT\"\=\>\"m\"\}'
'\{\"FIPS_SIGNATURE_SELFTEST\"\=\>\"y\"\}'
'\{\"FPROBE\"\=\>\"y\"\}'
'\{\"FPROBE_SANITY_TEST\"\=\>\"y\"\}'
'\{\"HID_UCLOGIC\"\=\>\"m\"\}'
'\{\"HID_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"IIO\"\=\>\"m\"\}'
'\{\"IIO_FORMAT_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"IIO_RESCALE\"\=\>\"m\"\}'
'\{\"IIO_RESCALE_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"OVERFLOW_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"SOUND\"\=\>\"m\"\}'
'\{\"SND\"\=\>\"m\"\}'
'\{\"SND_SOC\"\=\>\"m\"\}'
'\{\"SND_SOC_INTEL_AVS\"\=\>\"m\"\}'
'\{\"SND_SOC_INTEL_AVS_MACH_I2S_TEST\"\=\>\"m\"\}'
'\{\"SND_SOC_UTILS_KUNIT_TEST\"\=\>\"m\"\}'
'\{\"STACKINIT_KUNIT_TEST\"\=\>\"m\"\}
	export kconfig='x86_64-rhel-8.3-kunit'
	export enqueue_time='2023-01-21 20:36:44 +0800'
	export _id='63cbdc5c50daa6561dfc0e9d'
	export _rt='/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='7d54d3fcdaa6c8e053ed21160dd229cae8681ae4'
	export base_commit='5dc4c995db9eb45f6373a956eb1f69460e69e6d4'
	export branch='linux-review/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f
branch=linux-review/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048
job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kunit
commit=cc3ff324b29f06b124b57f745fcc4ec624c87d16
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.2.0-rc3'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.WARNING:at_drivers/clk/clk.c:#clk_core_populate_parent_map'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f'
	export dequeue_time='2023-01-21 20:48:37 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.cgz'

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

	run_test group='group-02' $LKP_SRC/tests/wrapper kunit
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-02' $LKP_SRC/stats/wrapper kunit
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kunit.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--jA4K3bP4o8S3U350
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--jA4K3bP4o8S3U350
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kunit"

[    0.000000] Linux version 6.2.0-rc1-00001-gcc3ff324b29f (kbuild@7bd7ffd1c955) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39.90.20221231) #1 SMP Sat Jan 21 19:20:44 CST 2023
[    0.000000] Command line: ip=::::lkp-hsw-d03::dhcp root=/dev/ram0 RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f branch=linux-review/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048 job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kunit commit=cc3ff324b29f06b124b57f745fcc4ec624c87d16 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000400-0x000000000009d7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d1694fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d1695000-0x00000000d169bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d169c000-0x00000000d1ac9fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d1aca000-0x00000000d1f4afff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d1f4b000-0x00000000d7eeafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d7eeb000-0x00000000d7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8000000-0x00000000d875ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8760000-0x00000000d87fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8800000-0x00000000d8fadfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8fae000-0x00000000d8ffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d9000000-0x00000000da71bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000da71c000-0x00000000da7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000da800000-0x00000000dbb8cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dbb8d000-0x00000000dbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df1fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041edfffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3392.168 MHz processor
[    0.000905] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.008055] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.014247] last_pfn = 0x41ee00 max_arch_pfn = 0x400000000
[    0.020347] total RAM covered: 16318M
[    0.024945]  gran_size: 64K 	chunk_size: 64K 	num_reg: 10  	lose cover RAM: 110M
[    0.032782]  gran_size: 64K 	chunk_size: 128K 	num_reg: 10  	lose cover RAM: 110M
[    0.040854]  gran_size: 64K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 110M
[    0.048926]  gran_size: 64K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 110M
[    0.056999]  gran_size: 64K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 110M
[    0.064900]  gran_size: 64K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 110M
[    0.072799]  gran_size: 64K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.080698]  gran_size: 64K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.088598]  gran_size: 64K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.096585] *BAD*gran_size: 64K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.104914]  gran_size: 64K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.112731]  gran_size: 64K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.120632]  gran_size: 64K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.128532]  gran_size: 64K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 0G
[    0.136434]  gran_size: 64K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 0G
[    0.144162] *BAD*gran_size: 64K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1G
[    0.152322]  gran_size: 128K 	chunk_size: 128K 	num_reg: 10  	lose cover RAM: 110M
[    0.160480]  gran_size: 128K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 110M
[    0.168640]  gran_size: 128K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 110M
[    0.176799]  gran_size: 128K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 110M
[    0.184785]  gran_size: 128K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 110M
[    0.192773]  gran_size: 128K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.200760]  gran_size: 128K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.208748]  gran_size: 128K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.216820] *BAD*gran_size: 128K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.225236]  gran_size: 128K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.233139]  gran_size: 128K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.241127]  gran_size: 128K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.249114]  gran_size: 128K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 0G
[    0.257101]  gran_size: 128K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 0G
[    0.264917] *BAD*gran_size: 128K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1G
[    0.273162]  gran_size: 256K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 110M
[    0.281323]  gran_size: 256K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 110M
[    0.289482]  gran_size: 256K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 110M
[    0.297468]  gran_size: 256K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 110M
[    0.305455]  gran_size: 256K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.313443]  gran_size: 256K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.321430]  gran_size: 256K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.329504] *BAD*gran_size: 256K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.337919]  gran_size: 256K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.345821]  gran_size: 256K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.353808]  gran_size: 256K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.361795]  gran_size: 256K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 0G
[    0.369782]  gran_size: 256K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 0G
[    0.377597] *BAD*gran_size: 256K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1G
[    0.385841]  gran_size: 512K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 110M
[    0.393998]  gran_size: 512K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 110M
[    0.401984]  gran_size: 512K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 110M
[    0.409970]  gran_size: 512K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.417957]  gran_size: 512K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.425943]  gran_size: 512K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.434015] *BAD*gran_size: 512K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.442433]  gran_size: 512K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.450334]  gran_size: 512K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.458321]  gran_size: 512K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.466309]  gran_size: 512K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 0G
[    0.474297]  gran_size: 512K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 0G
[    0.482112] *BAD*gran_size: 512K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1G
[    0.490358]  gran_size: 1M 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 110M
[    0.498173]  gran_size: 1M 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 110M
[    0.505989]  gran_size: 1M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.513805]  gran_size: 1M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.521618]  gran_size: 1M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.529521] *BAD*gran_size: 1M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.537764]  gran_size: 1M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.545494]  gran_size: 1M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.553310]  gran_size: 1M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.561125]  gran_size: 1M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 0G
[    0.568942]  gran_size: 1M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 0G
[    0.576585] *BAD*gran_size: 1M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1G
[    0.584658]  gran_size: 2M 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 110M
[    0.592472]  gran_size: 2M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.600287]  gran_size: 2M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.608103]  gran_size: 2M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.616003] *BAD*gran_size: 2M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.624249]  gran_size: 2M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 0G
[    0.631977]  gran_size: 2M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 0G
[    0.639793]  gran_size: 2M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 0G
[    0.647609]  gran_size: 2M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 0G
[    0.655425]  gran_size: 2M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 0G
[    0.663069] *BAD*gran_size: 2M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1G
[    0.671141]  gran_size: 4M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 110M
[    0.678956]  gran_size: 4M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.686772]  gran_size: 4M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.694672] *BAD*gran_size: 4M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.702919]  gran_size: 4M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 2M
[    0.710649]  gran_size: 4M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 2M
[    0.718465]  gran_size: 4M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 2M
[    0.726280]  gran_size: 4M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 2M
[    0.734096]  gran_size: 4M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 2M
[    0.741741] *BAD*gran_size: 4M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1022M
[    0.750071]  gran_size: 8M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 110M
[    0.757888]  gran_size: 8M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.765789] *BAD*gran_size: 8M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: -18M
[    0.774035]  gran_size: 8M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 6M
[    0.781762]  gran_size: 8M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 6M
[    0.789579]  gran_size: 8M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 6M
[    0.797392]  gran_size: 8M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 6M
[    0.805207]  gran_size: 8M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 6M
[    0.812852] *BAD*gran_size: 8M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -1018M
[    0.821182]  gran_size: 16M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 110M
[    0.829169]  gran_size: 16M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 238M
[    0.837155]  gran_size: 16M 	chunk_size: 64M 	num_reg: 9  	lose cover RAM: 14M
[    0.844971]  gran_size: 16M 	chunk_size: 128M 	num_reg: 9  	lose cover RAM: 14M
[    0.852875]  gran_size: 16M 	chunk_size: 256M 	num_reg: 9  	lose cover RAM: 14M
[    0.860776]  gran_size: 16M 	chunk_size: 512M 	num_reg: 9  	lose cover RAM: 14M
[    0.868679]  gran_size: 16M 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 14M
[    0.876410]  gran_size: 16M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: 14M
[    0.884228]  gran_size: 32M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 62M
[    0.892128]  gran_size: 32M 	chunk_size: 64M 	num_reg: 9  	lose cover RAM: 30M
[    0.899941]  gran_size: 32M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 30M
[    0.907845]  gran_size: 32M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 30M
[    0.915747]  gran_size: 32M 	chunk_size: 512M 	num_reg: 8  	lose cover RAM: 30M
[    0.923651]  gran_size: 32M 	chunk_size: 1G 	num_reg: 8  	lose cover RAM: 30M
[    0.931381]  gran_size: 32M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 30M
[    0.939111]  gran_size: 64M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 62M
[    0.947015]  gran_size: 64M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 62M
[    0.954915]  gran_size: 64M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 62M
[    0.962819]  gran_size: 64M 	chunk_size: 512M 	num_reg: 8  	lose cover RAM: 62M
[    0.970719]  gran_size: 64M 	chunk_size: 1G 	num_reg: 8  	lose cover RAM: 62M
[    0.978449]  gran_size: 64M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 62M
[    0.986180]  gran_size: 128M 	chunk_size: 128M 	num_reg: 8  	lose cover RAM: 190M
[    0.994254]  gran_size: 128M 	chunk_size: 256M 	num_reg: 8  	lose cover RAM: 190M
[    1.002328]  gran_size: 128M 	chunk_size: 512M 	num_reg: 8  	lose cover RAM: 190M
[    1.010402]  gran_size: 128M 	chunk_size: 1G 	num_reg: 8  	lose cover RAM: 190M
[    1.018301]  gran_size: 128M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 190M
[    1.026205]  gran_size: 256M 	chunk_size: 256M 	num_reg: 6  	lose cover RAM: 446M
[    1.034279]  gran_size: 256M 	chunk_size: 512M 	num_reg: 8  	lose cover RAM: 446M
[    1.042352]  gran_size: 256M 	chunk_size: 1G 	num_reg: 8  	lose cover RAM: 446M
[    1.050256]  gran_size: 256M 	chunk_size: 2G 	num_reg: 9  	lose cover RAM: 446M
[    1.058158]  gran_size: 512M 	chunk_size: 512M 	num_reg: 4  	lose cover RAM: 958M
[    1.066231]  gran_size: 512M 	chunk_size: 1G 	num_reg: 4  	lose cover RAM: 958M
[    1.074135]  gran_size: 512M 	chunk_size: 2G 	num_reg: 4  	lose cover RAM: 958M
[    1.082035]  gran_size: 1G 	chunk_size: 1G 	num_reg: 4  	lose cover RAM: 958M
[    1.089764]  gran_size: 1G 	chunk_size: 2G 	num_reg: 4  	lose cover RAM: 958M
[    1.097495]  gran_size: 2G 	chunk_size: 2G 	num_reg: 3  	lose cover RAM: 1982M
[    1.105309] mtrr_cleanup: can not find optimal value
[    1.110893] please specify mtrr_gran_size/mtrr_chunk_size
[    1.116905] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    1.124744] e820: update [mem 0xdd000000-0xffffffff] usable ==> reserved
[    1.131894] x2apic: enabled by BIOS, switching to x2apic ops
[    1.138165] last_pfn = 0xdbb8d max_arch_pfn = 0x400000000
[    1.144177] Scan for SMP in [mem 0x00000000-0x000003ff]
[    1.150034] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    1.155874] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    1.167600] found SMP MP-table at [mem 0x000fd970-0x000fd97f]
[    1.173806]   mpc: fd6b0-fd8f4
[    1.177511] Using GB pages for direct mapping
[    1.185140] RAMDISK: [mem 0x4087fc000-0x4197fffff]
[    1.190401] ACPI: Early table checksum verification disabled
[    1.196672] ACPI: RSDP 0x00000000000F0490 000024 (v02 DELL  )
[    1.203028] ACPI: XSDT 0x00000000D8FEE088 000094 (v01 DELL   CBX3     01072009 AMI  00010013)
[    1.212135] ACPI: FACP 0x00000000D8FF94B0 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    1.221241] ACPI: DSDT 0x00000000D8FEE1B0 00B2FD (v02 DELL   CBX3     00000014 INTL 20091112)
[    1.230340] ACPI: FACS 0x00000000DA7FE080 000040
[    1.235583] ACPI: APIC 0x00000000D8FF95C0 000092 (v03 DELL   CBX3     01072009 AMI  00010013)
[    1.244686] ACPI: FPDT 0x00000000D8FF9658 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    1.253792] ACPI: SLIC 0x00000000D8FF96A0 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    1.262895] ACPI: LPIT 0x00000000D8FF9818 00005C (v01 DELL   CBX3     00000000 AMI. 00000005)
[    1.272003] ACPI: SSDT 0x00000000D8FF9878 000539 (v01 PmRef  Cpu0Ist  00003000 INTL 20120711)
[    1.281107] ACPI: SSDT 0x00000000D8FF9DB8 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20120711)
[    1.290211] ACPI: SSDT 0x00000000D8FFA890 0001C7 (v01 PmRef  LakeTiny 00003000 INTL 20120711)
[    1.299316] ACPI: HPET 0x00000000D8FFAA58 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    1.308420] ACPI: SSDT 0x00000000D8FFAA90 00036D (v01 SataRe SataTabl 00001000 INTL 20120711)
[    1.317524] ACPI: MCFG 0x00000000D8FFAE00 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    1.326629] ACPI: SSDT 0x00000000D8FFAE40 003406 (v01 SaSsdt SaSsdt   00003000 INTL 20091112)
[    1.335733] ACPI: ASF! 0x00000000D8FFE248 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    1.344837] ACPI: DMAR 0x00000000D8FFE2F0 0000B8 (v01 INTEL  HSW      00000001 INTL 00000001)
[    1.353942] ACPI: Reserving FACP table memory at [mem 0xd8ff94b0-0xd8ff95bb]
[    1.361587] ACPI: Reserving DSDT table memory at [mem 0xd8fee1b0-0xd8ff94ac]
[    1.369230] ACPI: Reserving FACS table memory at [mem 0xda7fe080-0xda7fe0bf]
[    1.376875] ACPI: Reserving APIC table memory at [mem 0xd8ff95c0-0xd8ff9651]
[    1.384519] ACPI: Reserving FPDT table memory at [mem 0xd8ff9658-0xd8ff969b]
[    1.392164] ACPI: Reserving SLIC table memory at [mem 0xd8ff96a0-0xd8ff9815]
[    1.399809] ACPI: Reserving LPIT table memory at [mem 0xd8ff9818-0xd8ff9873]
[    1.407452] ACPI: Reserving SSDT table memory at [mem 0xd8ff9878-0xd8ff9db0]
[    1.415096] ACPI: Reserving SSDT table memory at [mem 0xd8ff9db8-0xd8ffa88f]
[    1.422741] ACPI: Reserving SSDT table memory at [mem 0xd8ffa890-0xd8ffaa56]
[    1.430385] ACPI: Reserving HPET table memory at [mem 0xd8ffaa58-0xd8ffaa8f]
[    1.438029] ACPI: Reserving SSDT table memory at [mem 0xd8ffaa90-0xd8ffadfc]
[    1.445675] ACPI: Reserving MCFG table memory at [mem 0xd8ffae00-0xd8ffae3b]
[    1.453319] ACPI: Reserving SSDT table memory at [mem 0xd8ffae40-0xd8ffe245]
[    1.460962] ACPI: Reserving ASF! table memory at [mem 0xd8ffe248-0xd8ffe2ec]
[    1.468606] ACPI: Reserving DMAR table memory at [mem 0xd8ffe2f0-0xd8ffe3a7]
[    1.476261] Setting APIC routing to cluster x2apic.
[    1.481839] No NUMA configuration found
[    1.486213] Faking a node at [mem 0x0000000000000000-0x000000041edfffff]
[    1.493529] NODE_DATA(0) allocated [mem 0x41edd5000-0x41edfffff]
[    1.500458] Zone ranges:
[    1.503484]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    1.510268]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    1.517053]   Normal   [mem 0x0000000100000000-0x000000041edfffff]
[    1.523838]   Device   empty
[    1.527358] Movable zone start for each node
[    1.532255] Early memory node ranges
[    1.536462]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    1.543330]   node   0: [mem 0x0000000000100000-0x00000000d1694fff]
[    1.550204]   node   0: [mem 0x00000000d169c000-0x00000000d1ac9fff]
[    1.557073]   node   0: [mem 0x00000000d1f4b000-0x00000000d7eeafff]
[    1.563946]   node   0: [mem 0x00000000d8000000-0x00000000d875ffff]
[    1.570815]   node   0: [mem 0x00000000d8800000-0x00000000d8fadfff]
[    1.577688]   node   0: [mem 0x00000000d9000000-0x00000000da71bfff]
[    1.584557]   node   0: [mem 0x00000000da800000-0x00000000dbb8cfff]
[    1.591431]   node   0: [mem 0x0000000100000000-0x000000041edfffff]
[    1.598303] Initmem setup node 0 [mem 0x0000000000001000-0x000000041edfffff]
[    1.605954] On node 0, zone DMA: 1 pages in unavailable ranges
[    1.606081] On node 0, zone DMA: 99 pages in unavailable ranges
[    1.635778] On node 0, zone DMA32: 7 pages in unavailable ranges
[    1.642921] On node 0, zone DMA32: 1153 pages in unavailable ranges
[    1.649452] On node 0, zone DMA32: 277 pages in unavailable ranges
[    1.656317] On node 0, zone DMA32: 160 pages in unavailable ranges
[    1.663214] On node 0, zone DMA32: 82 pages in unavailable ranges
[    1.670009] On node 0, zone DMA32: 228 pages in unavailable ranges
[    1.678183] On node 0, zone Normal: 17523 pages in unavailable ranges
[    1.684999] On node 0, zone Normal: 4608 pages in unavailable ranges
[    1.933879] kasan: KernelAddressSanitizer initialized
[    1.946361] Reserving Intel graphics memory at [mem 0xdd200000-0xdf1fffff]
[    1.954038] ACPI: PM-Timer IO Port: 0x1808
[    1.958615] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    1.965144] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    1.972606] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    1.979562] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 8, APIC INT 02
[    1.987376] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    1.994588] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 8, APIC INT 09
[    2.002402] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 8, APIC INT 01
[    2.010214] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 8, APIC INT 03
[    2.018030] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 8, APIC INT 04
[    2.025845] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 8, APIC INT 05
[    2.033658] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 8, APIC INT 06
[    2.041472] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 8, APIC INT 07
[    2.049288] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 8, APIC INT 08
[    2.057104] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 8, APIC INT 0a
[    2.064922] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 8, APIC INT 0b
[    2.072736] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 8, APIC INT 0c
[    2.080551] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 8, APIC INT 0d
[    2.088366] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 8, APIC INT 0e
[    2.096181] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 8, APIC INT 0f
[    2.103998] ACPI: Using ACPI (MADT) for SMP configuration information
[    2.111037] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    2.116793] TSC deadline timer available
[    2.121343] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    2.126927] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    2.132884] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    2.141011] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    2.149166] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    2.157327] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    2.165487] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    2.173645] PM: hibernation: Registered nosave memory: [mem 0xd1695000-0xd169bfff]
[    2.181805] PM: hibernation: Registered nosave memory: [mem 0xd1aca000-0xd1f4afff]
[    2.189962] PM: hibernation: Registered nosave memory: [mem 0xd7eeb000-0xd7ffffff]
[    2.198120] PM: hibernation: Registered nosave memory: [mem 0xd8760000-0xd87fffff]
[    2.206278] PM: hibernation: Registered nosave memory: [mem 0xd8fae000-0xd8ffffff]
[    2.214438] PM: hibernation: Registered nosave memory: [mem 0xda71c000-0xda7fffff]
[    2.222596] PM: hibernation: Registered nosave memory: [mem 0xdbb8d000-0xdbffffff]
[    2.230753] PM: hibernation: Registered nosave memory: [mem 0xdc000000-0xdcffffff]
[    2.238913] PM: hibernation: Registered nosave memory: [mem 0xdd000000-0xdf1fffff]
[    2.247071] PM: hibernation: Registered nosave memory: [mem 0xdf200000-0xf7ffffff]
[    2.255230] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    2.263391] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    2.271551] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    2.279708] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    2.287866] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    2.296024] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    2.304183] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    2.312342] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    2.320500] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    2.328661] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    2.336819] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    2.344980] [mem 0xdf200000-0xf7ffffff] available for PCI devices
[    2.351675] Booting paravirtualized kernel on bare hardware
[    2.357862] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    2.383335] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    2.392126] percpu: Embedded 68 pages/cpu s238056 r8192 d32280 u524288
[    2.399113] pcpu-alloc: s238056 r8192 d32280 u524288 alloc=1*2097152
[    2.406060] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
[    2.411346] Fallback order for Node 0: 0 
[    2.415937] Built 1 zonelists, mobility grouping on.  Total pages: 4104849
[    2.423408] Policy zone: Normal
[    2.427186] Kernel command line: ip=::::lkp-hsw-d03::dhcp root=/dev/ram0 RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f branch=linux-review/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048 job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kunit commit=cc3ff324b29f06b124b57f745fcc4ec624c87d16 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=pani
[    2.427458] sysrq: sysrq always enabled.
[    2.517660] ignoring the deprecated load_ramdisk= option
[    2.523625] Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f branch=linux-review/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048 job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kunit commit=cc3ff324b29f06b124b57f745fcc4ec624c87d16 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
[    2.597735] random: crng init done
[    2.603718] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    2.613306] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    2.622348] mem auto-init: stack:off, heap alloc:off, heap free:off
[    2.630106] stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    2.638380] software IO TLB: area num 8.
[    2.767588] Memory: 3656552K/16680664K available (45056K kernel code, 14102K rwdata, 9184K rodata, 3196K init, 5636K bss, 2827392K reserved, 0K cma-reserved)
[    2.782452] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    2.789449] Kernel/User page tables isolation: enabled
[    2.795239] ftrace: allocating 48995 entries in 192 pages
[    2.801285] ftrace section at ffffffff85d8f220 sorted properly
[    2.818533] ftrace: allocated 192 pages with 2 groups
[    2.824515] rcu: Hierarchical RCU implementation.
[    2.829688] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    2.837076] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
[    2.844975] 	Rude variant of Tasks RCU enabled.
[    2.850127] 	Tracing variant of Tasks RCU enabled.
[    2.855540] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    2.863785] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    2.884583] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
[    2.891342] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    2.898779] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    2.909274] calling  con_init+0x0/0x57d @ 0
[    2.914311] Console: colour dummy device 80x25
[    2.919227] printk: console [tty0] enabled
[    2.924935] initcall con_init+0x0/0x57d returned 0 after 0 usecs
[    2.931398] calling  hvc_console_init+0x0/0x18 @ 0
[    2.936809] initcall hvc_console_init+0x0/0x18 returned 0 after 0 usecs
[    2.944021] calling  univ8250_console_init+0x0/0x2b @ 0
[    2.949881] printk: console [ttyS0] enabled
[    2.959491] printk: bootconsole [earlyser0] disabled
[    2.970666] initcall univ8250_console_init+0x0/0x2b returned 0 after 0 usecs
[    2.978510] ACPI: Core revision 20221020
[    2.983327] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    2.993087] APIC: Switch to symmetric I/O mode setup
[    2.998697] DMAR: Host address width 39
[    3.003187] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    3.009163] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    3.017690] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    3.023655] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    3.032183] DMAR: RMRR base: 0x000000dbcf7000 end: 0x000000dbd04fff
[    3.039081] DMAR: RMRR base: 0x000000dd000000 end: 0x000000df1fffff
[    3.045978] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed91000 IOMMU 1
[    3.052958] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    3.058991] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    3.068477] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
[    3.077122] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
[    3.085542] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    3.091590] masked ExtINT on CPU#0
[    3.095921] ENABLING IO-APIC IRQs
[    3.099898] init IO_APIC IRQs
[    3.103522]  apic 8 pin 0 not connected
[    3.108017] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.122039] IOAPIC[0]: Preconfigured routing entry (8-1 -> IRQ 1 Level:0 ActiveLow:0)
[    3.130481] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.144506] IOAPIC[0]: Preconfigured routing entry (8-2 -> IRQ 0 Level:0 ActiveLow:0)
[    3.152955] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.166979] IOAPIC[0]: Preconfigured routing entry (8-3 -> IRQ 3 Level:0 ActiveLow:0)
[    3.175426] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.189447] IOAPIC[0]: Preconfigured routing entry (8-4 -> IRQ 4 Level:0 ActiveLow:0)
[    3.197890] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.211910] IOAPIC[0]: Preconfigured routing entry (8-5 -> IRQ 5 Level:0 ActiveLow:0)
[    3.220360] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.234379] IOAPIC[0]: Preconfigured routing entry (8-6 -> IRQ 6 Level:0 ActiveLow:0)
[    3.242823] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.256844] IOAPIC[0]: Preconfigured routing entry (8-7 -> IRQ 7 Level:0 ActiveLow:0)
[    3.265291] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.279312] IOAPIC[0]: Preconfigured routing entry (8-8 -> IRQ 8 Level:0 ActiveLow:0)
[    3.287758] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.301780] IOAPIC[0]: Preconfigured routing entry (8-9 -> IRQ 9 Level:1 ActiveLow:0)
[    3.310233] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.324257] IOAPIC[0]: Preconfigured routing entry (8-10 -> IRQ 10 Level:0 ActiveLow:0)
[    3.332877] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.346897] IOAPIC[0]: Preconfigured routing entry (8-11 -> IRQ 11 Level:0 ActiveLow:0)
[    3.355516] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.369539] IOAPIC[0]: Preconfigured routing entry (8-12 -> IRQ 12 Level:0 ActiveLow:0)
[    3.378156] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.392177] IOAPIC[0]: Preconfigured routing entry (8-13 -> IRQ 13 Level:0 ActiveLow:0)
[    3.400799] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.414819] IOAPIC[0]: Preconfigured routing entry (8-14 -> IRQ 14 Level:0 ActiveLow:0)
[    3.423438] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[    3.437462] IOAPIC[0]: Preconfigured routing entry (8-15 -> IRQ 15 Level:0 ActiveLow:0)
[    3.446071]  apic 8 pin 16 not connected
[    3.450638]  apic 8 pin 17 not connected
[    3.455205]  apic 8 pin 18 not connected
[    3.459773]  apic 8 pin 19 not connected
[    3.464340]  apic 8 pin 20 not connected
[    3.468908]  apic 8 pin 21 not connected
[    3.473474]  apic 8 pin 22 not connected
[    3.478040]  apic 8 pin 23 not connected
[    3.482743] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    3.494058] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x30e56840ea1, max_idle_ns: 440795288733 ns
[    3.505161] Calibrating delay loop (skipped), value calculated using timer frequency.. 6784.33 BogoMIPS (lpj=3392168)
[    3.506163] pid_max: default: 32768 minimum: 301
[    3.507265] LSM: initializing lsm=capability,yama,integrity,apparmor
[    3.508177] Yama: becoming mindful.
[    3.509274] AppArmor: AppArmor initialized
[    3.510269] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    3.511196] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    3.513368] CPU0: Thermal monitoring enabled (TM1)
[    3.514197] process: using mwait in idle threads
[    3.515164] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    3.516161] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    3.517165] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    3.518165] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    3.518167] Spectre V2 : Vulnerable
[    3.520160] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    3.521161] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    3.522164] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    3.523162] Spectre V2 : User space: Mitigation: STIBP via prctl
[    3.524164] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    3.525164] MDS: Mitigation: Clear CPU buffers
[    3.526160] MMIO Stale Data: Unknown: No mitigations
[    3.527161] SRBDS: Mitigation: Microcode
[    3.533524] Freeing SMP alternatives memory: 44K
[    3.534364] smpboot: CPU0: Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    3.535569] cblist_init_generic: Setting adjustable number of callback queues.
[    3.536159] cblist_init_generic: Setting shift to 3 and lim to 1.
[    3.537212] cblist_init_generic: Setting shift to 3 and lim to 1.
[    3.538206] calling  init_hw_perf_events+0x0/0x5aa @ 1
[    3.539162] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    3.540164] ... version:                3
[    3.541161] ... bit width:              48
[    3.542161] ... generic registers:      4
[    3.543161] ... value mask:             0000ffffffffffff
[    3.544161] ... max period:             00007fffffffffff
[    3.545161] ... fixed-purpose events:   3
[    3.546161] ... event mask:             000000070000000f
[    3.547298] initcall init_hw_perf_events+0x0/0x5aa returned 0 after 8000 usecs
[    3.548162] calling  do_init_real_mode+0x0/0x12 @ 1
[    3.549170] initcall do_init_real_mode+0x0/0x12 returned 0 after 0 usecs
[    3.550162] calling  trace_init_perf_perm_irq_work_exit+0x0/0x17 @ 1
[    3.551161] initcall trace_init_perf_perm_irq_work_exit+0x0/0x17 returned 0 after 0 usecs
[    3.552161] calling  bp_init_aperfmperf+0x0/0x5e @ 1
[    3.553174] Estimated ratio of average max frequency by base frequency (times 1024): 1114
[    3.554162] initcall bp_init_aperfmperf+0x0/0x5e returned 0 after 1000 usecs
[    3.555161] calling  register_nmi_cpu_backtrace_handler+0x0/0x1a @ 1
[    3.556161] initcall register_nmi_cpu_backtrace_handler+0x0/0x1a returned 0 after 0 usecs
[    3.557161] calling  kvm_setup_vsyscall_timeinfo+0x0/0xe1 @ 1
[    3.558161] initcall kvm_setup_vsyscall_timeinfo+0x0/0xe1 returned 0 after 0 usecs
[    3.559161] calling  spawn_ksoftirqd+0x0/0x3d @ 1
[    3.560213] initcall spawn_ksoftirqd+0x0/0x3d returned 0 after 0 usecs
[    3.561162] calling  migration_init+0x0/0xd5 @ 1
[    3.562161] initcall migration_init+0x0/0xd5 returned 0 after 0 usecs
[    3.563161] calling  srcu_bootup_announce+0x0/0x7c @ 1
[    3.564161] rcu: Hierarchical SRCU implementation.
[    3.565161] rcu: 	Max phase no-delay instances is 400.
[    3.566161] initcall srcu_bootup_announce+0x0/0x7c returned 0 after 2000 usecs
[    3.567162] calling  rcu_spawn_gp_kthread+0x0/0x319 @ 1
[    3.568208] initcall rcu_spawn_gp_kthread+0x0/0x319 returned 0 after 0 usecs
[    3.569162] calling  check_cpu_stall_init+0x0/0x1f @ 1
[    3.570161] initcall check_cpu_stall_init+0x0/0x1f returned 0 after 0 usecs
[    3.571161] calling  rcu_sysrq_init+0x0/0x26 @ 1
[    3.572161] initcall rcu_sysrq_init+0x0/0x26 returned 0 after 0 usecs
[    3.573161] calling  trace_init_flags_sys_enter+0x0/0x13 @ 1
[    3.574161] initcall trace_init_flags_sys_enter+0x0/0x13 returned 0 after 0 usecs
[    3.575161] calling  trace_init_flags_sys_exit+0x0/0x13 @ 1
[    3.576161] initcall trace_init_flags_sys_exit+0x0/0x13 returned 0 after 0 usecs
[    3.577161] calling  cpu_stop_init+0x0/0x168 @ 1
[    3.578216] initcall cpu_stop_init+0x0/0x168 returned 0 after 0 usecs
[    3.579164] calling  init_kprobes+0x0/0x25d @ 1
[    3.580626] initcall init_kprobes+0x0/0x25d returned 0 after 0 usecs
[    3.581162] calling  init_events+0x0/0xc6 @ 1
[    3.582172] initcall init_events+0x0/0xc6 returned 0 after 0 usecs
[    3.583161] calling  init_trace_printk+0x0/0x10 @ 1
[    3.584161] initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
[    3.585161] calling  event_trace_enable_again+0x0/0x23 @ 1
[    3.586161] initcall event_trace_enable_again+0x0/0x23 returned 0 after 0 usecs
[    3.587161] calling  irq_work_init_threads+0x0/0x7 @ 1
[    3.588161] initcall irq_work_init_threads+0x0/0x7 returned 0 after 0 usecs
[    3.589161] calling  static_call_init+0x0/0x91 @ 1
[    3.590161] initcall static_call_init+0x0/0x91 returned 0 after 0 usecs
[    3.591161] calling  jump_label_init_module+0x0/0x15 @ 1
[    3.592161] initcall jump_label_init_module+0x0/0x15 returned 0 after 0 usecs
[    3.593161] calling  init_zero_pfn+0x0/0xbf @ 1
[    3.594161] initcall init_zero_pfn+0x0/0xbf returned 0 after 0 usecs
[    3.595161] calling  init_fs_inode_sysctls+0x0/0x26 @ 1
[    3.596166] initcall init_fs_inode_sysctls+0x0/0x26 returned 0 after 0 usecs
[    3.597161] calling  init_fs_locks_sysctls+0x0/0x26 @ 1
[    3.598164] initcall init_fs_locks_sysctls+0x0/0x26 returned 0 after 0 usecs
[    3.599161] calling  dynamic_debug_init+0x0/0x3bd @ 1
[    3.600625] initcall dynamic_debug_init+0x0/0x3bd returned 0 after 0 usecs
[    3.601162] calling  efi_memreserve_root_init+0x0/0x2a @ 1
[    3.602161] initcall efi_memreserve_root_init+0x0/0x2a returned 0 after 0 usecs
[    3.603161] calling  efi_earlycon_remap_fb+0x0/0xf3 @ 1
[    3.604161] initcall efi_earlycon_remap_fb+0x0/0xf3 returned 0 after 0 usecs
[    3.605806] smp: Bringing up secondary CPUs ...
[    3.606431] x86: Booting SMP configuration:
[    3.607164] .... node  #0, CPUs:      #1
[    0.585467] masked ExtINT on CPU#1
[    3.616477]  #2
[    0.585467] masked ExtINT on CPU#2
[    3.623467]  #3
[    0.585467] masked ExtINT on CPU#3
[    3.630472]  #4
[    0.585467] masked ExtINT on CPU#4
[    3.637677] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    3.638503]  #5
[    0.585467] masked ExtINT on CPU#5
[    3.645475]  #6
[    0.585467] masked ExtINT on CPU#6
[    3.652474]  #7
[    0.585467] masked ExtINT on CPU#7
[    3.659621] smp: Brought up 1 node, 8 CPUs
[    3.660167] smpboot: Max logical packages: 1
[    3.661161] smpboot: Total of 8 processors activated (54274.68 BogoMIPS)
[    3.698264] node 0 deferred pages initialised in 35ms
[    3.705370] devtmpfs: initialized
[    3.709428] x86/mm: Memory block size: 128MB
[    3.725834] calling  bpf_jit_charge_init+0x0/0x40 @ 1
[    3.731164] initcall bpf_jit_charge_init+0x0/0x40 returned 0 after 0 usecs
[    3.739162] calling  ipc_ns_init+0x0/0x11e @ 1
[    3.744165] initcall ipc_ns_init+0x0/0x11e returned 0 after 0 usecs
[    3.751162] calling  init_mmap_min_addr+0x0/0x1a @ 1
[    3.756161] initcall init_mmap_min_addr+0x0/0x1a returned 0 after 0 usecs
[    3.764162] calling  pci_realloc_setup_params+0x0/0x49 @ 1
[    3.770163] initcall pci_realloc_setup_params+0x0/0x49 returned 0 after 0 usecs
[    3.778163] calling  inet_frag_wq_init+0x0/0x46 @ 1
[    3.783205] initcall inet_frag_wq_init+0x0/0x46 returned 0 after 0 usecs
[    3.791367] calling  e820__register_nvs_regions+0x0/0x150 @ 1
[    3.797165] ACPI: PM: Registering ACPI NVS region [mem 0xd1695000-0xd169bfff] (28672 bytes)
[    3.806173] ACPI: PM: Registering ACPI NVS region [mem 0xda71c000-0xda7fffff] (933888 bytes)
[    3.815455] initcall e820__register_nvs_regions+0x0/0x150 returned 0 after 19000 usecs
[    3.824162] calling  cpufreq_register_tsc_scaling+0x0/0x7a @ 1
[    3.831161] initcall cpufreq_register_tsc_scaling+0x0/0x7a returned 0 after 0 usecs
[    3.839162] calling  cache_ap_register+0x0/0x2c @ 1
[    3.844164] initcall cache_ap_register+0x0/0x2c returned 0 after 0 usecs
[    3.852164] calling  reboot_init+0x0/0xa9 @ 1
[    3.857165] initcall reboot_init+0x0/0xa9 returned 0 after 0 usecs
[    3.863161] calling  init_lapic_sysfs+0x0/0x4b @ 1
[    3.869161] initcall init_lapic_sysfs+0x0/0x4b returned 0 after 0 usecs
[    3.876161] calling  alloc_frozen_cpus+0x0/0x25 @ 1
[    3.882170] initcall alloc_frozen_cpus+0x0/0x25 returned 0 after 0 usecs
[    3.889162] calling  cpu_hotplug_pm_sync_init+0x0/0x18 @ 1
[    3.895162] initcall cpu_hotplug_pm_sync_init+0x0/0x18 returned 0 after 0 usecs
[    3.903161] calling  wq_sysfs_init+0x0/0x2f @ 1
[    3.908242] initcall wq_sysfs_init+0x0/0x2f returned 0 after 0 usecs
[    3.915162] calling  ksysfs_init+0x0/0x9d @ 1
[    3.920195] initcall ksysfs_init+0x0/0x9d returned 0 after 0 usecs
[    3.927164] calling  schedutil_gov_init+0x0/0x15 @ 1
[    3.933162] initcall schedutil_gov_init+0x0/0x15 returned 0 after 0 usecs
[    3.940162] calling  pm_init+0x0/0xb4 @ 1
[    3.945234] initcall pm_init+0x0/0xb4 returned 0 after 0 usecs
[    3.951162] calling  pm_disk_init+0x0/0x42 @ 1
[    3.956182] initcall pm_disk_init+0x0/0x42 returned 0 after 0 usecs
[    3.963161] calling  swsusp_header_init+0x0/0x35 @ 1
[    3.969161] initcall swsusp_header_init+0x0/0x35 returned 0 after 0 usecs
[    3.976161] calling  rcu_set_runtime_mode+0x0/0x4f @ 1
[    3.982163] initcall rcu_set_runtime_mode+0x0/0x4f returned 0 after 0 usecs
[    3.989162] calling  init_jiffies_clocksource+0x0/0x1c @ 1
[    3.996161] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    4.006164] initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 10000 usecs
[    4.014163] calling  futex_init+0x0/0x20a @ 1
[    4.019164] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    4.027180] initcall futex_init+0x0/0x20a returned 0 after 8000 usecs
[    4.034161] calling  cgroup_wq_init+0x0/0x2d @ 1
[    4.039171] initcall cgroup_wq_init+0x0/0x2d returned 0 after 0 usecs
[    4.046161] calling  cgroup1_wq_init+0x0/0x2d @ 1
[    4.051165] initcall cgroup1_wq_init+0x0/0x2d returned 0 after 0 usecs
[    4.059163] calling  ftrace_mod_cmd_init+0x0/0x10 @ 1
[    4.064162] initcall ftrace_mod_cmd_init+0x0/0x10 returned 0 after 0 usecs
[    4.072161] calling  init_wakeup_tracer+0x0/0x31 @ 1
[    4.077174] initcall init_wakeup_tracer+0x0/0x31 returned 0 after 0 usecs
[    4.085162] calling  init_graph_trace+0x0/0x95 @ 1
[    4.090164] initcall init_graph_trace+0x0/0x95 returned 0 after 0 usecs
[    4.097161] calling  trace_events_eprobe_init_early+0x0/0x2b @ 1
[    4.104161] initcall trace_events_eprobe_init_early+0x0/0x2b returned 0 after 0 usecs
[    4.112163] calling  trace_events_synth_init_early+0x0/0x2b @ 1
[    4.119163] initcall trace_events_synth_init_early+0x0/0x2b returned 0 after 0 usecs
[    4.127163] calling  init_kprobe_trace_early+0x0/0x2a @ 1
[    4.133161] initcall init_kprobe_trace_early+0x0/0x2a returned 0 after 0 usecs
[    4.141161] calling  kasan_memhotplug_init+0x0/0x13 @ 1
[    4.147161] initcall kasan_memhotplug_init+0x0/0x13 returned 0 after 0 usecs
[    4.155163] calling  memory_failure_init+0x0/0x257 @ 1
[    4.160161] initcall memory_failure_init+0x0/0x257 returned 0 after 0 usecs
[    4.168161] calling  fsnotify_init+0x0/0x7d @ 1
[    4.173185] initcall fsnotify_init+0x0/0x7d returned 0 after 0 usecs
[    4.180163] calling  filelock_init+0x0/0x17b @ 1
[    4.185184] initcall filelock_init+0x0/0x17b returned 0 after 0 usecs
[    4.193163] calling  init_script_binfmt+0x0/0x1a @ 1
[    4.198161] initcall init_script_binfmt+0x0/0x1a returned 0 after 0 usecs
[    4.205161] calling  init_elf_binfmt+0x0/0x1a @ 1
[    4.211161] initcall init_elf_binfmt+0x0/0x1a returned 0 after 0 usecs
[    4.218162] calling  init_compat_elf_binfmt+0x0/0x1a @ 1
[    4.224161] initcall init_compat_elf_binfmt+0x0/0x1a returned 0 after 0 usecs
[    4.232161] calling  configfs_init+0x0/0xee @ 1
[    4.237174] initcall configfs_init+0x0/0xee returned 0 after 0 usecs
[    4.244161] calling  debugfs_init+0x0/0xb7 @ 1
[    4.249167] initcall debugfs_init+0x0/0xb7 returned 0 after 0 usecs
[    4.256161] calling  tracefs_init+0x0/0x67 @ 1
[    4.261163] initcall tracefs_init+0x0/0x67 returned 0 after 0 usecs
[    4.268162] calling  securityfs_init+0x0/0xbe @ 1
[    4.273225] initcall securityfs_init+0x0/0xbe returned 0 after 0 usecs
[    4.280162] calling  pinctrl_init+0x0/0xb2 @ 1
[    4.285161] pinctrl core: initialized pinctrl subsystem
[    4.291225] initcall pinctrl_init+0x0/0xb2 returned 0 after 6000 usecs
[    4.298162] calling  gpiolib_dev_init+0x0/0x124 @ 1
[    4.304221] initcall gpiolib_dev_init+0x0/0x124 returned 0 after 0 usecs
[    4.311162] calling  virtio_init+0x0/0x20 @ 1
[    4.316189] initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
[    4.323163] calling  iommu_init+0x0/0x55 @ 1
[    4.328166] initcall iommu_init+0x0/0x55 returned 0 after 0 usecs
[    4.335163] calling  component_debug_init+0x0/0x21 @ 1
[    4.340173] initcall component_debug_init+0x0/0x21 returned 0 after 1000 usecs
[    4.348163] calling  cpufreq_core_init+0x0/0xce @ 1
[    4.354167] initcall cpufreq_core_init+0x0/0xce returned 0 after 0 usecs
[    4.361162] calling  cpufreq_gov_performance_init+0x0/0x15 @ 1
[    4.368161] initcall cpufreq_gov_performance_init+0x0/0x15 returned 0 after 0 usecs
[    4.376161] calling  cpufreq_gov_powersave_init+0x0/0x15 @ 1
[    4.382161] initcall cpufreq_gov_powersave_init+0x0/0x15 returned 0 after 0 usecs
[    4.390161] calling  cpufreq_gov_userspace_init+0x0/0x15 @ 1
[    4.396161] initcall cpufreq_gov_userspace_init+0x0/0x15 returned 0 after 0 usecs
[    4.405163] calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x15 @ 1
[    4.411163] initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x15 returned 0 after 0 usecs
[    4.419163] calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x15 @ 1
[    4.426161] initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x15 returned 0 after 0 usecs
[    4.434162] calling  cpuidle_init+0x0/0x4a @ 1
[    4.439179] initcall cpuidle_init+0x0/0x4a returned 0 after 0 usecs
[    4.446161] calling  sock_init+0x0/0xa3 @ 1
[    4.451777] initcall sock_init+0x0/0xa3 returned 0 after 0 usecs
[    4.458163] calling  net_inuse_init+0x0/0x2d @ 1
[    4.463163] initcall net_inuse_init+0x0/0x2d returned 0 after 0 usecs
[    4.470161] calling  net_defaults_init+0x0/0x2d @ 1
[    4.476163] initcall net_defaults_init+0x0/0x2d returned 0 after 0 usecs
[    4.483162] calling  init_default_flow_dissectors+0x0/0x54 @ 1
[    4.490161] initcall init_default_flow_dissectors+0x0/0x54 returned 0 after 0 usecs
[    4.498161] calling  netpoll_init+0x0/0x2d @ 1
[    4.503161] initcall netpoll_init+0x0/0x2d returned 0 after 0 usecs
[    4.510161] calling  netlink_proto_init+0x0/0x296 @ 1
[    4.516207] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    4.522234] initcall netlink_proto_init+0x0/0x296 returned 0 after 7000 usecs
[    4.530162] calling  genl_init+0x0/0x47 @ 1
[    4.535178] initcall genl_init+0x0/0x47 returned 0 after 0 usecs
[    4.541162] calling  bsp_pm_check_init+0x0/0x18 @ 1
[    4.547163] initcall bsp_pm_check_init+0x0/0x18 returned 0 after 0 usecs
[    4.554365] calling  irq_sysfs_init+0x0/0xbc @ 1
[    4.560456] initcall irq_sysfs_init+0x0/0xbc returned 0 after 0 usecs
[    4.567162] calling  audit_init+0x0/0x1cd @ 1
[    4.572177] audit: initializing netlink subsys (disabled)
[    4.578196] audit: type=2000 audit(1674306564.095:1): state=initialized audit_enabled=0 res=1
[    4.578196] initcall audit_init+0x0/0x1cd returned 0 after 6000 usecs
[    4.594164] calling  release_early_probes+0x0/0x5d @ 1
[    4.600161] initcall release_early_probes+0x0/0x5d returned 0 after 0 usecs
[    4.608161] calling  bdi_class_init+0x0/0x71 @ 1
[    4.613191] initcall bdi_class_init+0x0/0x71 returned 0 after 0 usecs
[    4.620163] calling  mm_sysfs_init+0x0/0x53 @ 1
[    4.625170] initcall mm_sysfs_init+0x0/0x53 returned 0 after 0 usecs
[    4.632163] calling  init_per_zone_wmark_min+0x0/0x2a @ 1
[    4.638168] initcall init_per_zone_wmark_min+0x0/0x2a returned 0 after 0 usecs
[    4.646162] calling  mpi_init+0x0/0xea @ 1
[    4.651180] initcall mpi_init+0x0/0xea returned 0 after 0 usecs
[    4.657162] calling  acpi_gpio_setup_params+0x0/0x11a @ 1
[    4.663162] initcall acpi_gpio_setup_params+0x0/0x11a returned 0 after 0 usecs
[    4.671161] calling  pcibus_class_init+0x0/0x1c @ 1
[    4.677179] initcall pcibus_class_init+0x0/0x1c returned 0 after 0 usecs
[    4.684164] calling  pci_driver_init+0x0/0x26 @ 1
[    4.689229] initcall pci_driver_init+0x0/0x26 returned 0 after 0 usecs
[    4.697163] calling  backlight_class_init+0x0/0xf2 @ 1
[    4.702179] initcall backlight_class_init+0x0/0xf2 returned 0 after 0 usecs
[    4.710162] calling  tty_class_init+0x0/0x5c @ 1
[    4.715177] initcall tty_class_init+0x0/0x5c returned 0 after 0 usecs
[    4.722161] calling  vtconsole_class_init+0x0/0x1a4 @ 1
[    4.728239] initcall vtconsole_class_init+0x0/0x1a4 returned 0 after 0 usecs
[    4.736162] calling  iommu_dev_init+0x0/0x1c @ 1
[    4.741175] initcall iommu_dev_init+0x0/0x1c returned 0 after 0 usecs
[    4.748162] calling  mipi_dsi_bus_init+0x0/0x15 @ 1
[    4.754193] initcall mipi_dsi_bus_init+0x0/0x15 returned 0 after 0 usecs
[    4.761163] calling  devlink_class_init+0x0/0x4a @ 1
[    4.767175] initcall devlink_class_init+0x0/0x4a returned 0 after 0 usecs
[    4.774162] calling  software_node_init+0x0/0x55 @ 1
[    4.780166] initcall software_node_init+0x0/0x55 returned 0 after 0 usecs
[    4.787163] calling  wakeup_sources_debugfs_init+0x0/0x28 @ 1
[    4.793177] initcall wakeup_sources_debugfs_init+0x0/0x28 returned 0 after 0 usecs
[    4.802163] calling  wakeup_sources_sysfs_init+0x0/0x31 @ 1
[    4.808175] initcall wakeup_sources_sysfs_init+0x0/0x31 returned 0 after 0 usecs
[    4.816163] calling  regmap_initcall+0x0/0x11 @ 1
[    4.821168] initcall regmap_initcall+0x0/0x11 returned 0 after 0 usecs
[    4.828162] calling  spi_init+0x0/0xcb @ 1
[    4.833215] initcall spi_init+0x0/0xcb returned 0 after 0 usecs
[    4.840161] calling  i2c_init+0x0/0xec @ 1
[    4.844217] initcall i2c_init+0x0/0xec returned 0 after 0 usecs
[    4.851162] calling  thermal_init+0x0/0x196 @ 1
[    4.856161] thermal_sys: Registered thermal governor 'fair_share'
[    4.856163] thermal_sys: Registered thermal governor 'bang_bang'
[    4.863161] thermal_sys: Registered thermal governor 'step_wise'
[    4.869162] thermal_sys: Registered thermal governor 'user_space'
[    4.876188] initcall thermal_init+0x0/0x196 returned 0 after 20000 usecs
[    4.890162] calling  init_menu+0x0/0x15 @ 1
[    4.895203] cpuidle: using governor menu
[    4.896162] initcall init_menu+0x0/0x15 returned 0 after 1000 usecs
[    4.897161] calling  pcc_init+0x0/0xcb @ 1
[    4.898165] initcall pcc_init+0x0/0xcb returned -19 after 0 usecs
[    4.904163] calling  amd_postcore_init+0x0/0x22e @ 1
[    4.910161] initcall amd_postcore_init+0x0/0x22e returned 0 after 0 usecs
[    4.917161] calling  kobject_uevent_init+0x0/0x10 @ 1
[    4.923173] initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
[    4.930366] calling  bts_init+0x0/0x134 @ 1
[    4.935161] initcall bts_init+0x0/0x134 returned -19 after 0 usecs
[    4.942161] calling  pt_init+0x0/0x2c1 @ 1
[    4.947161] initcall pt_init+0x0/0x2c1 returned -19 after 0 usecs
[    4.954161] calling  boot_params_ksysfs_init+0x0/0x96 @ 1
[    4.960173] initcall boot_params_ksysfs_init+0x0/0x96 returned 0 after 0 usecs
[    4.967162] calling  sbf_init+0x0/0xd3 @ 1
[    4.972161] initcall sbf_init+0x0/0xd3 returned 0 after 0 usecs
[    4.979161] calling  arch_kdebugfs_init+0x0/0x4d9 @ 1
[    4.984188] initcall arch_kdebugfs_init+0x0/0x4d9 returned 0 after 0 usecs
[    4.992163] calling  xfd_update_static_branch+0x0/0x48 @ 1
[    4.998161] initcall xfd_update_static_branch+0x0/0x48 returned 0 after 0 usecs
[    5.006161] calling  intel_pconfig_init+0x0/0xa9 @ 1
[    5.012161] initcall intel_pconfig_init+0x0/0xa9 returned 0 after 0 usecs
[    5.019161] calling  mtrr_if_init+0x0/0xaf @ 1
[    5.024167] initcall mtrr_if_init+0x0/0xaf returned 0 after 0 usecs
[    5.031163] calling  activate_jump_labels+0x0/0x36 @ 1
[    5.037161] initcall activate_jump_labels+0x0/0x36 returned 0 after 0 usecs
[    5.044161] calling  init_s4_sigcheck+0x0/0x90 @ 1
[    5.050162] initcall init_s4_sigcheck+0x0/0x90 returned 0 after 0 usecs
[    5.057162] calling  ffh_cstate_init+0x0/0x66 @ 1
[    5.062162] initcall ffh_cstate_init+0x0/0x66 returned 0 after 0 usecs
[    5.069161] calling  kvm_alloc_cpumask+0x0/0x1ca @ 1
[    5.075161] initcall kvm_alloc_cpumask+0x0/0x1ca returned 0 after 0 usecs
[    5.082161] calling  activate_jump_labels+0x0/0x36 @ 1
[    5.088162] initcall activate_jump_labels+0x0/0x36 returned 0 after 0 usecs
[    5.096161] calling  gigantic_pages_init+0x0/0x4a @ 1
[    5.101163] initcall gigantic_pages_init+0x0/0x4a returned 0 after 0 usecs
[    5.109161] calling  uv_rtc_setup_clock+0x0/0x27a @ 1
[    5.115161] initcall uv_rtc_setup_clock+0x0/0x27a returned -19 after 0 usecs
[    5.122161] calling  kcmp_cookies_init+0x0/0xa6 @ 1
[    5.128162] initcall kcmp_cookies_init+0x0/0xa6 returned 0 after 0 usecs
[    5.135161] calling  cryptomgr_init+0x0/0x15 @ 1
[    5.140163] initcall cryptomgr_init+0x0/0x15 returned 0 after 0 usecs
[    5.147162] calling  acpi_pci_init+0x0/0x14d @ 1
[    5.153161] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    5.160161] initcall acpi_pci_init+0x0/0x14d returned 0 after 7000 usecs
[    5.167161] calling  dma_channel_table_init+0x0/0x17c @ 1
[    5.173171] initcall dma_channel_table_init+0x0/0x17c returned 0 after 0 usecs
[    5.181161] calling  dma_bus_init+0x0/0x20f @ 1
[    5.186253] initcall dma_bus_init+0x0/0x20f returned 0 after 0 usecs
[    5.193162] calling  iommu_dma_init+0x0/0x50 @ 1
[    5.198170] initcall iommu_dma_init+0x0/0x50 returned 0 after 0 usecs
[    5.205163] calling  dmi_id_init+0x0/0x16c @ 1
[    5.210339] initcall dmi_id_init+0x0/0x16c returned 0 after 1000 usecs
[    5.218164] calling  pci_arch_init+0x0/0x11c @ 1
[    5.223177] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    5.233164] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    5.241530] pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
[    5.253224] PCI: Using configuration type 1 for base access
[    5.259186] initcall pci_arch_init+0x0/0x11c returned 0 after 36000 usecs
[    5.266364] calling  init_vdso+0x0/0x18 @ 1
[    5.271171] initcall init_vdso+0x0/0x18 returned 0 after 0 usecs
[    5.278161] calling  sysenter_setup+0x0/0x18 @ 1
[    5.283171] initcall sysenter_setup+0x0/0x18 returned 0 after 0 usecs
[    5.290161] calling  fixup_ht_bug+0x0/0x257 @ 1
[    5.295161] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    5.303161] initcall fixup_ht_bug+0x0/0x257 returned 0 after 8000 usecs
[    5.310161] calling  topology_init+0x0/0x9e @ 1
[    5.315786] initcall topology_init+0x0/0x9e returned 0 after 1000 usecs
[    5.323164] calling  intel_epb_init+0x0/0xd8 @ 1
[    5.328170] initcall intel_epb_init+0x0/0xd8 returned 0 after 0 usecs
[    5.335163] calling  mtrr_init_finialize+0x0/0x6f @ 1
[    5.341161] initcall mtrr_init_finialize+0x0/0x6f returned 0 after 0 usecs
[    5.349161] calling  uid_cache_init+0x0/0x103 @ 1
[    5.354174] initcall uid_cache_init+0x0/0x103 returned 0 after 0 usecs
[    5.361163] calling  param_sysfs_init+0x0/0x4f @ 1
[    5.366167] initcall param_sysfs_init+0x0/0x4f returned 0 after 1000 usecs
[    5.374162] calling  user_namespace_sysctl_init+0x0/0x11f @ 1
[    5.380189] initcall user_namespace_sysctl_init+0x0/0x11f returned 0 after 0 usecs
[    5.389163] calling  proc_schedstat_init+0x0/0x29 @ 1
[    5.394163] initcall proc_schedstat_init+0x0/0x29 returned 0 after 0 usecs
[    5.402163] calling  pm_sysrq_init+0x0/0x1d @ 1
[    5.407167] initcall pm_sysrq_init+0x0/0x1d returned 0 after 0 usecs
[    5.414161] calling  create_proc_profile+0x0/0xe0 @ 1
[    5.420161] initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
[    5.427161] calling  crash_save_vmcoreinfo_init+0x0/0x742 @ 1
[    5.433205] initcall crash_save_vmcoreinfo_init+0x0/0x742 returned 0 after 0 usecs
[    5.442162] calling  crash_notes_memory_init+0x0/0x3d @ 1
[    5.448163] initcall crash_notes_memory_init+0x0/0x3d returned 0 after 0 usecs
[    5.455163] calling  cgroup_sysfs_init+0x0/0x42 @ 1
[    5.461174] initcall cgroup_sysfs_init+0x0/0x42 returned 0 after 0 usecs
[    5.468163] calling  cgroup_namespaces_init+0x0/0xc @ 1
[    5.474161] initcall cgroup_namespaces_init+0x0/0xc returned 0 after 0 usecs
[    5.482161] calling  user_namespaces_init+0x0/0x31 @ 1
[    5.488180] initcall user_namespaces_init+0x0/0x31 returned 0 after 0 usecs
[    5.495163] calling  init_optprobes+0x0/0x1d @ 1
[    5.500163] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    5.510163] initcall init_optprobes+0x0/0x1d returned 0 after 10000 usecs
[    5.517161] calling  hung_task_init+0x0/0x79 @ 1
[    5.522192] initcall hung_task_init+0x0/0x79 returned 0 after 0 usecs
[    5.530163] calling  ftrace_check_for_weak_functions+0x0/0x66 @ 1
[    5.536193] initcall ftrace_check_for_weak_functions+0x0/0x66 returned 0 after 0 usecs
[    5.545162] calling  trace_eval_init+0x0/0x89 @ 1
[    5.550188] initcall trace_eval_init+0x0/0x89 returned 0 after 0 usecs
[    5.557161] calling  send_signal_irq_work_init+0x0/0x154 @ 1
[    5.564162] initcall send_signal_irq_work_init+0x0/0x154 returned 0 after 0 usecs
[    5.572162] calling  dev_map_init+0x0/0x123 @ 1
[    5.577162] initcall dev_map_init+0x0/0x123 returned 0 after 0 usecs
[    5.584163] calling  cpu_map_init+0x0/0x117 @ 1
[    5.589161] initcall cpu_map_init+0x0/0x117 returned 0 after 0 usecs
[    5.596161] calling  netns_bpf_init+0x0/0x15 @ 1
[    5.601163] initcall netns_bpf_init+0x0/0x15 returned 0 after 0 usecs
[    5.608163] calling  oom_init+0x0/0x4e @ 1
[    5.613192] initcall oom_init+0x0/0x4e returned 0 after 0 usecs
[    5.620163] calling  default_bdi_init+0x0/0x2d @ 1
[    5.625231] initcall default_bdi_init+0x0/0x2d returned 0 after 0 usecs
[    5.632163] calling  cgwb_init+0x0/0x2d @ 1
[    5.637167] initcall cgwb_init+0x0/0x2d returned 0 after 0 usecs
[    5.644162] calling  percpu_enable_async+0x0/0x13 @ 1
[    5.649161] initcall percpu_enable_async+0x0/0x13 returned 0 after 0 usecs
[    5.657161] calling  kcompactd_init+0x0/0x9c @ 1
[    5.662186] initcall kcompactd_init+0x0/0x9c returned 0 after 0 usecs
[    5.669162] calling  init_user_reserve+0x0/0xa0 @ 1
[    5.675161] initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
[    5.682161] calling  init_admin_reserve+0x0/0xa0 @ 1
[    5.688161] initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
[    5.695161] calling  init_reserve_notifier+0x0/0x23 @ 1
[    5.701163] initcall init_reserve_notifier+0x0/0x23 returned 0 after 0 usecs
[    5.709163] calling  swap_init_sysfs+0x0/0x92 @ 1
[    5.714171] initcall swap_init_sysfs+0x0/0x92 returned 0 after 0 usecs
[    5.721162] calling  swapfile_init+0x0/0x14b @ 1
[    5.726169] initcall swapfile_init+0x0/0x14b returned 0 after 0 usecs
[    5.733163] calling  hugetlb_init+0x0/0x40a @ 1
[    5.739167] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    5.746163] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    5.753162] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    5.761161] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    5.768284] initcall hugetlb_init+0x0/0x40a returned 0 after 29000 usecs
[    5.775163] calling  ksm_init+0x0/0x246 @ 1
[    5.780199] initcall ksm_init+0x0/0x246 returned 0 after 0 usecs
[    5.787162] calling  memory_tier_init+0x0/0x14d @ 1
[    5.792284] initcall memory_tier_init+0x0/0x14d returned 0 after 0 usecs
[    5.800163] calling  numa_init_sysfs+0x0/0x92 @ 1
[    5.805169] initcall numa_init_sysfs+0x0/0x92 returned 0 after 0 usecs
[    5.812162] calling  hugepage_init+0x0/0x1b4 @ 1
[    5.817220] initcall hugepage_init+0x0/0x1b4 returned 0 after 0 usecs
[    5.824163] calling  mem_cgroup_init+0x0/0x35d @ 1
[    5.830171] initcall mem_cgroup_init+0x0/0x35d returned 0 after 0 usecs
[    5.837162] calling  mem_cgroup_swap_init+0x0/0x60 @ 1
[    5.843163] initcall mem_cgroup_swap_init+0x0/0x60 returned 0 after 0 usecs
[    5.850163] calling  page_idle_init+0x0/0x5d @ 1
[    5.856168] initcall page_idle_init+0x0/0x5d returned 0 after 0 usecs
[    5.863161] calling  seqiv_module_init+0x0/0x15 @ 1
[    5.868161] initcall seqiv_module_init+0x0/0x15 returned 0 after 0 usecs
[    5.876163] calling  rsa_init+0x0/0x43 @ 1
[    5.880162] initcall rsa_init+0x0/0x43 returned 0 after 0 usecs
[    5.887161] calling  hmac_module_init+0x0/0x15 @ 1
[    5.892163] initcall hmac_module_init+0x0/0x15 returned 0 after 0 usecs
[    5.899163] calling  crypto_null_mod_init+0x0/0x71 @ 1
[    5.905163] initcall crypto_null_mod_init+0x0/0x71 returned 0 after 0 usecs
[    5.913161] calling  md5_mod_init+0x0/0x15 @ 1
[    5.918161] initcall md5_mod_init+0x0/0x15 returned 0 after 0 usecs
[    5.925161] calling  sha1_generic_mod_init+0x0/0x15 @ 1
[    5.931162] initcall sha1_generic_mod_init+0x0/0x15 returned 0 after 0 usecs
[    5.938162] calling  sha256_generic_mod_init+0x0/0x1a @ 1
[    5.944162] initcall sha256_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
[    5.952163] calling  sha512_generic_mod_init+0x0/0x1a @ 1
[    5.958163] initcall sha512_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
[    5.966163] calling  crypto_ecb_module_init+0x0/0x15 @ 1
[    5.972161] initcall crypto_ecb_module_init+0x0/0x15 returned 0 after 0 usecs
[    5.980161] calling  crypto_cbc_module_init+0x0/0x15 @ 1
[    5.986161] initcall crypto_cbc_module_init+0x0/0x15 returned 0 after 0 usecs
[    5.993163] calling  crypto_cfb_module_init+0x0/0x15 @ 1
[    5.999163] initcall crypto_cfb_module_init+0x0/0x15 returned 0 after 0 usecs
[    6.007163] calling  crypto_ctr_module_init+0x0/0x1a @ 1
[    6.013161] initcall crypto_ctr_module_init+0x0/0x1a returned 0 after 0 usecs
[    6.021161] calling  crypto_gcm_module_init+0x0/0x67 @ 1
[    6.027170] initcall crypto_gcm_module_init+0x0/0x67 returned 0 after 0 usecs
[    6.034161] calling  cryptd_init+0x0/0x1fb @ 1
[    6.039190] cryptd: max_cpu_qlen set to 1000
[    6.044162] initcall cryptd_init+0x0/0x1fb returned 0 after 5000 usecs
[    6.052162] calling  aes_init+0x0/0x15 @ 1
[    6.056161] initcall aes_init+0x0/0x15 returned 0 after 0 usecs
[    6.063162] calling  deflate_mod_init+0x0/0x48 @ 1
[    6.068163] initcall deflate_mod_init+0x0/0x48 returned 0 after 0 usecs
[    6.075163] calling  crc32c_mod_init+0x0/0x15 @ 1
[    6.081161] initcall crc32c_mod_init+0x0/0x15 returned 0 after 0 usecs
[    6.088161] calling  crct10dif_mod_init+0x0/0x15 @ 1
[    6.094161] initcall crct10dif_mod_init+0x0/0x15 returned 0 after 0 usecs
[    6.101162] calling  lzo_mod_init+0x0/0x43 @ 1
[    6.106162] initcall lzo_mod_init+0x0/0x43 returned 0 after 0 usecs
[    6.113163] calling  lzorle_mod_init+0x0/0x43 @ 1
[    6.118162] initcall lzorle_mod_init+0x0/0x43 returned 0 after 0 usecs
[    6.125161] calling  drbg_init+0x0/0xe8 @ 1
[    6.130187] initcall drbg_init+0x0/0xe8 returned 0 after 0 usecs
[    6.137161] calling  ghash_mod_init+0x0/0x15 @ 1
[    6.142161] initcall ghash_mod_init+0x0/0x15 returned 0 after 0 usecs
[    6.149161] calling  init_bio+0x0/0x115 @ 1
[    6.154245] initcall init_bio+0x0/0x115 returned 0 after 0 usecs
[    6.161163] calling  blk_ioc_init+0x0/0x2e @ 1
[    6.166169] initcall blk_ioc_init+0x0/0x2e returned 0 after 0 usecs
[    6.173163] calling  blk_mq_init+0x0/0x17b @ 1
[    6.178163] initcall blk_mq_init+0x0/0x17b returned 0 after 0 usecs
[    6.185163] calling  genhd_device_init+0x0/0x8c @ 1
[    6.190202] initcall genhd_device_init+0x0/0x8c returned 0 after 0 usecs
[    6.198163] calling  blkcg_init+0x0/0x2d @ 1
[    6.203231] initcall blkcg_init+0x0/0x2d returned 0 after 0 usecs
[    6.209163] calling  io_wq_init+0x0/0x3d @ 1
[    6.214163] initcall io_wq_init+0x0/0x3d returned 0 after 0 usecs
[    6.221163] calling  sg_pool_init+0x0/0x1a9 @ 1
[    6.226235] initcall sg_pool_init+0x0/0x1a9 returned 0 after 0 usecs
[    6.233161] calling  irq_poll_setup+0x0/0x149 @ 1
[    6.239161] initcall irq_poll_setup+0x0/0x149 returned 0 after 0 usecs
[    6.246161] calling  gpiolib_debugfs_init+0x0/0x28 @ 1
[    6.251172] initcall gpiolib_debugfs_init+0x0/0x28 returned 0 after 0 usecs
[    6.259162] calling  pwm_debugfs_init+0x0/0x28 @ 1
[    6.264166] initcall pwm_debugfs_init+0x0/0x28 returned 0 after 0 usecs
[    6.272161] calling  pwm_sysfs_init+0x0/0x1c @ 1
[    6.277176] initcall pwm_sysfs_init+0x0/0x1c returned 0 after 0 usecs
[    6.284162] calling  pci_slot_init+0x0/0x40 @ 1
[    6.289167] initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
[    6.296163] calling  fbmem_init+0x0/0xe5 @ 1
[    6.301250] initcall fbmem_init+0x0/0xe5 returned 0 after 0 usecs
[    6.308162] calling  scan_for_dmi_ipmi+0x0/0x56 @ 1
[    6.313161] initcall scan_for_dmi_ipmi+0x0/0x56 returned 0 after 0 usecs
[    6.321163] calling  acpi_init+0x0/0x271 @ 1
[    6.326223] ACPI: Added _OSI(Module Device)
[    6.330163] ACPI: Added _OSI(Processor Device)
[    6.336161] ACPI: Added _OSI(3.0 _SCP Extensions)
[    6.341161] ACPI: Added _OSI(Processor Aggregator Device)
[    6.469438] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    6.483878] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    6.499341] ACPI: Dynamic OEM Table Load:
[    6.504168] ACPI: SSDT 0xFFFF888101118000 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
[    6.519266] ACPI: Dynamic OEM Table Load:
[    6.524169] ACPI: SSDT 0xFFFF88810167B000 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
[    6.543919] ACPI: Dynamic OEM Table Load:
[    6.549168] ACPI: SSDT 0xFFFF888100FAE800 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
[    6.585452] ACPI: Interpreter enabled
[    6.589257] ACPI: PM: (supports S0 S3 S4 S5)
[    6.594164] ACPI: Using IOAPIC for interrupt routing
[    6.600292] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    6.610165] PCI: Using E820 reservations for host bridge windows
[    6.618313] ACPI: Enabled 9 GPEs in block 00 to 3F
[    6.789478] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    6.796207] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    6.814075] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    6.832321] PCI host bridge to bus 0000:00
[    6.837167] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    6.844165] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    6.851164] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    6.859166] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000e7fff window]
[    6.868171] pci_bus 0000:00: root bus resource [mem 0xdf200000-0xfeafffff window]
[    6.876168] pci_bus 0000:00: root bus resource [bus 00-3e]
[    6.882234] pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
[    6.889162] pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
[    6.896163] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
[    6.903208] pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    6.911162] pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    6.919360] pci 0000:00:02.0: [8086:0412] type 00 class 0x030000
[    6.926169] pci 0000:00:02.0: reg 0x10: [mem 0xf7800000-0xf7bfffff 64bit]
[    6.933165] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    6.941164] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    6.947193] pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x490 @ 1
[    6.955164] pci 0000:00:02.0: efifb_fixup_resources+0x0/0x490 took 0 usecs
[    6.962162] pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    6.970162] pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    6.978162] pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x200 @ 1
[    6.985163] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    6.994162] pci 0000:00:02.0: pci_fixup_video+0x0/0x200 took 8789 usecs
[    7.001931] pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
[    7.009170] pci 0000:00:03.0: reg 0x10: [mem 0xf7d34000-0xf7d37fff 64bit]
[    7.016195] pci 0000:00:03.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.024164] pci 0000:00:03.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.032898] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
[    7.039180] pci 0000:00:14.0: reg 0x10: [mem 0xf7d20000-0xf7d2ffff 64bit]
[    7.047226] pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.055162] pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.062185] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    7.069758] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
[    7.076178] pci 0000:00:16.0: reg 0x10: [mem 0xf7d40000-0xf7d4000f 64bit]
[    7.084233] pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.092162] pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.100184] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    7.106406] pci 0000:00:19.0: calling  quirk_f0_vpd_link+0x0/0x220 @ 1
[    7.114163] pci 0000:00:19.0: quirk_f0_vpd_link+0x0/0x220 took 0 usecs
[    7.121162] pci 0000:00:19.0: [8086:153a] type 00 class 0x020000
[    7.128172] pci 0000:00:19.0: reg 0x10: [mem 0xf7d00000-0xf7d1ffff]
[    7.134169] pci 0000:00:19.0: reg 0x14: [mem 0xf7d3d000-0xf7d3dfff]
[    7.141167] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
[    7.148194] pci 0000:00:19.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.156164] pci 0000:00:19.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.163185] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    7.170906] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
[    7.178177] pci 0000:00:1a.0: reg 0x10: [mem 0xf7d3c000-0xf7d3c3ff]
[    7.184205] pci 0000:00:1a.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.192164] pci 0000:00:1a.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.200191] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    7.207913] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
[    7.214177] pci 0000:00:1b.0: reg 0x10: [mem 0xf7d30000-0xf7d33fff 64bit]
[    7.222225] pci 0000:00:1b.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.230165] pci 0000:00:1b.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.238185] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    7.245945] pci 0000:00:1c.0: calling  quirk_cmd_compl+0x0/0x110 @ 1
[    7.252163] pci 0000:00:1c.0: quirk_cmd_compl+0x0/0x110 took 0 usecs
[    7.259162] pci 0000:00:1c.0: calling  quirk_no_aersid+0x0/0x110 @ 1
[    7.266161] pci 0000:00:1c.0: quirk_no_aersid+0x0/0x110 took 0 usecs
[    7.273163] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    7.280199] pci 0000:00:1c.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.288164] pci 0000:00:1c.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.296162] pci 0000:00:1c.0: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    7.304162] pci 0000:00:1c.0: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    7.312163] pci 0000:00:1c.0: calling  quirk_apple_mbp_poweroff+0x0/0x120 @ 1
[    7.319162] pci 0000:00:1c.0: quirk_apple_mbp_poweroff+0x0/0x120 took 0 usecs
[    7.327183] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    7.340481] pci 0000:00:1c.1: calling  quirk_cmd_compl+0x0/0x110 @ 1
[    7.347165] pci 0000:00:1c.1: quirk_cmd_compl+0x0/0x110 took 0 usecs
[    7.354162] pci 0000:00:1c.1: calling  quirk_no_aersid+0x0/0x110 @ 1
[    7.361161] pci 0000:00:1c.1: quirk_no_aersid+0x0/0x110 took 0 usecs
[    7.368161] pci 0000:00:1c.1: [8086:8c12] type 01 class 0x060400
[    7.375228] pci 0000:00:1c.1: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.383162] pci 0000:00:1c.1: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.391163] pci 0000:00:1c.1: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    7.399162] pci 0000:00:1c.1: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    7.407182] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    7.419461] pci 0000:00:1c.2: calling  quirk_cmd_compl+0x0/0x110 @ 1
[    7.427165] pci 0000:00:1c.2: quirk_cmd_compl+0x0/0x110 took 0 usecs
[    7.434161] pci 0000:00:1c.2: calling  quirk_no_aersid+0x0/0x110 @ 1
[    7.441161] pci 0000:00:1c.2: quirk_no_aersid+0x0/0x110 took 0 usecs
[    7.447161] pci 0000:00:1c.2: [8086:8c14] type 01 class 0x060400
[    7.454228] pci 0000:00:1c.2: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.462162] pci 0000:00:1c.2: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.470163] pci 0000:00:1c.2: calling  pci_fixup_transparent_bridge+0x0/0xc0 @ 1
[    7.478162] pci 0000:00:1c.2: pci_fixup_transparent_bridge+0x0/0xc0 took 0 usecs
[    7.486179] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    7.498753] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
[    7.506176] pci 0000:00:1d.0: reg 0x10: [mem 0xf7d3b000-0xf7d3b3ff]
[    7.513234] pci 0000:00:1d.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.521162] pci 0000:00:1d.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.528192] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    7.536210] pci 0000:00:1f.0: [8086:8c4e] type 00 class 0x060100
[    7.543260] pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.551162] pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.558892] pci 0000:00:1f.2: [8086:8c02] type 00 class 0x010601
[    7.566172] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    7.572167] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    7.578166] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    7.584166] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    7.591166] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    7.597168] pci 0000:00:1f.2: reg 0x24: [mem 0xf7d3a000-0xf7d3a7ff]
[    7.604203] pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.612164] pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.620184] pci 0000:00:1f.2: PME# supported from D3hot
[    7.625891] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
[    7.633178] pci 0000:00:1f.3: reg 0x10: [mem 0xf7d39000-0xf7d390ff 64bit]
[    7.640178] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    7.646192] pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.654164] pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.663298] acpiphp: Slot [1] registered
[    7.668167] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    7.674567] pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
[    7.681372] pci 0000:02:00.0: supports D1 D2
[    7.687037] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    7.692225] pci_bus 0000:03: extended config space not accessible
[    7.699337] pci 0000:02:00.0: PCI bridge to [bus 03]
[    7.705623] pci 0000:04:00.0: calling  quirk_f0_vpd_link+0x0/0x220 @ 1
[    7.713165] pci 0000:04:00.0: quirk_f0_vpd_link+0x0/0x220 took 0 usecs
[    7.720163] pci 0000:04:00.0: [8086:10d3] type 00 class 0x020000
[    7.726196] pci 0000:04:00.0: reg 0x10: [mem 0xf7cc0000-0xf7cdffff]
[    7.733180] pci 0000:04:00.0: reg 0x14: [mem 0xf7c00000-0xf7c7ffff]
[    7.740180] pci 0000:04:00.0: reg 0x18: [io  0xe000-0xe01f]
[    7.746180] pci 0000:04:00.0: reg 0x1c: [mem 0xf7ce0000-0xf7ce3fff]
[    7.753216] pci 0000:04:00.0: reg 0x30: [mem 0xf7c80000-0xf7cbffff pref]
[    7.761223] pci 0000:04:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
[    7.769164] pci 0000:04:00.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
[    7.777275] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    7.784099] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    7.790166] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    7.797164] pci 0000:00:1c.2:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    7.815569] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    7.822163] ACPI: PCI: Interrupt link LNKA disabled
[    7.828064] ACPI: PCI: Interrupt link LNKB configured for IRQ 11
[    7.835164] ACPI: PCI: Interrupt link LNKB disabled
[    7.841680] ACPI: PCI: Interrupt link LNKC configured for IRQ 10
[    7.848164] ACPI: PCI: Interrupt link LNKC disabled
[    7.854067] ACPI: PCI: Interrupt link LNKD configured for IRQ 10
[    7.861162] ACPI: PCI: Interrupt link LNKD disabled
[    7.867060] ACPI: PCI: Interrupt link LNKE configured for IRQ 5
[    7.874162] ACPI: PCI: Interrupt link LNKE disabled
[    7.880056] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    7.887162] ACPI: PCI: Interrupt link LNKF disabled
[    7.893057] ACPI: PCI: Interrupt link LNKG configured for IRQ 3
[    7.900162] ACPI: PCI: Interrupt link LNKG disabled
[    7.906051] ACPI: PCI: Interrupt link LNKH configured for IRQ 5
[    7.913163] ACPI: PCI: Interrupt link LNKH disabled
[    7.920540] initcall acpi_init+0x0/0x271 returned 0 after 1595000 usecs
[    7.928165] calling  adxl_init+0x0/0x250 @ 1
[    7.933167] initcall adxl_init+0x0/0x250 returned -19 after 0 usecs
[    7.940161] calling  pnp_init+0x0/0x15 @ 1
[    7.944189] initcall pnp_init+0x0/0x15 returned 0 after 0 usecs
[    7.951161] calling  misc_init+0x0/0xe8 @ 1
[    7.956189] initcall misc_init+0x0/0xe8 returned 0 after 0 usecs
[    7.962161] calling  tpm_init+0x0/0x21c @ 1
[    7.967230] initcall tpm_init+0x0/0x21c returned 0 after 0 usecs
[    7.974164] calling  iommu_subsys_init+0x0/0x1a9 @ 1
[    7.980161] iommu: Default domain type: Translated 
[    7.985161] iommu: DMA domain TLB invalidation policy: lazy mode 
[    7.992163] initcall iommu_subsys_init+0x0/0x1a9 returned 0 after 12000 usecs
[    7.999163] calling  cn_init+0x0/0x180 @ 1
[    8.004183] initcall cn_init+0x0/0x180 returned 0 after 0 usecs
[    8.011161] calling  dax_core_init+0x0/0xe7 @ 1
[    8.016268] initcall dax_core_init+0x0/0xe7 returned 0 after 0 usecs
[    8.023164] calling  dma_buf_init+0x0/0xcb @ 1
[    8.028208] initcall dma_buf_init+0x0/0xcb returned 0 after 0 usecs
[    8.035163] calling  init_scsi+0x0/0x8c @ 1
[    8.040539] SCSI subsystem initialized
[    8.045163] initcall init_scsi+0x0/0x8c returned 0 after 5000 usecs
[    8.051161] calling  phy_init+0x0/0x69 @ 1
[    8.056253] initcall phy_init+0x0/0x69 returned 0 after 0 usecs
[    8.063162] calling  usb_common_init+0x0/0x21 @ 1
[    8.068169] initcall usb_common_init+0x0/0x21 returned 0 after 0 usecs
[    8.075161] calling  usb_init+0x0/0x154 @ 1
[    8.080167] ACPI: bus type USB registered
[    8.085227] usbcore: registered new interface driver usbfs
[    8.091196] usbcore: registered new interface driver hub
[    8.097191] usbcore: registered new device driver usb
[    8.103163] initcall usb_init+0x0/0x154 returned 0 after 23000 usecs
[    8.110161] calling  xdbc_init+0x0/0x155 @ 1
[    8.115162] initcall xdbc_init+0x0/0x155 returned 0 after 0 usecs
[    8.121161] calling  typec_init+0x0/0xb2 @ 1
[    8.126252] initcall typec_init+0x0/0xb2 returned 0 after 0 usecs
[    8.133163] calling  serio_init+0x0/0x32 @ 1
[    8.138191] initcall serio_init+0x0/0x32 returned 0 after 0 usecs
[    8.145162] calling  input_init+0x0/0x108 @ 1
[    8.150184] initcall input_init+0x0/0x108 returned 0 after 0 usecs
[    8.156163] calling  rtc_init+0x0/0x75 @ 1
[    8.161179] initcall rtc_init+0x0/0x75 returned 0 after 0 usecs
[    8.168162] calling  pps_init+0x0/0xda @ 1
[    8.172179] pps_core: LinuxPPS API ver. 1 registered
[    8.178163] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    8.188165] initcall pps_init+0x0/0xda returned 0 after 16000 usecs
[    8.195161] calling  ptp_init+0x0/0xc4 @ 1
[    8.199182] PTP clock support registered
[    8.204163] initcall ptp_init+0x0/0xc4 returned 0 after 5000 usecs
[    8.211161] calling  power_supply_class_init+0x0/0x68 @ 1
[    8.217181] initcall power_supply_class_init+0x0/0x68 returned 0 after 0 usecs
[    8.225162] calling  hwmon_init+0x0/0x17c @ 1
[    8.230184] initcall hwmon_init+0x0/0x17c returned 0 after 0 usecs
[    8.236161] calling  md_init+0x0/0x160 @ 1
[    8.241194] initcall md_init+0x0/0x160 returned 0 after 0 usecs
[    8.248163] calling  edac_init+0x0/0x7a @ 1
[    8.253161] EDAC MC: Ver: 3.0.0
[    8.257188] initcall edac_init+0x0/0x7a returned 0 after 4000 usecs
[    8.263163] calling  leds_init+0x0/0x83 @ 1
[    8.268177] initcall leds_init+0x0/0x83 returned 0 after 0 usecs
[    8.275161] calling  dmi_init+0x0/0x146 @ 1
[    8.280186] initcall dmi_init+0x0/0x146 returned 0 after 0 usecs
[    8.286161] calling  efisubsys_init+0x0/0x27f @ 1
[    8.292161] initcall efisubsys_init+0x0/0x27f returned 0 after 0 usecs
[    8.299161] calling  ras_init+0x0/0x13 @ 1
[    8.304175] initcall ras_init+0x0/0x13 returned 0 after 0 usecs
[    8.310161] calling  nvmem_init+0x0/0x15 @ 1
[    8.315190] initcall nvmem_init+0x0/0x15 returned 0 after 0 usecs
[    8.322163] calling  proto_init+0x0/0x15 @ 1
[    8.327170] initcall proto_init+0x0/0x15 returned 0 after 0 usecs
[    8.333161] calling  net_dev_init+0x0/0x781 @ 1
[    8.339615] initcall net_dev_init+0x0/0x781 returned 0 after 0 usecs
[    8.346164] calling  neigh_init+0x0/0x89 @ 1
[    8.351171] initcall neigh_init+0x0/0x89 returned 0 after 0 usecs
[    8.358161] calling  fib_notifier_init+0x0/0x15 @ 1
[    8.363163] initcall fib_notifier_init+0x0/0x15 returned 0 after 0 usecs
[    8.370163] calling  fib_rules_init+0x0/0xb6 @ 1
[    8.376168] initcall fib_rules_init+0x0/0xb6 returned 0 after 0 usecs
[    8.383161] calling  init_cgroup_netprio+0x0/0x18 @ 1
[    8.388161] initcall init_cgroup_netprio+0x0/0x18 returned 0 after 0 usecs
[    8.396161] calling  bpf_lwt_init+0x0/0x1a @ 1
[    8.401161] initcall bpf_lwt_init+0x0/0x1a returned 0 after 0 usecs
[    8.408161] calling  pktsched_init+0x0/0x117 @ 1
[    8.413178] initcall pktsched_init+0x0/0x117 returned 0 after 0 usecs
[    8.420161] calling  tc_filter_init+0x0/0x104 @ 1
[    8.426202] initcall tc_filter_init+0x0/0x104 returned 0 after 0 usecs
[    8.433162] calling  tc_action_init+0x0/0x59 @ 1
[    8.438171] initcall tc_action_init+0x0/0x59 returned 0 after 0 usecs
[    8.445163] calling  ethnl_init+0x0/0x5c @ 1
[    8.450253] initcall ethnl_init+0x0/0x5c returned 0 after 0 usecs
[    8.457162] calling  nexthop_init+0x0/0xfa @ 1
[    8.462180] initcall nexthop_init+0x0/0xfa returned 0 after 0 usecs
[    8.469163] calling  cipso_v4_init+0x0/0x118 @ 1
[    8.474163] initcall cipso_v4_init+0x0/0x118 returned 0 after 0 usecs
[    8.481163] calling  netlbl_init+0x0/0x8c @ 1
[    8.486161] NetLabel: Initializing
[    8.490160] NetLabel:  domain hash size = 128
[    8.495161] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    8.501252] NetLabel:  unlabeled traffic allowed by default
[    8.508161] initcall netlbl_init+0x0/0x8c returned 0 after 22000 usecs
[    8.515161] calling  pci_subsys_init+0x0/0x122 @ 1
[    8.520161] PCI: Using ACPI for IRQ routing
[    8.526342] PCI: pci_cache_line_size set to 64 bytes
[    8.532208] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
[    8.538178] e820: reserve RAM buffer [mem 0xd1695000-0xd3ffffff]
[    8.545166] e820: reserve RAM buffer [mem 0xd1aca000-0xd3ffffff]
[    8.552165] e820: reserve RAM buffer [mem 0xd7eeb000-0xd7ffffff]
[    8.558165] e820: reserve RAM buffer [mem 0xd8760000-0xdbffffff]
[    8.565165] e820: reserve RAM buffer [mem 0xd8fae000-0xdbffffff]
[    8.572165] e820: reserve RAM buffer [mem 0xda71c000-0xdbffffff]
[    8.578165] e820: reserve RAM buffer [mem 0xdbb8d000-0xdbffffff]
[    8.585165] e820: reserve RAM buffer [mem 0x41ee00000-0x41fffffff]
[    8.592163] initcall pci_subsys_init+0x0/0x122 returned 0 after 72000 usecs
[    8.599162] calling  vsprintf_init_hashval+0x0/0x13 @ 1
[    8.605163] initcall vsprintf_init_hashval+0x0/0x13 returned 0 after 0 usecs
[    8.613161] calling  efi_runtime_map_init+0x0/0x1dc @ 1
[    8.619161] initcall efi_runtime_map_init+0x0/0x1dc returned 0 after 0 usecs
[    8.626161] calling  vga_arb_device_init+0x0/0x7b @ 1
[    8.632213] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    8.633157] pci 0000:00:02.0: vgaarb: bridge control possible
[    8.633157] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    8.654162] vgaarb: loaded
[    8.657160] initcall vga_arb_device_init+0x0/0x7b returned 0 after 25000 usecs
[    8.665161] calling  watchdog_init+0x0/0x13b @ 1
[    8.671183] initcall watchdog_init+0x0/0x13b returned 0 after 1000 usecs
[    8.678414] calling  nmi_warning_debugfs+0x0/0x51 @ 1
[    8.684169] initcall nmi_warning_debugfs+0x0/0x51 returned 0 after 0 usecs
[    8.691163] calling  save_microcode_in_initrd+0x0/0xc7 @ 1
[    8.697163] initcall save_microcode_in_initrd+0x0/0xc7 returned 0 after 0 usecs
[    8.705161] calling  hpet_late_init+0x0/0x173 @ 1
[    8.711165] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    8.717162] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    8.726158] initcall hpet_late_init+0x0/0x173 returned 0 after 15000 usecs
[    8.733162] calling  init_amd_nbs+0x0/0x1e7 @ 1
[    8.739165] initcall init_amd_nbs+0x0/0x1e7 returned 0 after 0 usecs
[    8.746162] calling  iomem_init_inode+0x0/0xab @ 1
[    8.751207] initcall iomem_init_inode+0x0/0xab returned 0 after 0 usecs
[    8.758163] calling  clocksource_done_booting+0x0/0x46 @ 1
[    8.764170] clocksource: Switched to clocksource tsc-early
[    8.770285] initcall clocksource_done_booting+0x0/0x46 returned 0 after 6127 usecs
[    8.778465] calling  tracer_init_tracefs+0x0/0x155 @ 1
[    8.784249] initcall tracer_init_tracefs+0x0/0x155 returned 0 after 13 usecs
[    8.791908] calling  init_trace_printk_function_export+0x0/0x2c @ 1
[    8.798803] initcall init_trace_printk_function_export+0x0/0x2c returned 0 after 7 usecs
[    8.807498] calling  init_graph_tracefs+0x0/0x2c @ 1
[    8.813108] initcall init_graph_tracefs+0x0/0x2c returned 0 after 6 usecs
[    8.820516] calling  trace_events_synth_init+0x0/0x4b @ 1
[    8.826559] initcall trace_events_synth_init+0x0/0x4b returned 0 after 7 usecs
[    8.834396] calling  bpf_event_init+0x0/0x13 @ 1
[    8.839656] initcall bpf_event_init+0x0/0x13 returned 0 after 1 usecs
[    8.846721] calling  init_kprobe_trace+0x0/0x310 @ 1
[    8.852334] initcall init_kprobe_trace+0x0/0x310 returned 0 after 12 usecs
[    8.859824] calling  init_dynamic_event+0x0/0x2c @ 1
[    8.865427] initcall init_dynamic_event+0x0/0x2c returned 0 after 5 usecs
[    8.872831] calling  init_uprobe_trace+0x0/0x60 @ 1
[    8.878353] initcall init_uprobe_trace+0x0/0x60 returned 0 after 10 usecs
[    8.885755] calling  bpf_init+0x0/0x9d @ 1
[    8.890507] initcall bpf_init+0x0/0x9d returned 0 after 9 usecs
[    8.897054] calling  secretmem_init+0x0/0x60 @ 1
[    8.902310] initcall secretmem_init+0x0/0x60 returned 0 after 0 usecs
[    8.909368] calling  init_fs_stat_sysctls+0x0/0x32 @ 1
[    8.915154] initcall init_fs_stat_sysctls+0x0/0x32 returned 0 after 16 usecs
[    8.922817] calling  init_fs_exec_sysctls+0x0/0x26 @ 1
[    8.928593] initcall init_fs_exec_sysctls+0x0/0x26 returned 0 after 4 usecs
[    8.936168] calling  init_pipe_fs+0x0/0x68 @ 1
[    8.941305] initcall init_pipe_fs+0x0/0x68 returned 0 after 52 usecs
[    8.948280] calling  init_fs_namei_sysctls+0x0/0x26 @ 1
[    8.954146] initcall init_fs_namei_sysctls+0x0/0x26 returned 0 after 10 usecs
[    8.961892] calling  init_fs_dcache_sysctls+0x0/0x26 @ 1
[    8.967835] initcall init_fs_dcache_sysctls+0x0/0x26 returned 0 after 3 usecs
[    8.975581] calling  init_fs_namespace_sysctls+0x0/0x26 @ 1
[    8.981785] initcall init_fs_namespace_sysctls+0x0/0x26 returned 0 after 2 usecs
[    8.989789] calling  cgroup_writeback_init+0x0/0x2a @ 1
[    8.995652] initcall cgroup_writeback_init+0x0/0x2a returned 0 after 8 usecs
[    9.003310] calling  inotify_user_setup+0x0/0x18c @ 1
[    9.009019] initcall inotify_user_setup+0x0/0x18c returned 0 after 26 usecs
[    9.016598] calling  eventpoll_init+0x0/0x145 @ 1
[    9.021970] initcall eventpoll_init+0x0/0x145 returned 0 after 30 usecs
[    9.029202] calling  anon_inode_init+0x0/0x8e @ 1
[    9.034583] initcall anon_inode_init+0x0/0x8e returned 0 after 40 usecs
[    9.041818] calling  init_dax_wait_table+0x0/0x38 @ 1
[    9.047521] initcall init_dax_wait_table+0x0/0x38 returned 0 after 18 usecs
[    9.055097] calling  proc_locks_init+0x0/0x2c @ 1
[    9.060449] initcall proc_locks_init+0x0/0x2c returned 0 after 10 usecs
[    9.067680] calling  init_fs_coredump_sysctls+0x0/0x26 @ 1
[    9.073799] initcall init_fs_coredump_sysctls+0x0/0x26 returned 0 after 5 usecs
[    9.081720] calling  iomap_init+0x0/0x24 @ 1
[    9.086746] initcall iomap_init+0x0/0x24 returned 0 after 115 usecs
[    9.093636] calling  dquot_init+0x0/0x167 @ 1
[    9.098631] VFS: Disk quotas dquot_6.6.0
[    9.103226] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    9.110715] initcall dquot_init+0x0/0x167 returned 0 after 12084 usecs
[    9.117857] calling  quota_init+0x0/0x28 @ 1
[    9.122804] initcall quota_init+0x0/0x28 returned 0 after 37 usecs
[    9.129604] calling  proc_cmdline_init+0x0/0x8d @ 1
[    9.135119] initcall proc_cmdline_init+0x0/0x8d returned 0 after 4 usecs
[    9.142436] calling  proc_consoles_init+0x0/0x29 @ 1
[    9.148037] initcall proc_consoles_init+0x0/0x29 returned 0 after 2 usecs
[    9.155440] calling  proc_cpuinfo_init+0x0/0x23 @ 1
[    9.160959] initcall proc_cpuinfo_init+0x0/0x23 returned 0 after 7 usecs
[    9.168275] calling  proc_devices_init+0x0/0x62 @ 1
[    9.173788] initcall proc_devices_init+0x0/0x62 returned 0 after 2 usecs
[    9.181103] calling  proc_interrupts_init+0x0/0x29 @ 1
[    9.186876] initcall proc_interrupts_init+0x0/0x29 returned 0 after 2 usecs
[    9.194450] calling  proc_loadavg_init+0x0/0x5f @ 1
[    9.199963] initcall proc_loadavg_init+0x0/0x5f returned 0 after 2 usecs
[    9.207279] calling  proc_meminfo_init+0x0/0x5f @ 1
[    9.212808] initcall proc_meminfo_init+0x0/0x5f returned 0 after 9 usecs
[    9.220124] calling  proc_stat_init+0x0/0x23 @ 1
[    9.225394] initcall proc_stat_init+0x0/0x23 returned 0 after 13 usecs
[    9.232554] calling  proc_uptime_init+0x0/0x5f @ 1
[    9.237997] initcall proc_uptime_init+0x0/0x5f returned 0 after 11 usecs
[    9.245314] calling  proc_version_init+0x0/0x5f @ 1
[    9.250830] initcall proc_version_init+0x0/0x5f returned 0 after 2 usecs
[    9.258148] calling  proc_softirqs_init+0x0/0x5f @ 1
[    9.263751] initcall proc_softirqs_init+0x0/0x5f returned 0 after 2 usecs
[    9.271153] calling  proc_kcore_init+0x0/0x146 @ 1
[    9.276620] initcall proc_kcore_init+0x0/0x146 returned 0 after 42 usecs
[    9.283940] calling  vmcore_init+0x0/0x2ef @ 1
[    9.289022] initcall vmcore_init+0x0/0x2ef returned 0 after 0 usecs
[    9.295911] calling  proc_kmsg_init+0x0/0x26 @ 1
[    9.301168] initcall proc_kmsg_init+0x0/0x26 returned 0 after 3 usecs
[    9.308226] calling  proc_page_init+0x0/0x5a @ 1
[    9.313487] initcall proc_page_init+0x0/0x5a returned 0 after 6 usecs
[    9.320545] calling  init_ramfs_fs+0x0/0x15 @ 1
[    9.325712] initcall init_ramfs_fs+0x0/0x15 returned 0 after 1 usecs
[    9.332686] calling  init_hugetlbfs_fs+0x0/0x2a4 @ 1
[    9.338362] initcall init_hugetlbfs_fs+0x0/0x2a4 returned 0 after 77 usecs
[    9.345854] calling  aa_create_aafs+0x0/0x7bd @ 1
[    9.351610] AppArmor: AppArmor Filesystem Enabled
[    9.356954] initcall aa_create_aafs+0x0/0x7bd returned 0 after 5755 usecs
[    9.364357] calling  dynamic_debug_init_control+0x0/0x80 @ 1
[    9.370676] initcall dynamic_debug_init_control+0x0/0x80 returned 0 after 33 usecs
[    9.378860] calling  acpi_event_init+0x0/0x65 @ 1
[    9.384238] initcall acpi_event_init+0x0/0x65 returned 0 after 34 usecs
[    9.391471] calling  pnp_system_init+0x0/0x15 @ 1
[    9.396844] initcall pnp_system_init+0x0/0x15 returned 0 after 31 usecs
[    9.404076] calling  pnpacpi_init+0x0/0xd6 @ 1
[    9.409161] pnp: PnP ACPI init
[    9.413392] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    9.422835] system 00:01: [io  0x0680-0x069f] has been reserved
[    9.429391] system 00:01: [io  0xffff] has been reserved
[    9.435341] system 00:01: [io  0xffff] has been reserved
[    9.441288] system 00:01: [io  0xffff] has been reserved
[    9.447234] system 00:01: [io  0x1c00-0x1cfe] has been reserved
[    9.453782] system 00:01: [io  0x1d00-0x1dfe] has been reserved
[    9.460330] system 00:01: [io  0x1e00-0x1efe] has been reserved
[    9.466879] system 00:01: [io  0x1f00-0x1ffe] has been reserved
[    9.473426] system 00:01: [io  0x1800-0x18fe] has been reserved
[    9.479980] system 00:01: [io  0x164e-0x164f] has been reserved
[    9.487108] system 00:03: [io  0x1854-0x1857] has been reserved
[    9.494986] system 00:04: [io  0x0a00-0x0a0f] has been reserved
[    9.501957] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    9.516801] pnp 00:06: [dma 0 disabled]
[    9.526359] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    9.533603] system 00:07: [mem 0xfed10000-0xfed17fff] has been reserved
[    9.540842] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    9.548080] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    9.555316] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    9.562552] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    9.569795] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reserved
[    9.577377] system 00:07: [mem 0xfed45000-0xfed8ffff] has been reserved
[    9.584613] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
[    9.591867] system 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved
[    9.599445] system 00:07: [mem 0xf7fee000-0xf7feefff] has been reserved
[    9.606681] system 00:07: [mem 0xf7fd0000-0xf7fdffff] has been reserved
[    9.616878] pnp: PnP ACPI: found 8 devices
[    9.621621] initcall pnpacpi_init+0x0/0xd6 returned 0 after 212460 usecs
[    9.628938] calling  chr_dev_init+0x0/0x135 @ 1
[    9.639699] initcall chr_dev_init+0x0/0x135 returned 0 after 5591 usecs
[    9.646938] calling  hwrng_modinit+0x0/0xea @ 1
[    9.652242] initcall hwrng_modinit+0x0/0xea returned 0 after 132 usecs
[    9.659395] calling  firmware_class_init+0x0/0xfe @ 1
[    9.665108] initcall firmware_class_init+0x0/0xfe returned 0 after 27 usecs
[    9.672686] calling  map_properties+0x0/0x301 @ 1
[    9.678027] initcall map_properties+0x0/0x301 returned 0 after 0 usecs
[    9.685174] calling  init_acpi_pm_clocksource+0x0/0xd6 @ 1
[    9.695811] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    9.705273] initcall init_acpi_pm_clocksource+0x0/0xd6 returned 0 after 13983 usecs
[    9.713535] calling  powercap_init+0x0/0x26 @ 1
[    9.718871] initcall powercap_init+0x0/0x26 returned 0 after 164 usecs
[    9.726018] calling  sysctl_core_init+0x0/0x2f @ 1
[    9.731468] initcall sysctl_core_init+0x0/0x2f returned 0 after 25 usecs
[    9.738784] calling  eth_offload_init+0x0/0x18 @ 1
[    9.744210] initcall eth_offload_init+0x0/0x18 returned 0 after 0 usecs
[    9.751438] calling  ipv4_offload_init+0x0/0x78 @ 1
[    9.756951] initcall ipv4_offload_init+0x0/0x78 returned 0 after 0 usecs
[    9.764268] calling  inet_init+0x0/0x345 @ 1
[    9.769245] NET: Registered PF_INET protocol family
[    9.774941] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    9.787296] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    9.796529] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    9.804929] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    9.813814] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    9.822076] TCP: Hash tables configured (established 131072 bind 65536)
[    9.829539] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[    9.837784] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    9.845236] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    9.853270] initcall inet_init+0x0/0x345 returned 0 after 84091 usecs
[    9.860334] calling  af_unix_init+0x0/0x1cb @ 1
[    9.865525] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    9.871830] initcall af_unix_init+0x0/0x1cb returned 0 after 6325 usecs
[    9.879063] calling  ipv6_offload_init+0x0/0x83 @ 1
[    9.884577] initcall ipv6_offload_init+0x0/0x83 returned 0 after 0 usecs
[    9.891895] calling  init_sunrpc+0x0/0x8c @ 1
[    9.897257] RPC: Registered named UNIX socket transport module.
[    9.903805] RPC: Registered udp transport module.
[    9.909144] RPC: Registered tcp transport module.
[    9.914483] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    9.921539] initcall init_sunrpc+0x0/0x8c returned 0 after 24648 usecs
[    9.928686] calling  vlan_offload_init+0x0/0x24 @ 1
[    9.934199] initcall vlan_offload_init+0x0/0x24 returned 0 after 0 usecs
[    9.941518] calling  xsk_init+0x0/0x1bc @ 1
[    9.946345] NET: Registered PF_XDP protocol family
[    9.951772] initcall xsk_init+0x0/0x1bc returned 0 after 5428 usecs
[    9.958657] calling  pcibios_assign_resources+0x0/0x23a @ 1
[    9.964873] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    9.970484] pci 0000:02:00.0: PCI bridge to [bus 03]
[    9.976098] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    9.981966] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    9.987565] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    9.994285] pci 0000:00:1c.2:   bridge window [mem 0xf7c00000-0xf7cfffff]
[   10.001695] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   10.008496] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[   10.015297] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[   10.022785] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000e7fff window]
[   10.030274] pci_bus 0000:00: resource 8 [mem 0xdf200000-0xfeafffff window]
[   10.037764] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[   10.043963] pci_bus 0000:04: resource 1 [mem 0xf7c00000-0xf7cfffff]
[   10.051470] initcall pcibios_assign_resources+0x0/0x23a returned 0 after 86609 usecs
[   10.059819] calling  pci_apply_final_quirks+0x0/0x330 @ 1
[   10.065851] pci 0000:00:00.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.073514] pci 0000:00:00.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.081176] pci 0000:00:02.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.088836] pci 0000:00:02.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.096497] pci 0000:00:03.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.104160] pci 0000:00:03.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.111822] pci 0000:00:14.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.119483] pci 0000:00:14.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.127145] pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
[   10.135801] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   10.149825] IOAPIC[0]: Preconfigured routing entry (8-16 -> IRQ 16 Level:1 ActiveLow:1)
[   10.159423] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2d0 took 24039 usecs
[   10.167443] pci 0000:00:16.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.175107] pci 0000:00:16.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.182769] pci 0000:00:19.0: calling  quirk_e100_interrupt+0x0/0x290 @ 1
[   10.190171] pci 0000:00:19.0: quirk_e100_interrupt+0x0/0x290 took 0 usecs
[   10.197577] pci 0000:00:1a.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.205238] pci 0000:00:1a.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.212900] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
[   10.221504] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   10.235530] IOAPIC[0]: Preconfigured routing entry (8-16 -> IRQ 16 Level:1 ActiveLow:1)
[   10.245136] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x2d0 took 24001 usecs
[   10.253153] pci 0000:00:1b.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.260818] pci 0000:00:1b.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.268495] pci 0000:00:1d.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.276156] pci 0000:00:1d.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.283822] pci 0000:00:1d.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
[   10.292408] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   10.306431] IOAPIC[0]: Preconfigured routing entry (8-23 -> IRQ 23 Level:1 ActiveLow:1)
[   10.315999] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x2d0 took 23939 usecs
[   10.324017] pci 0000:00:1f.0: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.331679] pci 0000:00:1f.0: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.339345] pci 0000:00:1f.2: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.347007] pci 0000:00:1f.2: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.354670] pci 0000:00:1f.3: calling  quirk_remove_d3hot_delay+0x0/0x50 @ 1
[   10.362328] pci 0000:00:1f.3: quirk_remove_d3hot_delay+0x0/0x50 took 0 usecs
[   10.369995] pci 0000:04:00.0: calling  quirk_e100_interrupt+0x0/0x290 @ 1
[   10.377399] pci 0000:04:00.0: quirk_e100_interrupt+0x0/0x290 took 0 usecs
[   10.384806] PCI: CLS 64 bytes, default 64
[   10.389458] initcall pci_apply_final_quirks+0x0/0x330 returned 0 after 323610 usecs
[   10.397718] calling  acpi_reserve_resources+0x0/0x277 @ 1
[   10.403756] initcall acpi_reserve_resources+0x0/0x277 returned 0 after 10 usecs
[   10.411675] calling  populate_rootfs+0x0/0x40 @ 1
[   10.417025] initcall populate_rootfs+0x0/0x40 returned 0 after 6 usecs
[   10.417185] Trying to unpack rootfs image as initramfs...
[   10.424170] calling  pci_iommu_init+0x0/0x59 @ 1
[   10.424197] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   10.442538] software IO TLB: mapped [mem 0x00000000d3eeb000-0x00000000d7eeb000] (64MB)
[   10.451059] initcall pci_iommu_init+0x0/0x59 returned 0 after 26884 usecs
[   10.458464] calling  ir_dev_scope_init+0x0/0x71 @ 1
[   10.463986] initcall ir_dev_scope_init+0x0/0x71 returned 0 after 8 usecs
[   10.471316] calling  nhi_init+0x0/0x3e @ 1
[   10.476080] ACPI: bus type thunderbolt registered
[   10.481523] initcall nhi_init+0x0/0x3e returned 0 after 5463 usecs
[   10.488569] calling  ia32_binfmt_init+0x0/0x18 @ 1
[   10.494014] initcall ia32_binfmt_init+0x0/0x18 returned 0 after 13 usecs
[   10.501337] calling  amd_ibs_init+0x0/0x1a2 @ 1
[   10.506506] initcall amd_ibs_init+0x0/0x1a2 returned -19 after 0 usecs
[   10.513654] calling  msr_init+0x0/0x80 @ 1
[   10.518409] initcall msr_init+0x0/0x80 returned 0 after 10 usecs
[   10.525043] calling  register_kernel_offset_dumper+0x0/0x1f @ 1
[   10.531595] initcall register_kernel_offset_dumper+0x0/0x1f returned 0 after 0 usecs
[   10.539949] calling  i8259A_init_ops+0x0/0x25 @ 1
[   10.545304] initcall i8259A_init_ops+0x0/0x25 returned 0 after 8 usecs
[   10.552463] calling  init_tsc_clocksource+0x0/0xe6 @ 1
[   10.558240] initcall init_tsc_clocksource+0x0/0xe6 returned 0 after 2 usecs
[   10.565819] calling  add_rtc_cmos+0x0/0x1f4 @ 1
[   10.570992] initcall add_rtc_cmos+0x0/0x1f4 returned 0 after 2 usecs
[   10.577968] calling  i8237A_init_ops+0x0/0x3b @ 1
[   10.583322] initcall i8237A_init_ops+0x0/0x3b returned 0 after 8 usecs
[   10.590474] calling  umwait_init+0x0/0xe1 @ 1
[   10.595476] initcall umwait_init+0x0/0xe1 returned -19 after 0 usecs
[   10.602453] calling  msr_init+0x0/0x101 @ 1
[   10.608565] initcall msr_init+0x0/0x101 returned 0 after 1282 usecs
[   10.615462] calling  cpuid_init+0x0/0x101 @ 1
[   10.621268] initcall cpuid_init+0x0/0x101 returned 0 after 804 usecs
[   10.628252] calling  ioapic_init_ops+0x0/0x18 @ 1
[   10.633594] initcall ioapic_init_ops+0x0/0x18 returned 0 after 0 usecs
[   10.640743] calling  register_e820_pmem+0x0/0x62 @ 1
[   10.646348] initcall register_e820_pmem+0x0/0x62 returned 0 after 5 usecs
[   10.653753] calling  add_pcspkr+0x0/0xd3 @ 1
[   10.658751] initcall add_pcspkr+0x0/0xd3 returned 0 after 82 usecs
[   10.665557] calling  start_periodic_check_for_corruption+0x0/0x40 @ 1
[   10.672622] initcall start_periodic_check_for_corruption+0x0/0x40 returned 0 after 0 usecs
[   10.681489] calling  audit_classes_init+0x0/0xb3 @ 1
[   10.687112] initcall audit_classes_init+0x0/0xb3 returned 0 after 18 usecs
[   10.694607] calling  sha1_ssse3_mod_init+0x0/0xeb @ 1
[   10.700314] initcall sha1_ssse3_mod_init+0x0/0xeb returned 0 after 17 usecs
[   10.707903] calling  sha256_ssse3_mod_init+0x0/0xff @ 1
[   10.713788] initcall sha256_ssse3_mod_init+0x0/0xff returned 0 after 12 usecs
[   10.721535] calling  iosf_mbi_init+0x0/0x2d @ 1
[   10.726755] initcall iosf_mbi_init+0x0/0x2d returned 0 after 49 usecs
[   10.733819] calling  proc_execdomains_init+0x0/0x26 @ 1
[   10.739686] initcall proc_execdomains_init+0x0/0x26 returned 0 after 7 usecs
[   10.747350] calling  register_warn_debugfs+0x0/0x28 @ 1
[   10.753222] initcall register_warn_debugfs+0x0/0x28 returned 0 after 10 usecs
[   10.760976] calling  cpuhp_sysfs_init+0x0/0x144 @ 1
[   10.766591] initcall cpuhp_sysfs_init+0x0/0x144 returned 0 after 94 usecs
[   10.774003] calling  ioresources_init+0x0/0x4e @ 1
[   10.779455] initcall ioresources_init+0x0/0x4e returned 0 after 18 usecs
[   10.786787] calling  snapshot_device_init+0x0/0x15 @ 1
[   10.792664] initcall snapshot_device_init+0x0/0x15 returned 0 after 103 usecs
[   10.800416] calling  irq_pm_init_ops+0x0/0x18 @ 1
[   10.805759] initcall irq_pm_init_ops+0x0/0x18 returned 0 after 0 usecs
[   10.812906] calling  klp_init+0x0/0x53 @ 1
[   10.817657] initcall klp_init+0x0/0x53 returned 0 after 8 usecs
[   10.824204] calling  proc_modules_init+0x0/0x23 @ 1
[   10.829726] initcall proc_modules_init+0x0/0x23 returned 0 after 6 usecs
[   10.837051] calling  timer_sysctl_init+0x0/0x1f @ 1
[   10.842594] initcall timer_sysctl_init+0x0/0x1f returned 0 after 24 usecs
[   10.850007] calling  timekeeping_init_ops+0x0/0x18 @ 1
[   10.855781] initcall timekeeping_init_ops+0x0/0x18 returned 0 after 0 usecs
[   10.863356] calling  init_clocksource_sysfs+0x0/0x28 @ 1
[   10.869435] initcall init_clocksource_sysfs+0x0/0x28 returned 0 after 136 usecs
[   10.877356] calling  init_timer_list_procfs+0x0/0x36 @ 1
[   10.883306] initcall init_timer_list_procfs+0x0/0x36 returned 0 after 5 usecs
[   10.891055] calling  alarmtimer_init+0x0/0x109 @ 1
[   10.896524] initcall alarmtimer_init+0x0/0x109 returned 0 after 38 usecs
[   10.903844] calling  init_posix_timers+0x0/0x2e @ 1
[   10.909382] initcall init_posix_timers+0x0/0x2e returned 0 after 24 usecs
[   10.916789] calling  clockevents_init_sysfs+0x0/0x19e @ 1
[   10.923305] initcall clockevents_init_sysfs+0x0/0x19e returned 0 after 482 usecs
[   10.931318] calling  proc_dma_init+0x0/0x26 @ 1
[   10.936495] initcall proc_dma_init+0x0/0x26 returned 0 after 5 usecs
[   10.943471] calling  kallsyms_init+0x0/0x26 @ 1
[   10.948651] initcall kallsyms_init+0x0/0x26 returned 0 after 5 usecs
[   10.955625] calling  pid_namespaces_init+0x0/0x31 @ 1
[   10.961335] initcall pid_namespaces_init+0x0/0x31 returned 0 after 23 usecs
[   10.968908] calling  ikconfig_init+0x0/0x46 @ 1
[   10.974085] initcall ikconfig_init+0x0/0x46 returned 0 after 3 usecs
[   10.981059] calling  audit_watch_init+0x0/0x40 @ 1
[   10.986492] initcall audit_watch_init+0x0/0x40 returned 0 after 2 usecs
[   10.993725] calling  audit_fsnotify_init+0x0/0x43 @ 1
[   10.999420] initcall audit_fsnotify_init+0x0/0x43 returned 0 after 10 usecs
[   11.007005] calling  audit_tree_init+0x0/0xcf @ 1
[   11.012371] initcall audit_tree_init+0x0/0xcf returned 0 after 24 usecs
[   11.019604] calling  seccomp_sysctl_init+0x0/0x30 @ 1
[   11.025305] initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 15 usecs
[   11.032879] calling  utsname_sysctl_init+0x0/0x18 @ 1
[   11.038580] initcall utsname_sysctl_init+0x0/0x18 returned 0 after 17 usecs
[   11.046157] calling  init_tracepoints+0x0/0x30 @ 1
[   11.051588] initcall init_tracepoints+0x0/0x30 returned 0 after 1 usecs
[   11.058820] calling  init_lstats_procfs+0x0/0x40 @ 1
[   11.064433] initcall init_lstats_procfs+0x0/0x40 returned 0 after 10 usecs
[   11.071926] calling  stack_trace_init+0x0/0xa8 @ 1
[   11.077382] initcall stack_trace_init+0x0/0xa8 returned 0 after 28 usecs
[   11.084710] calling  perf_event_sysfs_init+0x0/0x10a @ 1
[   11.091156] initcall perf_event_sysfs_init+0x0/0x10a returned 0 after 500 usecs
[   11.099082] calling  system_trusted_keyring_init+0x0/0x8e @ 1
[   11.105457] Initialise system trusted keyrings
[   11.110554] initcall system_trusted_keyring_init+0x0/0x8e returned 0 after 5096 usecs
[   11.118989] calling  blacklist_init+0x0/0x166 @ 1
[   11.124337] Key type blacklist registered
[   11.128998] initcall blacklist_init+0x0/0x166 returned 0 after 4662 usecs
[   11.136406] calling  kswapd_init+0x0/0x64 @ 1
[   11.141534] initcall kswapd_init+0x0/0x64 returned 0 after 127 usecs
[   11.148514] calling  extfrag_debug_init+0x0/0x5b @ 1
[   11.154149] initcall extfrag_debug_init+0x0/0x5b returned 0 after 34 usecs
[   11.161649] calling  mm_compute_batch_init+0x0/0x57 @ 1
[   11.167507] initcall mm_compute_batch_init+0x0/0x57 returned 0 after 1 usecs
[   11.175168] calling  slab_proc_init+0x0/0x26 @ 1
[   11.180430] initcall slab_proc_init+0x0/0x26 returned 0 after 6 usecs
[   11.187489] calling  workingset_init+0x0/0xd4 @ 1
[   11.192829] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[   11.199900] initcall workingset_init+0x0/0xd4 returned 0 after 7070 usecs
[   11.207316] calling  proc_vmalloc_init+0x0/0x68 @ 1
[   11.212852] initcall proc_vmalloc_init+0x0/0x68 returned 0 after 21 usecs
[   11.220259] calling  procswaps_init+0x0/0x23 @ 1
[   11.225519] initcall procswaps_init+0x0/0x23 returned 0 after 4 usecs
[   11.232579] calling  init_frontswap+0x0/0x97 @ 1
[   11.237862] initcall init_frontswap+0x0/0x97 returned 0 after 27 usecs
[   11.245009] calling  slab_debugfs_init+0x0/0x52 @ 1
[   11.250541] initcall slab_debugfs_init+0x0/0x52 returned 0 after 16 usecs
[   11.257945] calling  init_zbud+0x0/0x24 @ 1
[   11.262771] zbud: loaded
[   11.265965] initcall init_zbud+0x0/0x24 returned 0 after 3193 usecs
[   11.272854] calling  zs_init+0x0/0x77 @ 1
[   11.277574] initcall zs_init+0x0/0x77 returned 0 after 63 usecs
[   11.284142] calling  fcntl_init+0x0/0x2e @ 1
[   11.289109] initcall fcntl_init+0x0/0x2e returned 0 after 38 usecs
[   11.295925] calling  proc_filesystems_init+0x0/0x26 @ 1
[   11.301802] initcall proc_filesystems_init+0x0/0x26 returned 0 after 8 usecs
[   11.309478] calling  start_dirtytime_writeback+0x0/0x1b @ 1
[   11.315692] initcall start_dirtytime_writeback+0x0/0x1b returned 0 after 1 usecs
[   11.323712] calling  dio_init+0x0/0x31 @ 1
[   11.328486] initcall dio_init+0x0/0x31 returned 0 after 19 usecs
[   11.335127] calling  dnotify_init+0x0/0xa1 @ 1
[   11.340270] initcall dnotify_init+0x0/0xa1 returned 0 after 47 usecs
[   11.347257] calling  fanotify_user_setup+0x0/0x1fb @ 1
[   11.353096] initcall fanotify_user_setup+0x0/0x1fb returned 0 after 53 usecs
[   11.360763] calling  aio_setup+0x0/0x9c @ 1
[   11.365654] initcall aio_setup+0x0/0x9c returned 0 after 64 usecs
[   11.372373] calling  mbcache_init+0x0/0x35 @ 1
[   11.377466] initcall mbcache_init+0x0/0x35 returned 0 after 9 usecs
[   11.384354] calling  init_grace+0x0/0x15 @ 1
[   11.389270] initcall init_grace+0x0/0x15 returned 0 after 3 usecs
[   11.395985] calling  init_v2_quota_format+0x0/0x26 @ 1
[   11.401756] initcall init_v2_quota_format+0x0/0x26 returned 0 after 0 usecs
[   11.409328] calling  init_devpts_fs+0x0/0x30 @ 1
[   11.414596] initcall init_devpts_fs+0x0/0x30 returned 0 after 15 usecs
[   11.421740] calling  ext4_init_fs+0x0/0x1a3 @ 1
[   11.427257] initcall ext4_init_fs+0x0/0x1a3 returned 0 after 345 usecs
[   11.434407] calling  journal_init+0x0/0x132 @ 1
[   11.439644] initcall journal_init+0x0/0x132 returned 0 after 68 usecs
[   11.446715] calling  init_nfs_fs+0x0/0x195 @ 1
[   11.452194] initcall init_nfs_fs+0x0/0x195 returned 0 after 390 usecs
[   11.459259] calling  init_nfs_v3+0x0/0x18 @ 1
[   11.464261] initcall init_nfs_v3+0x0/0x18 returned 0 after 0 usecs
[   11.471065] calling  init_nlm+0x0/0x66 @ 1
[   11.475836] initcall init_nlm+0x0/0x66 returned 0 after 28 usecs
[   11.482475] calling  init_nls_cp437+0x0/0x17 @ 1
[   11.487732] initcall init_nls_cp437+0x0/0x17 returned 0 after 0 usecs
[   11.494789] calling  init_nls_ascii+0x0/0x17 @ 1
[   11.500043] initcall init_nls_ascii+0x0/0x17 returned 0 after 0 usecs
[   11.507105] calling  init_autofs_fs+0x0/0x2e @ 1
[   11.512461] initcall init_autofs_fs+0x0/0x2e returned 0 after 101 usecs
[   11.519698] calling  efivarfs_init+0x0/0x25 @ 1
[   11.524869] initcall efivarfs_init+0x0/0x25 returned -19 after 0 usecs
[   11.532016] calling  ipc_init+0x0/0x29 @ 1
[   11.536791] initcall ipc_init+0x0/0x29 returned 0 after 36 usecs
[   11.543428] calling  ipc_sysctl_init+0x0/0x31 @ 1
[   11.548790] initcall ipc_sysctl_init+0x0/0x31 returned 0 after 22 usecs
[   11.556022] calling  init_mqueue_fs+0x0/0xec @ 1
[   11.561344] initcall init_mqueue_fs+0x0/0xec returned 0 after 67 usecs
[   11.568493] calling  key_proc_init+0x0/0x72 @ 1
[   11.573668] initcall key_proc_init+0x0/0x72 returned 0 after 5 usecs
[   11.580643] calling  apparmor_nf_ip_init+0x0/0x3f @ 1
[   11.586380] initcall apparmor_nf_ip_init+0x0/0x3f returned 0 after 50 usecs
[   11.593958] calling  jent_mod_init+0x0/0x32 @ 1
[   11.606787] initcall jent_mod_init+0x0/0x32 returned 0 after 7659 usecs
[   11.614028] calling  af_alg_init+0x0/0x45 @ 1
[   11.619035] NET: Registered PF_ALG protocol family
[   11.624463] initcall af_alg_init+0x0/0x45 returned 0 after 5432 usecs
[   11.631525] calling  algif_hash_init+0x0/0x15 @ 1
[   11.636871] initcall algif_hash_init+0x0/0x15 returned 0 after 3 usecs
[   11.642169] tsc: Refined TSC clocksource calibration: 3392.144 MHz
[   11.644019] calling  algif_skcipher_init+0x0/0x15 @ 1
[   11.650832] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x30e5517d4e4, max_idle_ns: 440795261668 ns
[   11.656509] initcall algif_skcipher_init+0x0/0x15 returned 0 after 3 usecs
[   11.674602] calling  rng_init+0x0/0x15 @ 1
[   11.679354] clocksource: Switched to clocksource tsc
[   11.679358] initcall rng_init+0x0/0x15 returned 0 after 10 usecs
[   11.691588] calling  algif_aead_init+0x0/0x15 @ 1
[   11.696941] initcall algif_aead_init+0x0/0x15 returned 0 after 9 usecs
[   11.704096] calling  asymmetric_key_init+0x0/0x15 @ 1
[   11.709787] Key type asymmetric registered
[   11.714529] initcall asymmetric_key_init+0x0/0x15 returned 0 after 4743 usecs
[   11.722279] calling  x509_key_init+0x0/0x1f @ 1
[   11.727451] Asymmetric key parser 'x509' registered
[   11.732966] Running certificate verification selftests
[   11.739683] Loaded X.509 cert 'Certificate verification self-testing key: f58703bb33ce1b73ee02eccdee5b8817518fe3db'
[   11.751383] initcall x509_key_init+0x0/0x1f returned 0 after 23933 usecs
[   11.758707] calling  blkdev_init+0x0/0x24 @ 1
[   11.763747] initcall blkdev_init+0x0/0x24 returned 0 after 40 usecs
[   11.770637] calling  proc_genhd_init+0x0/0x46 @ 1
[   11.776048] initcall proc_genhd_init+0x0/0x46 returned 0 after 66 usecs
[   11.783282] calling  bsg_init+0x0/0x11b @ 1
[   11.788151] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[   11.796157] initcall bsg_init+0x0/0x11b returned 0 after 8041 usecs
[   11.803048] calling  throtl_init+0x0/0x45 @ 1
[   11.808151] initcall throtl_init+0x0/0x45 returned 0 after 105 usecs
[   11.815138] calling  deadline_init+0x0/0x15 @ 1
[   11.820309] io scheduler mq-deadline registered
[   11.825480] initcall deadline_init+0x0/0x15 returned 0 after 5170 usecs
[   11.832711] calling  kyber_init+0x0/0x15 @ 1
[   11.837625] io scheduler kyber registered
[   11.842279] initcall kyber_init+0x0/0x15 returned 0 after 4654 usecs
[   11.849256] calling  bfq_init+0x0/0x8f @ 1
[   11.854039] io scheduler bfq registered
[   11.858521] initcall bfq_init+0x0/0x8f returned 0 after 4524 usecs
[   11.865326] calling  io_uring_init+0x0/0x36 @ 1
[   11.870507] initcall io_uring_init+0x0/0x36 returned 0 after 11 usecs
[   11.877569] calling  blake2s_mod_init+0x0/0xc @ 1
[   11.882913] initcall blake2s_mod_init+0x0/0xc returned 0 after 0 usecs
[   11.890058] calling  crc_t10dif_mod_init+0x0/0x50 @ 1
[   11.895787] initcall crc_t10dif_mod_init+0x0/0x50 returned 0 after 41 usecs
[   11.903371] calling  percpu_counter_startup+0x0/0x55 @ 1
[   11.909377] initcall percpu_counter_startup+0x0/0x55 returned 0 after 61 usecs
[   11.917211] calling  digsig_init+0x0/0x3d @ 1
[   11.922218] initcall digsig_init+0x0/0x3d returned 0 after 8 usecs
[   11.929021] calling  pcie_portdrv_init+0x0/0x4d @ 1
[   11.935891] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   11.949917] IOAPIC[0]: Preconfigured routing entry (8-16 -> IRQ 16 Level:1 ActiveLow:1)
[   11.958891] pcieport 0000:00:1c.0: PME: Signaling with IRQ 26
[   11.966596] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   11.980622] IOAPIC[0]: Preconfigured routing entry (8-17 -> IRQ 17 Level:1 ActiveLow:1)
[   11.989582] pcieport 0000:00:1c.1: PME: Signaling with IRQ 27
[   11.997298] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   12.011325] IOAPIC[0]: Preconfigured routing entry (8-18 -> IRQ 18 Level:1 ActiveLow:1)
[   12.020301] pcieport 0000:00:1c.2: PME: Signaling with IRQ 28
[   12.026899] initcall pcie_portdrv_init+0x0/0x4d returned 0 after 92363 usecs
[   12.034571] calling  pci_proc_init+0x0/0x70 @ 1
[   12.039801] initcall pci_proc_init+0x0/0x70 returned 0 after 59 usecs
[   12.046865] calling  pci_hotplug_init+0x0/0xc @ 1
[   12.052212] initcall pci_hotplug_init+0x0/0xc returned 0 after 0 usecs
[   12.059363] calling  shpcd_init+0x0/0x61 @ 1
[   12.064449] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.071786] initcall shpcd_init+0x0/0x61 returned 0 after 7509 usecs
[   12.078774] calling  pci_stub_init+0x0/0x1ff @ 1
[   12.084107] initcall pci_stub_init+0x0/0x1ff returned 0 after 65 usecs
[   12.091266] calling  vmd_drv_init+0x0/0x1e @ 1
[   12.096413] initcall vmd_drv_init+0x0/0x1e returned 0 after 49 usecs
[   12.103608] calling  vesafb_driver_init+0x0/0x17 @ 1
[   12.110853] initcall vesafb_driver_init+0x0/0x17 returned 0 after 1645 usecs
[   12.118516] calling  efifb_driver_init+0x0/0x17 @ 1
[   12.124054] initcall efifb_driver_init+0x0/0x17 returned 0 after 24 usecs
[   12.131459] calling  intel_idle_init+0x0/0x507 @ 1
[   12.139668] initcall intel_idle_init+0x0/0x507 returned 0 after 2782 usecs
[   12.147179] calling  ged_driver_init+0x0/0x17 @ 1
[   12.152587] initcall ged_driver_init+0x0/0x17 returned 0 after 62 usecs
[   12.159840] calling  acpi_ac_init+0x0/0x7c @ 1
[   12.165054] initcall acpi_ac_init+0x0/0x7c returned 0 after 126 usecs
[   12.172129] calling  acpi_button_driver_init+0x0/0xb3 @ 1
[   12.178414] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[   12.187602] ACPI: button: Power Button [PWRB]
[   12.192851] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   12.201099] ACPI: button: Power Button [PWRF]
[   12.206145] initcall acpi_button_driver_init+0x0/0xb3 returned 0 after 27975 usecs
[   12.214328] calling  acpi_fan_driver_init+0x0/0x17 @ 1
[   12.220141] initcall acpi_fan_driver_init+0x0/0x17 returned 0 after 34 usecs
[   12.227817] calling  acpi_processor_driver_init+0x0/0xef @ 1
[   12.235393] initcall acpi_processor_driver_init+0x0/0xef returned 0 after 1282 usecs
[   12.243761] calling  acpi_thermal_init+0x0/0x86 @ 1
[   12.252143] ACPI: \_TZ_.TZ00: Invalid active0 threshold
[   12.259247] thermal LNXTHERM:00: registered as thermal_zone0
[   12.265548] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[   12.275450] thermal LNXTHERM:01: registered as thermal_zone1
[   12.281750] ACPI: thermal: Thermal Zone [TZ01] (30 C)
[   12.287493] initcall acpi_thermal_init+0x0/0x86 returned 0 after 38217 usecs
[   12.295160] calling  acpi_battery_init+0x0/0x71 @ 1
[   12.300692] initcall acpi_battery_init+0x0/0x71 returned 0 after 17 usecs
[   12.308110] calling  acpi_hed_driver_init+0x0/0x15 @ 1
[   12.313948] initcall acpi_hed_driver_init+0x0/0x15 returned 0 after 55 usecs
[   12.321622] calling  bgrt_init+0x0/0x19f @ 1
[   12.326536] initcall bgrt_init+0x0/0x19f returned -19 after 0 usecs
[   12.333447] calling  erst_init+0x0/0x4c7 @ 1
[   12.338377] initcall erst_init+0x0/0x4c7 returned 0 after 19 usecs
[   12.345211] calling  gpio_clk_driver_init+0x0/0x17 @ 1
[   12.351045] initcall gpio_clk_driver_init+0x0/0x17 returned 0 after 51 usecs
[   12.358720] calling  plt_clk_driver_init+0x0/0x17 @ 1
[   12.364451] initcall plt_clk_driver_init+0x0/0x17 returned 0 after 33 usecs
[   12.372040] calling  dw_pci_driver_init+0x0/0x1e @ 1
[   12.377737] initcall dw_pci_driver_init+0x0/0x1e returned 0 after 97 usecs
[   12.385254] calling  virtio_pci_driver_init+0x0/0x1e @ 1
[   12.391261] initcall virtio_pci_driver_init+0x0/0x1e returned 0 after 50 usecs
[   12.399107] calling  n_null_init+0x0/0x1e @ 1
[   12.404106] initcall n_null_init+0x0/0x1e returned 0 after 0 usecs
[   12.410925] calling  pty_init+0x0/0x11 @ 1
[   12.415818] initcall pty_init+0x0/0x11 returned 0 after 151 usecs
[   12.422558] calling  sysrq_init+0x0/0x4e @ 1
[   12.427489] initcall sysrq_init+0x0/0x4e returned 0 after 17 usecs
[   12.434304] calling  serial8250_init+0x0/0x31b @ 1
[   12.439745] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   12.446817] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   12.455836] initcall serial8250_init+0x0/0x31b returned 0 after 16091 usecs
[   12.463433] calling  serial_pci_driver_init+0x0/0x1e @ 1
[   12.469447] initcall serial_pci_driver_init+0x0/0x1e returned 0 after 68 usecs
[   12.477296] calling  exar_pci_driver_init+0x0/0x1e @ 1
[   12.483118] initcall exar_pci_driver_init+0x0/0x1e returned 0 after 52 usecs
[   12.490780] calling  dw8250_platform_driver_init+0x0/0x17 @ 1
[   12.497208] initcall dw8250_platform_driver_init+0x0/0x17 returned 0 after 44 usecs
[   12.505481] calling  lpss8250_pci_driver_init+0x0/0x1e @ 1
[   12.511654] initcall lpss8250_pci_driver_init+0x0/0x1e returned 0 after 44 usecs
[   12.519674] calling  mid8250_pci_driver_init+0x0/0x1e @ 1
[   12.525769] initcall mid8250_pci_driver_init+0x0/0x1e returned 0 after 64 usecs
[   12.533710] calling  pericom8250_pci_driver_init+0x0/0x1e @ 1
[   12.540144] initcall pericom8250_pci_driver_init+0x0/0x1e returned 0 after 59 usecs
[   12.548418] calling  random_sysctls_init+0x0/0x26 @ 1
[   12.554128] initcall random_sysctls_init+0x0/0x26 returned 0 after 22 usecs
[   12.561725] calling  hpet_init+0x0/0x76 @ 1
[   12.567533] initcall hpet_init+0x0/0x76 returned 0 after 981 usecs
[   12.574355] calling  nvram_module_init+0x0/0x8d @ 1
[   12.580044] Non-volatile memory driver v1.3
[   12.584890] initcall nvram_module_init+0x0/0x8d returned 0 after 5019 usecs
[   12.592480] calling  virtio_rng_driver_init+0x0/0x15 @ 1
[   12.598508] initcall virtio_rng_driver_init+0x0/0x15 returned 0 after 82 usecs
[   12.606362] calling  init_tis+0x0/0x14e @ 1
[   12.611254] initcall init_tis+0x0/0x14e returned 0 after 64 usecs
[   12.617973] calling  crb_acpi_driver_init+0x0/0x15 @ 1
[   12.623836] initcall crb_acpi_driver_init+0x0/0x15 returned 0 after 80 usecs
[   12.631499] calling  cn_proc_init+0x0/0x3e @ 1
[   12.636606] initcall cn_proc_init+0x0/0x3e returned 0 after 13 usecs
[   12.643576] calling  topology_sysfs_init+0x0/0x30 @ 1
[   12.649621] initcall topology_sysfs_init+0x0/0x30 returned 0 after 347 usecs
[   12.657280] calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
[   12.665041] initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 1967 usecs
[   12.672893] calling  devcoredump_init+0x0/0x1c @ 1
[   12.678371] initcall devcoredump_init+0x0/0x1c returned 0 after 50 usecs
[   12.685709] calling  lpc_ich_driver_init+0x0/0x1e @ 1
[   12.691643] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20221020/utaddress-204)
[   12.707659] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   12.715253] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20221020/utaddress-204)
[   12.731180] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   12.738757] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20221020/utaddress-204)
[   12.754759] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20221020/utaddress-204)
[   12.770671] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   12.778277] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20221020/utaddress-204)
[   12.794307] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20221020/utaddress-204)
[   12.810224] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   12.817797] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   12.824834] initcall lpc_ich_driver_init+0x0/0x1e returned 0 after 133438 usecs
[   12.832761] calling  intel_lpss_init+0x0/0x21 @ 1
[   12.838116] initcall intel_lpss_init+0x0/0x21 returned 0 after 10 usecs
[   12.845351] calling  intel_lpss_pci_driver_init+0x0/0x1e @ 1
[   12.851734] initcall intel_lpss_pci_driver_init+0x0/0x1e returned 0 after 96 usecs
[   12.859932] calling  intel_lpss_acpi_driver_init+0x0/0x17 @ 1
[   12.866358] initcall intel_lpss_acpi_driver_init+0x0/0x17 returned 0 after 50 usecs
[   12.874631] calling  mac_hid_init+0x0/0x2d @ 1
[   12.879734] initcall mac_hid_init+0x0/0x2d returned 0 after 19 usecs
[   12.886721] calling  rdac_init+0x0/0x79 @ 1
[   12.891559] rdac: device handler registered
[   12.896598] initcall rdac_init+0x0/0x79 returned 0 after 5039 usecs
[   12.903511] calling  hp_sw_init+0x0/0x15 @ 1
[   12.908427] hp_sw: device handler registered
[   12.913350] initcall hp_sw_init+0x0/0x15 returned 0 after 4923 usecs
[   12.920345] calling  clariion_init+0x0/0x37 @ 1
[   12.925517] emc: device handler registered
[   12.930279] initcall clariion_init+0x0/0x37 returned 0 after 4762 usecs
[   12.937522] calling  alua_init+0x0/0x68 @ 1
[   12.942529] alua: device handler registered
[   12.947384] initcall alua_init+0x0/0x68 returned 0 after 5024 usecs
[   12.954286] calling  blackhole_netdev_init+0x0/0xcf @ 1
[   12.960187] initcall blackhole_netdev_init+0x0/0xcf returned 0 after 43 usecs
[   12.967938] calling  phylink_init+0x0/0xaf @ 1
[   12.973034] initcall phylink_init+0x0/0xaf returned 0 after 0 usecs
[   12.979932] calling  phy_module_init+0x0/0x1c @ 1
[   12.985380] initcall phy_module_init+0x0/0x1c returned 0 after 94 usecs
[   12.992626] calling  fixed_mdio_bus_init+0x0/0x245 @ 1
[   12.998896] initcall fixed_mdio_bus_init+0x0/0x245 returned 0 after 498 usecs
[   13.006657] calling  phy_module_init+0x0/0x1c @ 1
[   13.012425] initcall phy_module_init+0x0/0x1c returned 0 after 415 usecs
[   13.019754] calling  cavium_ptp_driver_init+0x0/0x1e @ 1
[   13.025766] initcall cavium_ptp_driver_init+0x0/0x1e returned 0 after 66 usecs
[   13.033622] calling  e1000_init_module+0x0/0x7b @ 1
[   13.039138] e1000: Intel(R) PRO/1000 Network Driver
[   13.044660] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   13.051111] initcall e1000_init_module+0x0/0x7b returned 0 after 11973 usecs
[   13.058785] calling  e1000_init_module+0x0/0x36 @ 1
[   13.064298] e1000e: Intel(R) PRO/1000 Network Driver
[   13.069902] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   13.077692] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   13.091730] IOAPIC[0]: Preconfigured routing entry (8-20 -> IRQ 20 Level:1 ActiveLow:1)
[   13.100523] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   13.182058] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[   13.255421] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) f8:b1:56:e3:03:ca
[   13.263963] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   13.271521] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
[   13.279780] e1000e 0000:04:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   13.330948] e1000e 0000:04:00.0 0000:04:00.0 (uninitialized): registered PHC clock
[   13.386078] e1000e 0000:04:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 2c:53:4a:03:93:bf
[   13.394615] e1000e 0000:04:00.0 eth1: Intel(R) PRO/1000 Network Connection
[   13.402126] e1000e 0000:04:00.0 eth1: MAC: 3, PHY: 8, PBA No: FFFFFF-0FF
[   13.409513] initcall e1000_init_module+0x0/0x36 returned 0 after 345214 usecs
[   13.417277] calling  igb_init_module+0x0/0x44 @ 1
[   13.422630] igb: Intel(R) Gigabit Ethernet Network Driver
[   13.428658] igb: Copyright (c) 2007-2014 Intel Corporation.
[   13.434929] initcall igb_init_module+0x0/0x44 returned 0 after 12308 usecs
[   13.442431] calling  igc_init_module+0x0/0x44 @ 1
[   13.447786] Intel(R) 2.5G Ethernet Linux Driver
[   13.452959] Copyright(c) 2018 Intel Corporation.
[   13.458329] initcall igc_init_module+0x0/0x44 returned 0 after 10542 usecs
[   13.465839] calling  ixgbe_init_module+0x0/0xad @ 1
[   13.471374] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[   13.478085] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   13.484758] initcall ixgbe_init_module+0x0/0xad returned 0 after 13383 usecs
[   13.492442] calling  i40e_init_module+0x0/0xb8 @ 1
[   13.497871] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[   13.504768] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   13.511460] initcall i40e_init_module+0x0/0xb8 returned 0 after 13588 usecs
[   13.519054] calling  rtl8169_pci_driver_init+0x0/0x1e @ 1
[   13.525136] initcall rtl8169_pci_driver_init+0x0/0x1e returned 0 after 40 usecs
[   13.533071] calling  rtl8152_driver_init+0x0/0x1e @ 1
[   13.538822] usbcore: registered new interface driver r8152
[   13.544953] initcall rtl8152_driver_init+0x0/0x1e returned 0 after 6193 usecs
[   13.552716] calling  asix_driver_init+0x0/0x1e @ 1
[   13.558232] usbcore: registered new interface driver asix
[   13.564263] initcall asix_driver_init+0x0/0x1e returned 0 after 6115 usecs
[   13.571754] calling  ax88179_178a_driver_init+0x0/0x1e @ 1
[   13.577897] usbcore: registered new interface driver ax88179_178a
[   13.584611] initcall ax88179_178a_driver_init+0x0/0x1e returned 0 after 6743 usecs
[   13.592789] calling  usbnet_init+0x0/0x2f @ 1
[   13.597788] initcall usbnet_init+0x0/0x2f returned 0 after 0 usecs
[   13.604589] calling  usbport_trig_init+0x0/0x15 @ 1
[   13.610132] initcall usbport_trig_init+0x0/0x15 returned 0 after 29 usecs
[   13.617545] calling  mon_init+0x0/0x198 @ 1
[   13.622599] initcall mon_init+0x0/0x198 returned 0 after 217 usecs
[   13.629419] calling  ehci_hcd_init+0x0/0x1a0 @ 1
[   13.634694] initcall ehci_hcd_init+0x0/0x1a0 returned 0 after 18 usecs
[   13.641852] calling  ehci_pci_init+0x0/0x56 @ 1
[   13.647119] initcall ehci_pci_init+0x0/0x56 returned 0 after 97 usecs
[   13.649369] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   13.654185] calling  ohci_hcd_mod_init+0x0/0xa9 @ 1
[   13.668201] IOAPIC[0]: Preconfigured routing entry (8-23 -> IRQ 23 Level:1 ActiveLow:1)
[   13.673727] initcall ohci_hcd_mod_init+0x0/0xa9 returned 0 after 13 usecs
[   13.682410] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   13.689718] calling  ohci_pci_init+0x0/0x56 @ 1
[   13.695839] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   13.700785] initcall ohci_pci_init+0x0/0x56 returned 0 after 56 usecs
[   13.708796] ehci-pci 0000:00:1d.0: debug port 2
[   13.715816] calling  uhci_hcd_init+0x0/0x12f @ 1
[   13.724998] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d3b000
[   13.726355] initcall uhci_hcd_init+0x0/0x12f returned 0 after 97 usecs
[   13.739186] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   13.739704] calling  xhci_hcd_init+0x0/0x28 @ 1
[   13.746381] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.02
[   13.751262] initcall xhci_hcd_init+0x0/0x28 returned 0 after 6 usecs
[   13.760115] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   13.767082] calling  xhci_pci_init+0x0/0x5d @ 1
[   13.774906] usb usb1: Product: EHCI Host Controller
[   13.780153] initcall xhci_pci_init+0x0/0x5d returned 0 after 77 usecs
[   13.785583] usb usb1: Manufacturer: Linux 6.2.0-rc1-00001-gcc3ff324b29f ehci_hcd
[   13.792649] calling  ucsi_acpi_platform_driver_init+0x0/0x17 @ 1
[   13.800659] usb usb1: SerialNumber: 0000:00:1d.0
[   13.807374] initcall ucsi_acpi_platform_driver_init+0x0/0x17 returned 0 after 80 usecs
[   13.813300] hub 1-0:1.0: USB hub found
[   13.821545] calling  i8042_init+0x0/0x139 @ 1
[   13.825541] hub 1-0:1.0: 2 ports detected
[   13.831259] i8042: PNP: No PS/2 controller found.
[   13.837068] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   13.840496] initcall i8042_init+0x0/0x139 returned 0 after 10005 usecs
[   13.846605] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 2
[   13.853516] calling  serport_init+0x0/0x30 @ 1
[   13.861571] ehci-pci 0000:00:1a.0: debug port 2
[   13.866627] initcall serport_init+0x0/0x30 returned 0 after 0 usecs
[   13.875780] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7d3c000
[   13.878691] calling  input_leds_init+0x0/0x15 @ 1
[   13.890495] initcall input_leds_init+0x0/0x15 returned 0 after 21 usecs
[   13.891205] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   13.897733] calling  mousedev_init+0x0/0x63 @ 1
[   13.904423] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.02
[   13.909488] mousedev: PS/2 mouse device common for all mice
[   13.918173] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   13.918177] usb usb2: Product: EHCI Host Controller
[   13.924373] initcall mousedev_init+0x0/0x63 returned 0 after 15085 usecs
[   13.932210] usb usb2: Manufacturer: Linux 6.2.0-rc1-00001-gcc3ff324b29f ehci_hcd
[   13.937727] calling  evdev_init+0x0/0x15 @ 1
[   13.945051] usb usb2: SerialNumber: 0000:00:1a.0
[   13.953391] initcall evdev_init+0x0/0x15 returned 0 after 331 usecs
[   13.958677] hub 2-0:1.0: USB hub found
[   13.963266] calling  atkbd_init+0x0/0x2a @ 1
[   13.970236] hub 2-0:1.0: 2 ports detected
[   13.974682] initcall atkbd_init+0x0/0x2a returned 0 after 131 usecs
[   13.981370] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   13.984143] calling  psmouse_init+0x0/0x8a @ 1
[   13.984277] initcall psmouse_init+0x0/0x8a returned 0 after 131 usecs
[   13.991304] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[   13.996909] calling  cmos_init+0x0/0x74 @ 1
[   13.996975] rtc_cmos 00:02: RTC can wake from S4
[   14.003191] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[   14.009983] rtc_cmos 00:02: registered as rtc0
[   14.017948] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   14.022017] rtc_cmos 00:02: setting system clock to 2023-01-21T13:09:35 UTC (1674306575)
[   14.027403] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[   14.037109] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[   14.042024] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   14.047957] initcall cmos_init+0x0/0x74 returned 0 after 51044 usecs
[   14.056758] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.02
[   14.064569] calling  smbalert_driver_init+0x0/0x17 @ 1
[   14.072827] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.079736] initcall smbalert_driver_init+0x0/0x17 returned 0 after 26 usecs
[   14.086679] usb usb3: Product: xHCI Host Controller
[   14.086681] usb usb3: Manufacturer: Linux 6.2.0-rc1-00001-gcc3ff324b29f xhci-hcd
[   14.086683] usb usb3: SerialNumber: 0000:00:14.0
[   14.087395] hub 3-0:1.0: USB hub found
[   14.089196] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   14.095555] calling  i2c_i801_init+0x0/0x11f @ 1
[   14.101425] hub 3-0:1.0: 15 ports detected
[   14.109271] initcall i2c_i801_init+0x0/0x11f returned 0 after 90 usecs
[   14.111048] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[   14.111181] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   14.177471] calling  thermal_throttle_init_device+0x0/0x53 @ 1
[   14.184449] initcall thermal_throttle_init_device+0x0/0x53 returned 0 after 492 usecs
[   14.192925] calling  esb_driver_init+0x0/0x1e @ 1
[   14.198349] initcall esb_driver_init+0x0/0x1e returned 0 after 53 usecs
[   14.205593] calling  iTCO_wdt_driver_init+0x0/0x17 @ 1
[   14.211474] iTCO_wdt iTCO_wdt.0.auto: Found a Lynx Point TCO device (Version=2, TCOBASE=0x1860)
[   14.220817] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   14.221352] iTCO_wdt iTCO_wdt.0.auto: initialized. heartbeat=30 sec (nowayout=0)
[   14.236073] initcall iTCO_wdt_driver_init+0x0/0x17 returned 0 after 24707 usecs
[   14.244013] calling  iTCO_vendor_init_module+0x0/0x35 @ 1
[   14.250046] iTCO_vendor_support: vendor-support=0
[   14.255407] initcall iTCO_vendor_init_module+0x0/0x35 returned 0 after 5360 usecs
[   14.263506] calling  ghes_edac_init+0x0/0xf4 @ 1
[   14.268763] initcall ghes_edac_init+0x0/0xf4 returned -19 after 1 usecs
[   14.276005] calling  intel_pstate_init+0x0/0x4ba @ 1
[   14.281637] intel_pstate: Intel P-state driver initializing
[   14.282687] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.02
[   14.287866] usb 1-1: New USB device found, idVendor=8087, idProduct=8000, bcdDevice= 0.04
[   14.296699] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.296704] usb usb4: Product: xHCI Host Controller
[   14.305479] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   14.307103] hub 1-1:1.0: USB hub found
[   14.308342] i2c i2c-0: 4/4 memory slots populated (from DMI)
[   14.308734] i2c i2c-0: Successfully instantiated SPD at 0x50
[   14.309107] i2c i2c-0: Successfully instantiated SPD at 0x51
[   14.309515] i2c i2c-0: Successfully instantiated SPD at 0x52
[   14.309919] i2c i2c-0: Successfully instantiated SPD at 0x53
[   14.313334] usb usb4: Manufacturer: Linux 6.2.0-rc1-00001-gcc3ff324b29f xhci-hcd
[   14.313336] usb usb4: SerialNumber: 0000:00:14.0
[   14.314264] hub 4-0:1.0: USB hub found
[   14.319355] hub 1-1:1.0: 8 ports detected
[   14.326997] hub 4-0:1.0: 6 ports detected
[   14.327638] initcall intel_pstate_init+0x0/0x4ba returned 0 after 46012 usecs
[   14.327649] calling  haltpoll_init+0x0/0xf3 @ 1
[   14.327654] initcall haltpoll_init+0x0/0xf3 returned -19 after 0 usecs
[   14.327660] calling  dmi_sysfs_init+0x0/0x14c @ 1
[   14.332437] initcall dmi_sysfs_init+0x0/0x14c returned 0 after 4773 usecs
[   14.422635] calling  fw_cfg_sysfs_init+0x0/0x8a @ 1
[   14.428288] initcall fw_cfg_sysfs_init+0x0/0x8a returned 0 after 132 usecs
[   14.435804] calling  sysfb_init+0x0/0x122 @ 1
[   14.440919] initcall sysfb_init+0x0/0x122 returned 0 after 109 usecs
[   14.442635] usb 2-1: New USB device found, idVendor=8087, idProduct=8008, bcdDevice= 0.04
[   14.447911] calling  esrt_sysfs_init+0x0/0x446 @ 1
[   14.456680] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   14.462134] initcall esrt_sysfs_init+0x0/0x446 returned -38 after 0 usecs
[   14.471126] hub 2-1:1.0: USB hub found
[   14.477276] calling  efivars_pstore_init+0x0/0x9d @ 1
[   14.477282] initcall efivars_pstore_init+0x0/0x9d returned 0 after 0 usecs
[   14.481878] hub 2-1:1.0: 6 ports detected
[   14.487370] calling  hid_init+0x0/0x66 @ 1
[   14.487676] hid: raw HID events driver (C) Jiri Kosina
[   14.510146] initcall hid_init+0x0/0x66 returned 0 after 22772 usecs
[   14.517053] calling  hid_generic_init+0x0/0x1e @ 1
[   14.522545] initcall hid_generic_init+0x0/0x1e returned 0 after 51 usecs
[   14.529876] calling  magicmouse_driver_init+0x0/0x1e @ 1
[   14.535876] initcall magicmouse_driver_init+0x0/0x1e returned 0 after 48 usecs
[   14.543724] calling  sensor_hub_driver_init+0x0/0x1e @ 1
[   14.549728] initcall sensor_hub_driver_init+0x0/0x1e returned 0 after 50 usecs
[   14.557576] calling  hid_init+0x0/0x62 @ 1
[   14.562387] usbcore: registered new interface driver usbhid
[   14.568604] usbhid: USB HID core driver
[   14.573096] initcall hid_init+0x0/0x62 returned 0 after 10760 usecs
[   14.579996] calling  pmc_atom_init+0x0/0x73 @ 1
[   14.585187] initcall pmc_atom_init+0x0/0x73 returned -19 after 9 usecs
[   14.592354] calling  sock_diag_init+0x0/0x33 @ 1
[   14.597667] initcall sock_diag_init+0x0/0x33 returned 0 after 55 usecs
[   14.604825] calling  init_net_drop_monitor+0x0/0x33f @ 1
[   14.610766] drop_monitor: Initializing network drop monitor service
[   14.617729] initcall init_net_drop_monitor+0x0/0x33f returned 0 after 6963 usecs
[   14.625746] calling  blackhole_init+0x0/0x15 @ 1
[   14.631014] initcall blackhole_init+0x0/0x15 returned 0 after 11 usecs
[   14.638173] calling  fq_codel_module_init+0x0/0x15 @ 1
[   14.643954] initcall fq_codel_module_init+0x0/0x15 returned 0 after 0 usecs
[   14.651537] calling  init_cgroup_cls+0x0/0x15 @ 1
[   14.656877] initcall init_cgroup_cls+0x0/0x15 returned 0 after 0 usecs
[   14.664033] calling  xt_init+0x0/0x29e @ 1
[   14.668826] initcall xt_init+0x0/0x29e returned 0 after 44 usecs
[   14.675476] calling  tcpudp_mt_init+0x0/0x1a @ 1
[   14.680744] initcall tcpudp_mt_init+0x0/0x1a returned 0 after 11 usecs
[   14.687893] calling  gre_offload_init+0x0/0x52 @ 1
[   14.693343] initcall gre_offload_init+0x0/0x52 returned 0 after 0 usecs
[   14.700575] calling  sysctl_ipv4_init+0x0/0x50 @ 1
[   14.706102] initcall sysctl_ipv4_init+0x0/0x50 returned 0 after 88 usecs
[   14.713429] calling  cubictcp_register+0x0/0x72 @ 1
[   14.718954] initcall cubictcp_register+0x0/0x72 returned 0 after 11 usecs
[   14.726358] calling  xfrm_user_init+0x0/0x34 @ 1
[   14.731622] Initializing XFRM netlink socket
[   14.736571] initcall xfrm_user_init+0x0/0x34 returned 0 after 4949 usecs
[   14.743898] calling  inet6_init+0x0/0x4be @ 1
[   14.749019] NET: Registered PF_INET6 protocol family
[   14.755743] Segment Routing with IPv6
[   14.760112] In-situ OAM (IOAM) with IPv6
[   14.764746] initcall inet6_init+0x0/0x4be returned 0 after 15838 usecs
[   14.771905] calling  packet_init+0x0/0x83 @ 1
[   14.776922] NET: Registered PF_PACKET protocol family
[   14.782603] initcall packet_init+0x0/0x83 returned 0 after 5698 usecs
[   14.789674] calling  strp_dev_init+0x0/0x37 @ 1
[   14.795036] initcall strp_dev_init+0x0/0x37 returned 0 after 181 usecs
[   14.802209] calling  init_p9+0x0/0x2e @ 1
[   14.806918] 9pnet: Installing 9P2000 support
[   14.811842] initcall init_p9+0x0/0x2e returned 0 after 4965 usecs
[   14.818559] calling  p9_trans_fd_init+0x0/0x30 @ 1
[   14.823999] initcall p9_trans_fd_init+0x0/0x30 returned 0 after 0 usecs
[   14.831250] calling  p9_virtio_init+0x0/0x52 @ 1
[   14.836571] initcall p9_virtio_init+0x0/0x52 returned 0 after 64 usecs
[   14.843725] calling  dcbnl_init+0x0/0x54 @ 1
[   14.848646] initcall dcbnl_init+0x0/0x54 returned 0 after 7 usecs
[   14.855363] calling  mpls_gso_init+0x0/0x30 @ 1
[   14.860533] mpls_gso: MPLS GSO support
[   14.864930] initcall mpls_gso_init+0x0/0x30 returned 0 after 4397 usecs
[   14.872167] calling  nsh_init_module+0x0/0x18 @ 1
[   14.877515] initcall nsh_init_module+0x0/0x18 returned 0 after 0 usecs
[   14.884659] calling  pm_check_save_msr+0x0/0x70 @ 1
[   14.890220] initcall pm_check_save_msr+0x0/0x70 returned 0 after 45 usecs
[   14.897642] calling  mcheck_init_device+0x0/0x1eb @ 1
[   14.904743] initcall mcheck_init_device+0x0/0x1eb returned 0 after 1402 usecs
[   14.912518] calling  dev_mcelog_init_device+0x0/0x171 @ 1
[   14.918683] initcall dev_mcelog_init_device+0x0/0x171 returned 0 after 133 usecs
[   14.926946] calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x26 @ 1
[   14.934111] initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x26 returned 0 after 17 usecs
[   14.943148] calling  tboot_late_init+0x0/0x22f @ 1
[   14.948587] initcall tboot_late_init+0x0/0x22f returned 0 after 0 usecs
[   14.955828] calling  sld_mitigate_sysctl_init+0x0/0x26 @ 1
[   14.961965] initcall sld_mitigate_sysctl_init+0x0/0x26 returned 0 after 15 usecs
[   14.969970] calling  mcheck_late_init+0x0/0x41 @ 1
[   14.975435] initcall mcheck_late_init+0x0/0x41 returned 0 after 26 usecs
[   14.982760] calling  severities_debugfs_init+0x0/0x2e @ 1
[   14.988815] initcall severities_debugfs_init+0x0/0x2e returned 0 after 17 usecs
[   14.996733] calling  microcode_init+0x0/0x246 @ 1
[   15.002288] microcode: Microcode Update Driver: v2.2.
[   15.002291] initcall microcode_init+0x0/0x246 returned 0 after 205 usecs
[   15.015342] calling  hpet_insert_resource+0x0/0x27 @ 1
[   15.021125] initcall hpet_insert_resource+0x0/0x27 returned 0 after 12 usecs
[   15.028784] calling  start_sync_check_timer+0x0/0xae @ 1
[   15.034728] initcall start_sync_check_timer+0x0/0xae returned 0 after 0 usecs
[   15.042472] calling  update_mp_table+0x0/0x575 @ 1
[   15.047899] initcall update_mp_table+0x0/0x575 returned 0 after 0 usecs
[   15.055130] calling  lapic_insert_resource+0x0/0x47 @ 1
[   15.060985] initcall lapic_insert_resource+0x0/0x47 returned -1 after 0 usecs
[   15.068730] calling  print_ipi_mode+0x0/0x31 @ 1
[   15.073987] IPI shorthand broadcast: enabled
[   15.078897] initcall print_ipi_mode+0x0/0x31 returned 0 after 4910 usecs
[   15.086216] calling  print_ICs+0x0/0x1d7 @ 1
[   15.091164] ... APIC ID:      00000000 (0)
[   15.092161] ... APIC VERSION: 01060015
[   15.092161] 0000000000000000000000000000000000000000000000000000000000000000
[   15.092161] 0000000000000000000000000000000000000000000000000000000000000000
[   15.092161] 0000000000000000000000000000000000000000000000000000000000001000

[   15.125460] number of MP IRQ sources: 15.
[   15.130115] number of IO-APIC #8 registers: 24.
[   15.135284] testing the IO APIC.......................
[   15.141056] IO APIC #8......
[   15.144596] .... register #00: 08000000
[   15.149076] .......    : physical APIC id: 08
[   15.154072] .......    : Delivery Type: 0
[   15.158722] .......    : LTS          : 0
[   15.163376] .... register #01: 00170020
[   15.167856] .......     : max redirection entries: 17
[   15.173539] .......     : PRQ implemented: 0
[   15.178449] .......     : IO APIC version: 20
[   15.183458] .... IRQ redirection table:
[   15.187942] IOAPIC 0:
[   15.190882]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.199490]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.208097]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(0)
[   15.216790]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.225397]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.234008]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.242615]  pin06, disabled, edge , high, V(DF), IRR(0), S(0), logical , D(659E), M(2)
[   15.251235]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.259843]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped, I(0007),  Z(0)
[   15.268537]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped, I(0008),  Z(0)
[   15.277233]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.285841]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.294448]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.303066]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.311686]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.320295]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.328904]  pin10, enabled , level, low , V(10), IRR(0), S(0), remapped, I(000F),  Z(0)
[   15.337598]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.346218]  pin12, enabled , level, low , V(12), IRR(0), S(0), remapped, I(0013),  Z(0)
[   15.354912]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.363521]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.372129]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.380737]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
[   15.389343]  pin17, enabled , level, low , V(17), IRR(0), S(0), remapped, I(001A),  Z(0)
[   15.398035] IRQ to pin mappings:
[   15.401921] IRQ0 -> 0:2
[   15.405034] IRQ1 -> 0:1
[   15.408145] IRQ3 -> 0:3
[   15.411268] IRQ4 -> 0:4
[   15.414376] IRQ5 -> 0:5
[   15.417488] IRQ6 -> 0:6
[   15.420599] IRQ7 -> 0:7
[   15.423707] IRQ8 -> 0:8
[   15.426819] IRQ9 -> 0:9
[   15.429930] IRQ10 -> 0:10
[   15.433219] IRQ11 -> 0:11
[   15.436501] IRQ12 -> 0:12
[   15.439784] IRQ13 -> 0:13
[   15.443077] IRQ14 -> 0:14
[   15.446359] IRQ15 -> 0:15
[   15.449642] IRQ16 -> 0:16
[   15.452926] IRQ17 -> 0:17
[   15.456216] IRQ18 -> 0:18
[   15.459499] IRQ20 -> 0:20
[   15.462780] IRQ23 -> 0:23
[   15.466062] .................................... done.
[   15.471831] initcall print_ICs+0x0/0x1d7 returned 0 after 380703 usecs
[   15.478992] calling  setup_efi_kvm_sev_migration+0x0/0x28c @ 1
[   15.485452] initcall setup_efi_kvm_sev_migration+0x0/0x28c returned 0 after 0 usecs
[   15.493720] calling  create_tlb_single_page_flush_ceiling+0x0/0x53 @ 1
[   15.500907] initcall create_tlb_single_page_flush_ceiling+0x0/0x53 returned 0 after 39 usecs
[   15.509960] calling  pat_memtype_list_init+0x0/0x5c @ 1
[   15.515831] initcall pat_memtype_list_init+0x0/0x5c returned 0 after 9 usecs
[   15.523497] calling  create_init_pkru_value+0x0/0x58 @ 1
[   15.529445] initcall create_init_pkru_value+0x0/0x58 returned 0 after 0 usecs
[   15.537206] calling  aesni_init+0x0/0x223 @ 1
[   15.542228] AVX2 version of gcm_enc/dec engaged.
[   15.547583] AES CTR mode by8 optimization enabled
[   15.553009] initcall aesni_init+0x0/0x223 returned 0 after 10780 usecs
[   15.560161] calling  kernel_panic_sysctls_init+0x0/0x26 @ 1
[   15.566391] initcall kernel_panic_sysctls_init+0x0/0x26 returned 0 after 9 usecs
[   15.574400] calling  kernel_panic_sysfs_init+0x0/0x47 @ 1
[   15.580451] initcall kernel_panic_sysfs_init+0x0/0x47 returned 0 after 20 usecs
[   15.588376] calling  kernel_exit_sysctls_init+0x0/0x26 @ 1
[   15.594506] initcall kernel_exit_sysctls_init+0x0/0x26 returned 0 after 12 usecs
[   15.602513] calling  kernel_exit_sysfs_init+0x0/0x47 @ 1
[   15.608465] initcall kernel_exit_sysfs_init+0x0/0x47 returned 0 after 7 usecs
[   15.616215] calling  param_sysfs_builtin_init+0x0/0x96 @ 1
[   15.635356] initcall param_sysfs_builtin_init+0x0/0x96 returned 0 after 13022 usecs
[   15.643630] calling  reboot_ksysfs_init+0x0/0x94 @ 1
[   15.649259] initcall reboot_ksysfs_init+0x0/0x94 returned 0 after 25 usecs
[   15.656761] calling  sched_core_sysctl_init+0x0/0x2b @ 1
[   15.662726] initcall sched_core_sysctl_init+0x0/0x2b returned 0 after 8 usecs
[   15.670487] calling  sched_fair_sysctl_init+0x0/0x26 @ 1
[   15.676450] initcall sched_fair_sysctl_init+0x0/0x26 returned 0 after 8 usecs
[   15.684205] calling  sched_rt_sysctl_init+0x0/0x26 @ 1
[   15.690009] initcall sched_rt_sysctl_init+0x0/0x26 returned 0 after 7 usecs
[   15.697599] calling  sched_dl_sysctl_init+0x0/0x26 @ 1
[   15.703391] initcall sched_dl_sysctl_init+0x0/0x26 returned 0 after 7 usecs
[   15.710983] calling  sched_clock_init_late+0x0/0xd2 @ 1
[   15.716857] sched_clock: Marking stable (15132372250, 584467424)->(16318257571, -601417897)
[   15.725892] initcall sched_clock_init_late+0x0/0xd2 returned 0 after 9035 usecs
[   15.733841] calling  sched_init_debug+0x0/0x255 @ 1
[   15.740253] initcall sched_init_debug+0x0/0x255 returned 0 after 880 usecs
[   15.747760] calling  cpu_latency_qos_init+0x0/0x3e @ 1
[   15.753691] initcall cpu_latency_qos_init+0x0/0x3e returned 0 after 145 usecs
[   15.761655] calling  pm_debugfs_init+0x0/0x28 @ 1
[   15.767011] initcall pm_debugfs_init+0x0/0x28 returned 0 after 8 usecs
[   15.774161] calling  printk_late_init+0x0/0x22d @ 1
[   15.779704] initcall printk_late_init+0x0/0x22d returned 0 after 25 usecs
[   15.787129] calling  init_srcu_module_notifier+0x0/0x30 @ 1
[   15.793344] initcall init_srcu_module_notifier+0x0/0x30 returned 0 after 1 usecs
[   15.801363] calling  swiotlb_create_default_debugfs+0x0/0x6c @ 1
[   15.808047] initcall swiotlb_create_default_debugfs+0x0/0x6c returned 0 after 36 usecs
[   15.816580] calling  tk_debug_sleep_time_init+0x0/0x28 @ 1
[   15.822713] initcall tk_debug_sleep_time_init+0x0/0x28 returned 0 after 6 usecs
[   15.830647] calling  bpf_ksym_iter_register+0x0/0x1f @ 1
[   15.836608] initcall bpf_ksym_iter_register+0x0/0x1f returned 0 after 3 usecs
[   15.844371] calling  kernel_acct_sysctls_init+0x0/0x26 @ 1
[   15.850512] initcall kernel_acct_sysctls_init+0x0/0x26 returned 0 after 7 usecs
[   15.858449] calling  kexec_core_sysctl_init+0x0/0x26 @ 1
[   15.864414] initcall kexec_core_sysctl_init+0x0/0x26 returned 0 after 7 usecs
[   15.872198] calling  bpf_rstat_kfunc_init+0x0/0x1a @ 1
[   15.877991] initcall bpf_rstat_kfunc_init+0x0/0x1a returned 0 after 0 usecs
[   15.885583] calling  debugfs_kprobe_init+0x0/0x78 @ 1
[   15.891317] initcall debugfs_kprobe_init+0x0/0x78 returned 0 after 34 usecs
[   15.898911] calling  kernel_delayacct_sysctls_init+0x0/0x26 @ 1
[   15.905493] initcall kernel_delayacct_sysctls_init+0x0/0x26 returned 0 after 7 usecs
[   15.913866] calling  taskstats_init+0x0/0x3f @ 1
[   15.919190] registered taskstats version 1
[   15.923941] initcall taskstats_init+0x0/0x3f returned 0 after 4803 usecs
[   15.931275] calling  ftrace_sysctl_init+0x0/0x21 @ 1
[   15.936896] initcall ftrace_sysctl_init+0x0/0x21 returned 0 after 6 usecs
[   15.944317] calling  init_hwlat_tracer+0x0/0x116 @ 1
[   15.950372] initcall init_hwlat_tracer+0x0/0x116 returned 0 after 437 usecs
[   15.957972] calling  bpf_key_sig_kfuncs_init+0x0/0x15 @ 1
[   15.964016] initcall bpf_key_sig_kfuncs_init+0x0/0x15 returned 0 after 0 usecs
[   15.971865] calling  bpf_global_ma_init+0x0/0x23 @ 1
[   15.977857] initcall bpf_global_ma_init+0x0/0x23 returned 0 after 374 usecs
[   15.985459] calling  bpf_syscall_sysctl_init+0x0/0x26 @ 1
[   15.991514] initcall bpf_syscall_sysctl_init+0x0/0x26 returned 0 after 9 usecs
[   15.999374] calling  kfunc_init+0x0/0xf8 @ 1
[   16.004303] initcall kfunc_init+0x0/0xf8 returned 0 after 0 usecs
[   16.011037] calling  bpf_map_iter_init+0x0/0x30 @ 1
[   16.016570] initcall bpf_map_iter_init+0x0/0x30 returned 0 after 15 usecs
[   16.023992] calling  task_iter_init+0x0/0x2d5 @ 1
[   16.029362] initcall task_iter_init+0x0/0x2d5 returned 0 after 11 usecs
[   16.036627] calling  bpf_prog_iter_init+0x0/0x1f @ 1
[   16.042284] initcall bpf_prog_iter_init+0x0/0x1f returned 0 after 17 usecs
[   16.047814] Freeing initrd memory: 278544K
[   16.049783] calling  bpf_link_iter_init+0x0/0x1f @ 1
[   16.060149] initcall bpf_link_iter_init+0x0/0x1f returned 0 after 4 usecs
[   16.067553] calling  init_trampolines+0x0/0x6a @ 1
[   16.073001] initcall init_trampolines+0x0/0x6a returned 0 after 1 usecs
[   16.080235] calling  bpf_cgroup_iter_init+0x0/0x21 @ 1
[   16.086015] initcall bpf_cgroup_iter_init+0x0/0x21 returned 0 after 10 usecs
[   16.093679] calling  load_system_certificate_list+0x0/0x55 @ 1
[   16.100153] Loading compiled-in X.509 certificates
[   16.106327] Loaded X.509 cert 'Build time autogenerated kernel key: 4189272f4dbd9ebeaa13ffbf24a0f265eca937ec'
[   16.116821] initcall load_system_certificate_list+0x0/0x55 returned 0 after 16668 usecs
[   16.125427] calling  fault_around_debugfs+0x0/0x28 @ 1
[   16.131208] initcall fault_around_debugfs+0x0/0x28 returned 0 after 13 usecs
[   16.138868] calling  max_swapfiles_check+0x0/0xc @ 1
[   16.144467] initcall max_swapfiles_check+0x0/0xc returned 0 after 0 usecs
[   16.151867] calling  init_zswap+0x0/0x3aa @ 1
[   16.157292] zswap: loaded using pool lzo/zbud
[   16.162574] initcall init_zswap+0x0/0x3aa returned 0 after 5710 usecs
[   16.169640] calling  hugetlb_vmemmap_init+0x0/0x127 @ 1
[   16.175526] initcall hugetlb_vmemmap_init+0x0/0x127 returned 0 after 12 usecs
[   16.183273] calling  slab_sysfs_init+0x0/0xf2 @ 1
[   16.204110] initcall slab_sysfs_init+0x0/0xf2 returned 0 after 15496 usecs
[   16.211603] calling  kasan_cpu_quarantine_init+0x0/0x48 @ 1
[   16.218021] initcall kasan_cpu_quarantine_init+0x0/0x48 returned 219 after 218 usecs
[   16.226377] calling  kfence_debugfs_init+0x0/0x5b @ 1
[   16.232083] initcall kfence_debugfs_init+0x0/0x5b returned 0 after 18 usecs
[   16.239658] calling  split_huge_pages_debugfs+0x0/0x28 @ 1
[   16.245781] initcall split_huge_pages_debugfs+0x0/0x28 returned 0 after 6 usecs
[   16.253700] calling  pageowner_init+0x0/0x38 @ 1
[   16.258953] page_owner is disabled
[   16.263005] initcall pageowner_init+0x0/0x38 returned 0 after 4051 usecs
[   16.270320] calling  check_early_ioremap_leak+0x0/0x89 @ 1
[   16.276434] initcall check_early_ioremap_leak+0x0/0x89 returned 0 after 0 usecs
[   16.284352] calling  set_hardened_usercopy+0x0/0x24 @ 1
[   16.290209] initcall set_hardened_usercopy+0x0/0x24 returned 1 after 0 usecs
[   16.297869] calling  fscrypt_init+0x0/0xcd @ 1
[   16.303195] Key type .fscrypt registered
[   16.307762] Key type fscrypt-provisioning registered
[   16.313358] initcall fscrypt_init+0x0/0xcd returned 0 after 10402 usecs
[   16.320591] calling  pstore_init+0x0/0x81 @ 1
[   16.325595] initcall pstore_init+0x0/0x81 returned 0 after 7 usecs
[   16.332398] calling  init_root_keyring+0x0/0x12 @ 1
[   16.337943] initcall init_root_keyring+0x0/0x12 returned 0 after 34 usecs
[   16.345349] calling  init_trusted+0x0/0x256 @ 1
[   16.350766] initcall init_trusted+0x0/0x256 returned 0 after 246 usecs
[   16.357921] calling  init_encrypted+0x0/0x151 @ 1
[   16.372547] Key type encrypted registered
[   16.377228] initcall init_encrypted+0x0/0x151 returned 0 after 13966 usecs
[   16.384735] calling  init_profile_hash+0x0/0x102 @ 1
[   16.390342] AppArmor: AppArmor sha1 policy hashing enabled
[   16.396454] initcall init_profile_hash+0x0/0x102 returned 0 after 6121 usecs
[   16.404113] calling  integrity_fs_init+0x0/0x52 @ 1
[   16.409631] initcall integrity_fs_init+0x0/0x52 returned 0 after 8 usecs
[   16.416949] calling  crypto_algapi_init+0x0/0x11 @ 1
[   16.422553] initcall crypto_algapi_init+0x0/0x11 returned 0 after 5 usecs
[   16.429956] calling  blk_timeout_init+0x0/0x17 @ 1
[   16.435382] initcall blk_timeout_init+0x0/0x17 returned 0 after 0 usecs
[   16.442611] calling  kunit_init+0x0/0x1a @ 1
[   16.447530] initcall kunit_init+0x0/0x1a returned 0 after 7 usecs
[   16.454245] calling  init_error_injection+0x0/0x6e @ 1
[   16.461375] initcall init_error_injection+0x0/0x6e returned 0 after 1359 usecs
[   16.469222] calling  pci_resource_alignment_sysfs_init+0x0/0x1c @ 1
[   16.476115] initcall pci_resource_alignment_sysfs_init+0x0/0x1c returned 0 after 5 usecs
[   16.484805] calling  pci_sysfs_init+0x0/0x72 @ 1
[   16.490267] initcall pci_sysfs_init+0x0/0x72 returned 0 after 207 usecs
[   16.497496] calling  bert_init+0x0/0x653 @ 1
[   16.502408] initcall bert_init+0x0/0x653 returned 0 after 1 usecs
[   16.509123] calling  clk_debug_init+0x0/0x139 @ 1
[   16.514487] initcall clk_debug_init+0x0/0x139 returned 0 after 25 usecs
[   16.521718] calling  dmar_free_unused_resources+0x0/0x194 @ 1
[   16.528090] initcall dmar_free_unused_resources+0x0/0x194 returned 0 after 0 usecs
[   16.536267] calling  sync_state_resume_initcall+0x0/0x20 @ 1
[   16.542555] initcall sync_state_resume_initcall+0x0/0x20 returned 0 after 0 usecs
[   16.550645] calling  deferred_probe_initcall+0x0/0xd0 @ 1
[   16.556829] initcall deferred_probe_initcall+0x0/0xd0 returned 0 after 157 usecs
[   16.564842] calling  firmware_memmap_init+0x0/0x5e @ 1
[   16.570964] initcall firmware_memmap_init+0x0/0x5e returned 0 after 346 usecs
[   16.578712] calling  register_update_efi_random_seed+0x0/0x22 @ 1
[   16.585430] initcall register_update_efi_random_seed+0x0/0x22 returned 0 after 0 usecs
[   16.593948] calling  efi_shutdown_init+0x0/0x78 @ 1
[   16.599463] initcall efi_shutdown_init+0x0/0x78 returned -19 after 0 usecs
[   16.606950] calling  efi_earlycon_unmap_fb+0x0/0x60 @ 1
[   16.612805] initcall efi_earlycon_unmap_fb+0x0/0x60 returned 0 after 0 usecs
[   16.620468] calling  itmt_legacy_init+0x0/0x4d @ 1
[   16.625894] initcall itmt_legacy_init+0x0/0x4d returned -19 after 0 usecs
[   16.633296] calling  bpf_sockmap_iter_init+0x0/0x55 @ 1
[   16.639161] initcall bpf_sockmap_iter_init+0x0/0x55 returned 0 after 8 usecs
[   16.646821] calling  bpf_sk_storage_map_iter_init+0x0/0x55 @ 1
[   16.653279] initcall bpf_sk_storage_map_iter_init+0x0/0x55 returned 0 after 1 usecs
[   16.661537] calling  sch_default_qdisc+0x0/0x15 @ 1
[   16.667050] initcall sch_default_qdisc+0x0/0x15 returned 0 after 1 usecs
[   16.674366] calling  bpf_prog_test_run_init+0x0/0xf6 @ 1
[   16.680309] initcall bpf_prog_test_run_init+0x0/0xf6 returned 0 after 0 usecs
[   16.688054] calling  tcp_congestion_default+0x0/0x1c @ 1
[   16.693995] initcall tcp_congestion_default+0x0/0x1c returned 0 after 0 usecs
[   16.701741] calling  ip_auto_config+0x0/0x816 @ 1
[   19.883459] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   19.892716] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.911243] Sending DHCP requests ...., OK
[   33.278020] IP-Config: Got DHCP answer from 192.168.3.1, my address is 192.168.3.114
[   33.286370] IP-Config: Complete:
[   33.290249]      device=eth0, hwaddr=f8:b1:56:e3:03:ca, ipaddr=192.168.3.114, mask=255.255.255.0, gw=192.168.3.200
[   33.301170]      host=lkp-hsw-d03, domain=lkp.intel.com, nis-domain=(none)
[   33.308655]      bootserver=192.168.3.200, rootserver=192.168.3.200, rootpath=
[   33.308658]      nameserver0=192.168.3.200
[   33.381545] e1000e 0000:04:00.0 eth1: NIC Link is Down
[   33.387861] initcall ip_auto_config+0x0/0x816 returned 0 after 16680778 usecs
[   33.395616] calling  tcp_bpf_v4_build_proto+0x0/0xef @ 1
[   33.401558] initcall tcp_bpf_v4_build_proto+0x0/0xef returned 0 after 0 usecs
[   33.409301] calling  udp_bpf_v4_build_proto+0x0/0x9d @ 1
[   33.415240] initcall udp_bpf_v4_build_proto+0x0/0x9d returned 0 after 0 usecs
[   33.422982] calling  bpf_tcp_ca_kfunc_init+0x0/0x1a @ 1
[   33.428837] initcall bpf_tcp_ca_kfunc_init+0x0/0x1a returned 0 after 0 usecs
[   33.436495] calling  pci_mmcfg_late_insert_resources+0x0/0xb9 @ 1
[   33.443213] initcall pci_mmcfg_late_insert_resources+0x0/0xb9 returned 0 after 3 usecs
[   33.451728] calling  software_resume+0x0/0x40 @ 1
[   33.457067] initcall software_resume+0x0/0x40 returned -2 after 0 usecs
[   33.464296] calling  ftrace_check_sync+0x0/0x18 @ 1
[   33.469816] initcall ftrace_check_sync+0x0/0x18 returned 0 after 8 usecs
[   33.477134] calling  latency_fsnotify_init+0x0/0x3c @ 1
[   33.483032] initcall latency_fsnotify_init+0x0/0x3c returned 0 after 47 usecs
[   33.490783] calling  trace_eval_sync+0x0/0x18 @ 1
[   33.496131] initcall trace_eval_sync+0x0/0x18 returned 0 after 4 usecs
[   33.503276] calling  late_trace_init+0x0/0xa0 @ 1
[   33.508617] initcall late_trace_init+0x0/0xa0 returned 0 after 0 usecs
[   33.515760] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xa5 @ 1
[   33.523081] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa5 returned 0 after 5 usecs
[   33.532204] calling  fb_logo_late_init+0x0/0x13 @ 1
[   33.537732] initcall fb_logo_late_init+0x0/0x13 returned 0 after 0 usecs
[   33.545046] calling  clk_disable_unused+0x0/0x190 @ 1
[   33.550730] initcall clk_disable_unused+0x0/0x190 returned 0 after 0 usecs
[   33.558219] KTAP version 1
[   33.561583] 1..7
[   33.564262]     KTAP version 1
[   33.567970]     # Subtest: hw_breakpoint
[   33.567972]     1..9
[   33.572894]     ok 1 test_one_cpu
[   33.576580]     ok 2 test_many_cpus
[   33.580967]     ok 3 test_one_task_on_all_cpus
[   33.585737]     ok 4 test_two_tasks_on_all_cpus
[   33.591143]     ok 5 test_one_task_on_one_cpu
[   33.596679]     ok 6 test_one_task_mixed
[   33.602100]     ok 7 test_two_tasks_on_one_cpu
[   33.607047]     ok 8 test_two_tasks_on_one_all_cpus
[   33.612499]     ok 9 test_task_on_all_and_one_cpu
[   33.618015] # hw_breakpoint: pass:9 fail:0 skip:0 total:9
[   33.623356] # Totals: pass:9 fail:0 skip:0 total:9
[   33.629381] ok 1 hw_breakpoint
[   33.638525]     KTAP version 1
[   33.642232]     # Subtest: binfmt_elf
[   33.642234]     1..1
[   33.646787]     ok 1 total_mapping_size_test
[   33.649665] ok 2 binfmt_elf
[   33.658040]     KTAP version 1
[   33.661780]     # Subtest: compat_binfmt_elf
[   33.661782]     1..1
[   33.666918]     ok 1 total_mapping_size_test
[   33.669772] ok 3 compat_binfmt_elf
[   33.678745]     KTAP version 1
[   33.682453]     # Subtest: fprobe_test
[   33.682455]     1..3
[   33.713998]     ok 1 test_fprobe_entry
[   33.818365]     ok 2 test_fprobe
[   33.922391]     ok 3 test_fprobe_syms
[   33.926288] # fprobe_test: pass:3 fail:0 skip:0 total:3
[   33.930599] # Totals: pass:3 fail:0 skip:0 total:3
[   33.936453] ok 4 fprobe_test
[   33.945442]     KTAP version 1
[   33.949151]     # Subtest: qos-kunit-test
[   33.949153]     1..3
[   33.954046]     ok 1 freq_qos_test_min
[   33.957134]     ok 2 freq_qos_test_maxdef
[   33.961728]     ok 3 freq_qos_test_readd
[   33.966386] # qos-kunit-test: pass:3 fail:0 skip:0 total:3
[   33.970953] # Totals: pass:3 fail:0 skip:0 total:3
[   33.977062] ok 5 qos-kunit-test
[   33.986297]     KTAP version 1
[   33.990004]     # Subtest: property-entry
[   33.990006]     1..7
[   33.994864]     ok 1 pe_test_uints
[   33.998025]     ok 2 pe_test_uint_arrays
[   34.002356]     ok 3 pe_test_strings
[   34.007095]     ok 4 pe_test_bool
[   34.011482]     ok 5 pe_test_move_inline_u8
[   34.015610]     ok 6 pe_test_move_inline_str
[   34.020701]     ok 7 pe_test_reference
[   34.025617] # property-entry: pass:7 fail:0 skip:0 total:7
[   34.030013] # Totals: pass:7 fail:0 skip:0 total:7
[   34.036125] ok 6 property-entry
[   34.045399]     KTAP version 1
[   34.049105]     # Subtest: thunderbolt
[   34.049107]     1..38
[   34.053811]     ok 1 tb_test_path_basic
[   34.057116]     ok 2 tb_test_path_not_connected_walk
[   34.061921]     ok 3 tb_test_path_single_hop_walk
[   34.067915]     ok 4 tb_test_path_daisy_chain_walk
[   34.073942]     ok 5 tb_test_path_simple_tree_walk
[   34.080601]     ok 6 tb_test_path_complex_tree_walk
[   34.087521]     ok 7 tb_test_path_max_length_walk
[   34.093566]     ok 8 tb_test_path_not_connected
[   34.099377]     ok 9 tb_test_path_not_bonded_lane0
[   34.104915]     ok 10 tb_test_path_not_bonded_lane1
[   34.110983]     ok 11 tb_test_path_not_bonded_lane1_chain
[   34.117110]     ok 12 tb_test_path_not_bonded_lane1_chain_reverse
[   34.123843]     ok 13 tb_test_path_mixed_chain
[   34.131309]     ok 14 tb_test_path_mixed_chain_reverse
[   34.136937]     ok 15 tb_test_tunnel_pcie
[   34.143119]     ok 16 tb_test_tunnel_dp
[   34.148575]     ok 17 tb_test_tunnel_dp_chain
[   34.153855]     ok 18 tb_test_tunnel_dp_tree
[   34.160526]     ok 19 tb_test_tunnel_dp_max_length
[   34.166286]     ok 20 tb_test_tunnel_port_on_path
[   34.172247]     ok 21 tb_test_tunnel_usb3
[   34.177917]     ok 22 tb_test_tunnel_dma
[   34.182880]     ok 23 tb_test_tunnel_dma_rx
[   34.187641]     ok 24 tb_test_tunnel_dma_tx
[   34.192870]     ok 25 tb_test_tunnel_dma_chain
[   34.197922]     ok 26 tb_test_tunnel_dma_match
[   34.203334]     ok 27 tb_test_credit_alloc_legacy_not_bonded
[   34.208750]     ok 28 tb_test_credit_alloc_legacy_bonded
[   34.215480]     ok 29 tb_test_credit_alloc_pcie
[   34.221839]     ok 30 tb_test_credit_alloc_without_dp
[   34.227402]     ok 31 tb_test_credit_alloc_dp
[   34.233525]     ok 32 tb_test_credit_alloc_usb3
[   34.238969]     ok 33 tb_test_credit_alloc_dma
[   34.244606]     ok 34 tb_test_credit_alloc_dma_multiple
[   34.250233]     ok 35 tb_test_credit_alloc_all
[   34.256415]     ok 36 tb_test_property_parse
[   34.261773]     ok 37 tb_test_property_format
[   34.266906]     ok 38 tb_test_property_copy
[   34.271909] # thunderbolt: pass:38 fail:0 skip:0 total:38
[   34.276739] # Totals: pass:38 fail:0 skip:0 total:38
[   34.282767] ok 7 thunderbolt
[   34.298327] Freeing unused kernel image (initmem) memory: 3196K
[   34.310216] Write protecting the kernel read-only data: 55296k
[   34.317206] Freeing unused kernel image (rodata/data gap) memory: 1056K
[   34.330247] Run /init as init process
[   34.334574]   with arguments:
[   34.338198]     /init
[   34.341132]     nokaslr
[   34.344240]   with environment:
[   34.348033]     HOME=/
[   34.351052]     TERM=linux
[   34.354417]     RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2
[   34.369800]     BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f
[   34.383377]     branch=linux-review/Christian-Marangi/clk-Warn-and-add-workaround-on-misuse-of-parent_data-with-name-only/20230112-034048
[   34.396274]     job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml
[   34.411931]     user=lkp
[   34.415123]     ARCH=x86_64
[   34.418571]     kconfig=x86_64-rhel-8.3-kunit
[   34.423565]     commit=cc3ff324b29f06b124b57f745fcc4ec624c87d16
[   34.430106]     max_uptime=1200
[   34.433899]     LKP_SERVER=internal-lkp-server
[   34.438979]     selinux=0
[   34.442255]     softlockup_panic=1
[   34.446305]     prompt_ramdisk=0
[   34.450184]     vga=normal
[   34.469386] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[   34.481855] calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
[   34.488491] initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 17 usecs
[   34.688183] calling  fuse_init+0x0/0x16c [fuse] @ 200
[   34.694642] fuse: init (API version 7.38)
[   34.695343] initcall fuse_init+0x0/0x16c [fuse] returned 0 after 701 usecs
[   34.728454] calling  drm_core_init+0x0/0xca [drm] @ 199
[   34.734641] ACPI: bus type drm_connector registered
[   34.746176] initcall drm_core_init+0x0/0xca [drm] returned 0 after 11629 usecs
[   34.939402] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 222
[   34.947257] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   34.959768] calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 223
[   34.967041] initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 687 usecs
[   34.993537] calling  mei_init+0x0/0xb7 [mei] @ 242
[   35.000359] initcall mei_init+0x0/0xb7 [mei] returned 0 after 169 usecs
[   35.017177] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 235
[   35.018406] calling  acpi_video_init+0x0/0x1000 [video] @ 223
[   35.025534] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   35.033283] initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 15 usecs
[   35.058223] calling  intel_uncore_init+0x0/0x3a1 [intel_uncore] @ 233
[   35.077541] initcall intel_uncore_init+0x0/0x3a1 [intel_uncore] returned 0 after 11930 usecs
[   35.104150] calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 242
[   35.104219] calling  cstate_pmu_init+0x0/0x1000 [intel_cstate] @ 233
[   35.104432] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 226
[   35.104445] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   35.104659] calling  ata_init+0x0/0x8a [libata] @ 240
[   35.105080] libata version 3.00 loaded.
[   35.105084] initcall ata_init+0x0/0x8a [libata] returned 0 after 368 usecs
[   35.111638] initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 110 usecs
[   35.173450] initcall cstate_pmu_init+0x0/0x1000 [intel_cstate] returned 0 after 53576 usecs
[   35.199546] calling  mei_wdt_driver_init+0x0/0x1000 [mei_wdt] @ 220
[   35.207185] calling  rapl_pmu_init+0x0/0xf0a [rapl] @ 234
[   35.207257] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 228
[   35.207733] calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 240
[   35.207857] ahci 0000:00:1f.2: version 3.0
[   35.209039] initcall mei_wdt_driver_init+0x0/0x1000 [mei_wdt] returned 0 after 1288 usecs
[   35.210467] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
[   35.210481] IOAPIC[0]: Preconfigured routing entry (8-19 -> IRQ 19 Level:1 ActiveLow:1)
[   35.210965] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x5 impl SATA mode
[   35.210972] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst 
[   35.229998] scsi host0: ahci
[   35.234565] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   35.245062] scsi host1: ahci
[   35.299361] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[   35.300236] scsi host2: ahci
[   35.308957] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   35.313448] scsi host3: ahci
[   35.318875] RAPL PMU: hw unit of domain package 2^-14 Joules
[   35.318877] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   35.318878] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   35.318889] initcall rapl_pmu_init+0x0/0xf0a [rapl] returned 0 after 84324 usecs
[   35.323543] scsi host4: ahci
[   35.358155] scsi host5: ahci
[   35.362785] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 230
[   35.369957] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
[   35.379458] calling  drm_buddy_module_init+0x0/0x1000 [drm_buddy] @ 219
[   35.379630] calling  sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] @ 233
[   35.379831] ata1: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a100 irq 35
[   35.379835] ata2: DUMMY
[   35.379837] ata3: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a200 irq 35
[   35.379841] ata4: DUMMY
[   35.379843] ata5: DUMMY
[   35.379844] ata6: DUMMY
[   35.380120] initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 10164 usecs
[   35.386843] initcall drm_buddy_module_init+0x0/0x1000 [drm_buddy] returned 0 after 142 usecs
[   35.394251] initcall sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] returned 0 after 55 usecs
[   35.472515] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 239
[   35.480380] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   35.490289] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 249
[   35.498828] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 9 usecs
[   35.534573] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 225
[   35.542116] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   35.552746] calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 224
[   35.561261] initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 7 usecs
[   35.588491] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 227
[   35.595741] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   35.595875] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 234
[   35.612196] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 4 usecs
[   35.642022] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 247
[   35.650156] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 9 usecs
[   35.687616] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   35.694660] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   35.703686] ata1.00: ATA-9: INTEL SSDSC2BB480G6, G2010140, max UDMA/133
[   35.711542] ata1.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 32)
[   35.720591] ata1.00: configured for UDMA/133
[   35.726534] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB48 0140 PQ: 0 ANSI: 5
[   36.104998] calling  ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] @ 372
[   36.113273] IPMI message handler: version 39.2
[   36.119709] initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 6436 usecs
[   40.826199] ata3.00: qc timeout after 5000 msecs (cmd 0x27)
[   40.832423] ata3.00: failed to read native max address (err_mask=0x4)
[   40.839479] ata3.00: HPA support seems broken, skipping HPA handling
[   41.151506] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   41.159636] ata3.00: ATA-6: ST_M13FQBL, 04081517, max UDMA/133
[   41.166109] ata3.00: 8089950 sectors, multi 16: LBA48 NCQ (depth 32)
[   41.471712] lkp: kernel tainted state: 262144

[   41.779289] LKP: stdout: 317: Kernel tests: Boot OK!

[   44.186287] LKP: stdout: 317: HOSTNAME lkp-hsw-d03, MAC f8:b1:56:e3:03:ca, kernel 6.2.0-rc1-00001-gcc3ff324b29f 1

[   44.523943] install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb

[   44.538617] Selecting previously unselected package ntpdate.

[   44.548404] (Reading database ... 16440 files and directories currently installed.)

[   44.560024] Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb ...

[   44.570668] Unpacking ntpdate (1:4.2.8p15+dfsg-1) ...

[   44.579293] Setting up ntpdate (1:4.2.8p15+dfsg-1) ...

[   44.588728] 21 Jan 12:52:04 ntpdate[417]: step time server 192.168.1.200 offset -1079.728677 sec

[   56.186248] ata3.00: qc timeout after 15000 msecs (cmd 0xef)
[   56.192560] ata3.00: failed to set xfermode (err_mask=0x4)
[   56.198677] ata3: limiting SATA link speed to 1.5 Gbps
[   56.204446] ata3.00: limiting speed to UDMA/133:PIO3
[   56.520847] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   71.546254] ata3.00: qc timeout after 15000 msecs (cmd 0xef)
[   71.553664] ata3.00: failed to set xfermode (err_mask=0x4)
[   71.559777] ata3.00: disable device
[   71.872834] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   71.961824] calling  init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] @ 372
[   71.962213] calling  drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] @ 219
[   71.968992] ipmi device interface
[   71.977844] initcall drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] returned 0 after 79 usecs
[   71.982042] initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 4276 usecs
[   72.002693] calling  init_sg+0x0/0x1000 [sg] @ 229
[   72.008421] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[   72.014580] initcall init_sg+0x0/0x1000 [sg] returned 0 after 6451 usecs
[   72.051462] calling  init_ipmi_si+0x0/0x27a [ipmi_si] @ 453
[   72.052909] calling  kvm_x86_init+0x0/0x11 [kvm] @ 234
[   72.057692] ipmi_si: IPMI System Interface driver
[   72.063471] initcall kvm_x86_init+0x0/0x11 [kvm] returned 0 after 1 usecs
[   72.069139] ipmi_si: Unable to find any System Interface(s)
[   72.082454] initcall init_ipmi_si+0x0/0x27a [ipmi_si] returned -19 after 18983 usecs
[   72.082705] calling  crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] @ 229
[   72.109988] calling  crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] @ 454
[   72.118208] initcall crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] returned 0 after 21 usecs
[   72.134846] calling  vmx_init+0x0/0x26f [kvm_intel] @ 234
[   72.140913] initcall crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] returned 0 after 22725 usecs
[   72.157427] initcall vmx_init+0x0/0x26f [kvm_intel] returned 0 after 16507 usecs
[   72.166293] calling  init_sd+0x0/0x1000 [sd_mod] @ 229
[   72.172646] initcall init_sd+0x0/0x1000 [sd_mod] returned 0 after 559 usecs
[   72.173477] ata1.00: Enabling discard_zeroes_data
[   72.175147] calling  coretemp_init+0x0/0x1000 [coretemp] @ 234
[   72.192090] sd 0:0:0:0: [sda] 937703088 512-byte logical blocks: (480 GB/447 GiB)
[   72.192316] initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 17157 usecs
[   72.200214] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   72.214593] sd 0:0:0:0: [sda] Write Protect is off
[   72.220053] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   72.225966] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   72.235671] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[   72.244063] ata1.00: Enabling discard_zeroes_data
[   72.251138]  sda: sda1 sda2
[   72.255077] sd 0:0:0:0: [sda] Attached SCSI disk
[   72.601356] calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 234
[   72.608849] initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 153 usecs
[   72.624670] calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 249
[   72.626547] calling  i915_init+0x0/0x161 [i915] @ 219
[   72.638652] initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 91 usecs
[   72.638984] calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 464
[   72.655574] initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 34 usecs
[   72.664961] i915 0000:00:02.0: vgaarb: deactivate vga console
[   72.672791] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 234
[   72.680581] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   72.680971] calling  init_module+0x0/0x1000 [raid6_pq] @ 464
[   72.685199] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   72.726182] raid6: avx2x4   gen() 33313 MB/s
[   72.747183] raid6: avx2x2   gen() 32071 MB/s
[   72.768182] raid6: avx2x1   gen() 25800 MB/s
[   72.773091] raid6: using algorithm avx2x4 gen() 33313 MB/s
[   72.796182] raid6: .... xor() 12675 MB/s, rmw enabled
[   72.801862] raid6: using avx2x2 recovery algorithm
[   72.807285] initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 97323 usecs
[   72.817534] calling  calibrate_xor_blocks+0x0/0xeae [xor] @ 464
[   72.819285] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[   72.824154] xor: automatically using best checksumming function   avx       
[   72.839481] initcall calibrate_xor_blocks+0x0/0xeae [xor] returned 0 after 15327 usecs
[   72.849711] calling  blake2b_mod_init+0x0/0x1000 [blake2b_generic] @ 464
[   72.857041] initcall blake2b_mod_init+0x0/0x1000 [blake2b_generic] returned 0 after 8 usecs
[   72.857586] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   72.878404] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input2
[   72.889489] initcall i915_init+0x0/0x161 [i915] returned 0 after 32456 usecs
[   72.902515] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   72.912818] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   72.923265] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   73.022708] calling  init_btrfs_fs+0x0/0x1e2 [btrfs] @ 464
[   73.031213] Btrfs loaded, crc32c=crc32c-intel, zoned=no, fsverity=no
[   73.038288] initcall init_btrfs_fs+0x0/0x1e2 [btrfs] returned 0 after 9410 usecs
[   73.061857] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 249
[   73.062307] BTRFS: device fsid b3992683-c9aa-43bb-8fa9-e046fd856e5f devid 1 transid 13812 /dev/sda2 scanned by systemd-udevd (230)
[   73.069028] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   73.090772] calling  rapl_init+0x0/0x1000 [intel_rapl_common] @ 234
[   73.097766] initcall rapl_init+0x0/0x1000 [intel_rapl_common] returned 0 after 94 usecs
[   73.108214] calling  intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] @ 229
[   73.116489] intel_rapl_common: Found RAPL domain package
[   73.122529] intel_rapl_common: Found RAPL domain core
[   73.128219] intel_rapl_common: Found RAPL domain uncore
[   73.134086] intel_rapl_common: Found RAPL domain dram
[   73.139787] intel_rapl_common: RAPL package-0 domain package locked by BIOS
[   73.147376] intel_rapl_common: RAPL package-0 domain dram locked by BIOS
[   73.155622] initcall intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] returned 0 after 39305 usecs
[   73.166487] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 238
[   73.173655] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   73.202044] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 244
[   73.209207] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   73.232584] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 233
[   73.239751] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   73.264116] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 247
[   73.271279] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   73.294581] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 246
[   73.301750] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   73.323084] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 224
[   73.330247] initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
[   77.588762] BTRFS info (device sda2): using crc32c (crc32c-intel) checksum algorithm
[   77.597123] BTRFS info (device sda2): disk space caching is enabled
[   77.609303] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 2, rd 2, flush 0, corrupt 0, gen 0
[   77.625813] BTRFS info (device sda2): enabling ssd optimizations
[   77.632451] BTRFS info (device sda2): auto enabling async discard
[   80.054139] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.066678] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.098071] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.110410] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.141445] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.153801] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.184705] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.197110] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.228010] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.240354] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.271712] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.284075] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.314226] LKP: stdout: 317:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml

[   80.315603] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.335819] RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2

[   80.347494] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.365408] job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml

[   80.404765] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.417118] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.448032] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.460391] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.491319] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.503675] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.534875] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.547236] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.578142] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.590515] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.621443] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.633795] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.664730] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.677095] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.707980] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   80.720344] x86/PAT: bmc-watchdog:557 map pfn expected mapping type uncached-minus for [mem 0xd8fee000-0xd8feefff], got write-back
[   81.095211]     KTAP version 1
[   81.098938]     # Subtest: clk-gate-register-test
[   81.098940]     1..6
[   81.104684]     ok 1 clk_gate_register_test_dev
[   81.107969]     ok 2 clk_gate_register_test_parent_names
[   81.113600]     ok 3 clk_gate_register_test_parent_data
[   81.119809] ------------[ cut here ]------------
[   81.130925] Empty .fw_name with .name in test_gate's .parent_data. Using .name for .fw_name declaration.
[   81.141019] WARNING: CPU: 7 PID: 621 at drivers/clk/clk.c:4057 clk_core_populate_parent_map.constprop.0+0x405/0x610
[   81.152038] Modules linked in: clk_gate_test intel_rapl_msr intel_rapl_common btrfs blake2b_generic xor raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp i915 coretemp sd_mod t10_pi kvm_intel crc64_rocksoft_generic crc64_rocksoft crc64 intel_gtt sg kvm drm_display_helper ipmi_devintf irqbypass ipmi_msghandler crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy ttm ahci rapl mei_wdt libahci drm_kms_helper intel_cstate syscopyarea mei_me sysfillrect libata intel_uncore video mei sysimgblt wmi drm fuse ip_tables
[   81.200885] CPU: 7 PID: 621 Comm: kunit_try_catch Tainted: G                 N 6.2.0-rc1-00001-gcc3ff324b29f #1
[   81.211561] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[   81.219409] RIP: 0010:clk_core_populate_parent_map.constprop.0+0x405/0x610
[   81.226916] Code: 3c 24 00 0f 84 e8 fd ff ff 48 8b 44 24 20 80 38 00 0f 85 a3 01 00 00 48 8b 04 24 48 c7 c7 20 78 eb 83 48 8b 30 e8 8b 77 1d 01 <0f> 0b 4c 89 e0 48 c1 e8 03 42 80 3c 38 00 0f 85 6f 01 00 00 49 8b
[   81.246189] RSP: 0018:ffffc90000b17bb8 EFLAGS: 00010282
[   81.252058] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   81.259819] RDX: 0000000000000004 RSI: 0000000000000008 RDI: fffff52000162f69
[   81.267588] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffc90000b179ef
[   81.275349] R10: fffff52000162f3d R11: 0000000000000001 R12: ffffc90000b17e60
[   81.283111] R13: 0000000000000000 R14: ffff88841e5f9180 R15: dffffc0000000000
[   81.290858] FS:  0000000000000000(0000) GS:ffff8883b8980000(0000) knlGS:0000000000000000
[   81.299564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.305953] CR2: 00007fb2ba883550 CR3: 000000041ce14004 CR4: 00000000001706e0
[   81.313714] DR0: ffffffff86045121 DR1: ffffffff86045122 DR2: ffffffff86045123
[   81.321473] DR3: ffffffff86045123 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   81.329231] Call Trace:
[   81.332363]  <TASK>
[   81.335150]  __clk_register+0x33d/0xa20
[   81.339656]  clk_hw_register+0x13/0x20
[   81.344063]  __clk_hw_register_gate+0x2e7/0x3b0
[   81.349252]  ? devm_clk_hw_release_gate+0x50/0x50
[   81.354612]  ? update_curr+0x2cf/0x5e0
[   81.359029]  ? load_balance+0x14a0/0x14a0
[   81.363706]  clk_gate_register_test_parent_data_legacy+0x120/0x260 [clk_gate_test]
[   81.371901]  ? clk_gate_register_test_parent_hw+0x210/0x210 [clk_gate_test]
[   81.379494]  ? io_schedule_timeout+0x160/0x160
[   81.384601]  ? set_cpus_allowed_ptr+0x85/0xb0
[   81.389609]  ? migrate_enable+0x210/0x210
[   81.394274]  kunit_try_run_case+0x106/0x190
[   81.399121]  ? kunit_catch_run_case+0xe0/0xe0
[   81.404138]  kunit_generic_run_threadfn_adapter+0x4e/0xa0
[   81.410187]  ? kunit_try_catch_throw+0x80/0x80
[   81.415277]  kthread+0x293/0x330
[   81.419182]  ? kthread_complete_and_exit+0x30/0x30
[   81.424617]  ret_from_fork+0x1f/0x30
[   81.428863]  </TASK>
[   81.431732] ---[ end trace 0000000000000000 ]---
[   81.437519]     ok 4 clk_gate_register_test_parent_data_legacy
[   81.438007]     ok 5 clk_gate_register_test_parent_hw
[   81.444626] gate bit exceeds LOWORD field
[   81.454990]     ok 6 clk_gate_register_test_hiword_invalid
[   81.454995] # clk-gate-register-test: pass:6 fail:0 skip:0 total:6
[   81.461124] # Totals: pass:6 fail:0 skip:0 total:6
[   81.467942] ok 1 clk-gate-register-test
[   81.477887]     KTAP version 1
[   81.481605]     # Subtest: clk-gate-test
[   81.481607]     1..3
[   81.486715]     ok 1 clk_gate_test_parent_rate
[   81.489938] clk_unregister: unregistering prepared clock: test_gate
[   81.501985] clk_unregister: unregistering prepared clock: test_parent
[   81.509082]     ok 2 clk_gate_test_enable
[   81.509592]     ok 3 clk_gate_test_disable
[   81.514273] # clk-gate-test: pass:3 fail:0 skip:0 total:3
[   81.519038] # Totals: pass:3 fail:0 skip:0 total:3
[   81.525093] ok 2 clk-gate-test
[   81.534272]     KTAP version 1
[   81.537994]     # Subtest: clk-gate-invert-test
[   81.537997]     1..2
[   81.543646] clk_unregister: unregistering prepared clock: test_gate
[   81.553473] clk_unregister: unregistering prepared clock: test_parent
[   81.560568]     ok 1 clk_gate_test_invert_enable
[   81.561066]     ok 2 clk_gate_test_invert_disable
[   81.566341] # clk-gate-invert-test: pass:2 fail:0 skip:0 total:2
[   81.571695] # Totals: pass:2 fail:0 skip:0 total:2
[   81.578336] ok 3 clk-gate-invert-test
[   81.588104]     KTAP version 1
[   81.591826]     # Subtest: clk-gate-hiword-test
[   81.591829]     1..2
[   81.597377] clk_unregister: unregistering prepared clock: test_gate
[   81.607364] clk_unregister: unregistering prepared clock: test_parent
[   81.614472]     ok 1 clk_gate_test_hiword_enable
[   81.614987]     ok 2 clk_gate_test_hiword_disable
[   81.620270] # clk-gate-hiword-test: pass:2 fail:0 skip:0 total:2
[   81.625629] # Totals: pass:2 fail:0 skip:0 total:2
[   81.632270] ok 4 clk-gate-hiword-test
[   81.642073]     KTAP version 1
[   81.645796]     # Subtest: clk-gate-is_enabled-test
[   81.645798]     1..4
[   81.651734]     ok 1 clk_gate_test_is_enabled
[   81.654866]     ok 2 clk_gate_test_is_disabled
[   81.660199]     ok 3 clk_gate_test_is_enabled_inverted
[   81.665624]     ok 4 clk_gate_test_is_disabled_inverted
[   81.671423] # clk-gate-is_enabled-test: pass:4 fail:0 skip:0 total:4
[   81.677294] # Totals: pass:4 fail:0 skip:0 total:4
[   81.684286] ok 5 clk-gate-is_enabled-test
[   81.737822]     KTAP version 1
[   81.741540]     # Subtest: clk-leaf-mux-set-rate-parent
[   81.741543]     1..1
[   81.748253]     ok 1 clk_leaf_mux_set_rate_parent_determine_rate
[   81.751119] ok 1 clk-leaf-mux-set-rate-parent
[   81.762775]     KTAP version 1
[   81.766498]     # Subtest: clk-test
[   81.766502]     1..4
[   81.770991]     ok 1 clk_test_get_rate
[   81.774516]     ok 2 clk_test_set_get_rate
[   81.779284]     ok 3 clk_test_set_set_get_rate
[   81.784257]     ok 4 clk_test_round_set_get_rate
[   81.789343] # clk-test: pass:4 fail:0 skip:0 total:4
[   81.794613] # Totals: pass:4 fail:0 skip:0 total:4
[   81.800234] ok 2 clk-test
[   81.808994]     KTAP version 1
[   81.812718]     # Subtest: clk-multiple-parents-mux-test
[   81.812721]     1..3
[   81.819246]     ok 1 clk_test_multiple_parents_mux_get_parent
[   81.822643]     ok 2 clk_test_multiple_parents_mux_has_parent
[   81.829698]     ok 3 clk_test_multiple_parents_mux_set_range_set_parent_get_rate # SKIP This needs to be fixed in the core.
[   81.836074] # clk-multiple-parents-mux-test: pass:2 fail:0 skip:1 total:3
[   81.847794] # Totals: pass:2 fail:0 skip:1 total:3
[   81.855207] ok 3 clk-multiple-parents-mux-test
[   81.865764]     KTAP version 1
[   81.869487]     # Subtest: clk-mux-notifier
[   81.869491]     1..1
[   81.878469]     ok 1 clk_mux_notifier_set_parent_test
[   81.881330] ok 4 clk-mux-notifier
[   81.891344]     KTAP version 1
[   81.895065]     # Subtest: clk-orphan-transparent-multiple-parent-mux-test
[   81.895069]     1..9
[   81.903098]     ok 1 clk_test_orphan_transparent_multiple_parent_mux_get_parent
[   81.906419]     ok 2 clk_test_orphan_transparent_multiple_parent_mux_set_parent
[   81.914826]     ok 3 clk_test_orphan_transparent_multiple_parent_mux_set_parent_drop_range
[   81.923216]     ok 4 clk_test_orphan_transparent_multiple_parent_mux_set_parent_get_rate
[   81.932514]     ok 5 clk_test_orphan_transparent_multiple_parent_mux_set_parent_put
[   81.941602]     ok 6 clk_test_orphan_transparent_multiple_parent_mux_set_parent_set_range_modified
[   81.950342]     ok 7 clk_test_orphan_transparent_multiple_parent_mux_set_parent_set_range_untouched
[   81.960387]     ok 8 clk_test_orphan_transparent_multiple_parent_mux_set_range_round_rate
[   81.970511]     ok 9 clk_test_orphan_transparent_multiple_parent_mux_set_range_set_parent_get_rate # SKIP This needs to be fixed in the core.
[   81.979290] # clk-orphan-transparent-multiple-parent-mux-test: pass:8 fail:0 skip:1 total:9
[   81.992551] # Totals: pass:8 fail:0 skip:1 total:9
[   82.001509] ok 5 clk-orphan-transparent-multiple-parent-mux-test
[   82.013615]     KTAP version 1
[   82.017336]     # Subtest: clk-orphan-transparent-single-parent-test
[   82.017338]     1..1
[   82.024861]     ok 1 clk_test_orphan_transparent_parent_mux_set_range
[   82.027731] ok 6 clk-orphan-transparent-single-parent-test
[   82.040944]     KTAP version 1
[   82.044664]     # Subtest: clk-orphan-two-level-root-last-test
[   82.044667]     1..2
[   82.051810]     ok 1 clk_orphan_two_level_root_last_test_get_rate
[   82.055439]     ok 2 clk_orphan_two_level_root_last_test_set_range
[   82.062158] # clk-orphan-two-level-root-last-test: pass:2 fail:0 skip:0 total:2
[   82.068971] # Totals: pass:2 fail:0 skip:0 total:2
[   82.076901] ok 7 clk-orphan-two-level-root-last-test
[   82.087984]     KTAP version 1
[   82.091701]     # Subtest: clk-range-test
[   82.091703]     1..11
[   82.096751]     ok 1 clk_range_test_set_range
[   82.099902] clk_set_rate_range_nolock: clk test_dummy_rate dev (null) con (null): invalid range [142001000, 142000000]
[   82.116270]     ok 2 clk_range_test_set_range_invalid
[   82.116545]     ok 3 clk_range_test_multiple_disjoints_range
[   82.122526]     ok 4 clk_range_test_set_range_round_rate_lower
[   82.129251]     ok 5 clk_range_test_set_range_set_rate_lower
[   82.135994]     ok 6 clk_range_test_set_range_set_round_rate_consistent_lower
[   82.142562]     ok 7 clk_range_test_set_range_round_rate_higher
[   82.150624]     ok 8 clk_range_test_set_range_set_rate_higher
[   82.157483]     ok 9 clk_range_test_set_range_set_round_rate_consistent_higher
[   82.164131]     ok 10 clk_range_test_set_range_get_rate_raised
[   82.172266]     ok 11 clk_range_test_set_range_get_rate_lowered
[   82.178735] # clk-range-test: pass:11 fail:0 skip:0 total:11
[   82.185291] # Totals: pass:11 fail:0 skip:0 total:11
[   82.191596] ok 8 clk-range-test
[   82.201061]     KTAP version 1
[   82.204780]     # Subtest: clk-range-maximize-test
[   82.204782]     1..3
[   82.210501]     ok 1 clk_range_test_set_range_rate_maximized
[   82.213625]     ok 2 clk_range_test_multiple_set_range_rate_maximized
[   82.220207]     ok 3 clk_range_test_multiple_set_range_rate_put_maximized
[   82.227282] # clk-range-maximize-test: pass:3 fail:0 skip:0 total:3
[   82.234709] # Totals: pass:3 fail:0 skip:0 total:3
[   82.241619] ok 9 clk-range-maximize-test
[   82.251697]     KTAP version 1
[   82.255437]     # Subtest: clk-range-minimize-test
[   82.255440]     1..3
[   82.261237]     ok 1 clk_range_test_set_range_rate_minimized
[   82.264357]     ok 2 clk_range_test_multiple_set_range_rate_minimized
[   82.270975]     ok 3 clk_range_test_multiple_set_range_rate_put_minimized
[   82.278054] # clk-range-minimize-test: pass:3 fail:0 skip:0 total:3
[   82.285465] # Totals: pass:3 fail:0 skip:0 total:3
[   82.292369] ok 10 clk-range-minimize-test
[   82.302523]     KTAP version 1
[   82.306252]     # Subtest: clk-single-parent-mux-test
[   82.306255]     1..7
[   82.312388]     ok 1 clk_test_single_parent_mux_get_parent
[   82.315702]     ok 2 clk_test_single_parent_mux_has_parent
[   82.322349]     ok 3 clk_test_single_parent_mux_set_range_disjoint_child_last # SKIP This needs to be fixed in the core.
[   82.328918]     ok 4 clk_test_single_parent_mux_set_range_disjoint_parent_last # SKIP This needs to be fixed in the core.
[   82.340847]     ok 5 clk_test_single_parent_mux_set_range_round_rate_child_smaller
[   82.353004]     ok 6 clk_test_single_parent_mux_set_range_round_rate_parent_only
[   82.361784]     ok 7 clk_test_single_parent_mux_set_range_round_rate_parent_smaller
[   82.369812] # clk-single-parent-mux-test: pass:5 fail:0 skip:2 total:7
[   82.378083] # Totals: pass:5 fail:0 skip:2 total:7
[   82.385242] ok 11 clk-single-parent-mux-test
[   82.395614]     KTAP version 1
[   82.399336]     # Subtest: clk-uncached-test
[   82.399338]     1..3
[   82.404603]     ok 1 clk_test_uncached_get_rate
[   82.407695]     ok 2 clk_test_uncached_set_range
[   82.413135]     ok 3 clk_test_uncached_updated_rate_set_range
[   82.418402] # clk-uncached-test: pass:3 fail:0 skip:0 total:3
[   82.424792] # Totals: pass:3 fail:0 skip:0 total:3
[   82.431174] ok 12 clk-uncached-test
[   82.480733]     KTAP version 1
[   82.484464]     # Subtest: cpumask
[   82.484466]     1..6
[   82.488668]     ok 1 test_cpumask_weight
[   82.491607]     ok 2 test_cpumask_first
[   82.496625]     ok 3 test_cpumask_last
[   82.501216]     ok 4 test_cpumask_next
[   82.505692]     ok 5 test_cpumask_iterators
[   82.509022] result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/2, TMP_RESULT_ROOT: /tmp/lkp/result
[   82.510190]     ok 6 test_cpumask_iterators_builtin

[   82.540582] # cpumask: pass:6 fail:0 skip:0 total:6
[   82.548309] # Totals: pass:6 fail:0 skip:0 total:6
[   82.549129] run-job /lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml
[   82.553828] ok 1 cpumask

[   82.622674]     KTAP version 1
[   82.626390]     # Subtest: cros_ec_proto_test
[   82.626393]     1..54
[   82.631581]     ok 1 cros_ec_proto_test_prepare_tx_legacy_normal
[   82.634900]     ok 2 cros_ec_proto_test_prepare_tx_legacy_bad_msg_outsize
[   82.641701]     ok 3 cros_ec_proto_test_prepare_tx_normal
[   82.649582]     ok 4 cros_ec_proto_test_prepare_tx_bad_msg_outsize
[   82.655796]     ok 5 cros_ec_proto_test_check_result
[   82.662883]     ok 6 cros_ec_proto_test_query_all_normal
[   82.668625]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.681441]     ok 7 cros_ec_proto_test_query_all_no_pd_return_error
[   82.681649]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.695447]     ok 8 cros_ec_proto_test_query_all_no_pd_return0
[   82.695677]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.709059]     ok 9 cros_ec_proto_test_query_all_legacy_normal_v3_return_error
[   82.709246]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.724001]     ok 10 cros_ec_proto_test_query_all_legacy_normal_v3_return0
[   82.724181]     ok 11 cros_ec_proto_test_query_all_legacy_xfer_error
[   82.731898]  cros_ec_proto_test: EC responded to v2 hello with error: 1
[   82.746143]     ok 12 cros_ec_proto_test_query_all_legacy_return_error
[   82.746382]  cros_ec_proto_test: EC responded to v2 hello with bad result: 3203383231
[   82.762060]     ok 13 cros_ec_proto_test_query_all_legacy_data_error
[   82.762219]     ok 14 cros_ec_proto_test_query_all_legacy_return0
[   82.769363]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.782942]     ok 15 cros_ec_proto_test_query_all_no_mkbp
[   82.783130]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.796134]     ok 16 cros_ec_proto_test_query_all_no_mkbp_return_error
[   82.796322]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.810423]     ok 17 cros_ec_proto_test_query_all_no_mkbp_return0
[   82.810604]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.824283]     ok 18 cros_ec_proto_test_query_all_no_host_sleep
[   82.824494]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.837989]     ok 19 cros_ec_proto_test_query_all_no_host_sleep_return0
[   82.838258]     ok 20 cros_ec_proto_test_query_all_default_wake_mask_return_error
[   82.845731]  cros_ec_proto_test: failed to retrieve wake mask: -71
[   82.860658]     ok 21 cros_ec_proto_test_query_all_default_wake_mask_return0
[   82.860884]     ok 22 cros_ec_proto_test_cmd_xfer_normal
[   82.868796]     ok 23 cros_ec_proto_test_cmd_xfer_excess_msg_insize
[   82.874861]  cros_ec_proto_test: request of size 256 is too big (max: 255)
[   82.889280]     ok 24 cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru
[   82.889484]  cros_ec_proto_test: passthru rq of size 222 is too big (max: 221)
[   82.905804]     ok 25 cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru
[   82.905976]     ok 26 cros_ec_proto_test_cmd_xfer_protocol_v3_normal
[   82.914354]  cros_ec_proto_test: missing EC transfer API, cannot send command
[   82.929099]     ok 27 cros_ec_proto_test_cmd_xfer_protocol_v3_no_op
[   82.929241]     ok 28 cros_ec_proto_test_cmd_xfer_protocol_v2_normal
[   82.936283]     ok 29 cros_ec_proto_test_cmd_xfer_protocol_v2_no_op
[   82.954230]     ok 30 cros_ec_proto_test_cmd_xfer_in_progress_normal
[   83.511571]     ok 31 cros_ec_proto_test_cmd_xfer_in_progress_retries_eagain
[   83.526871] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-22045-11mszk5-2.yaml&job_state=running -O /dev/null

[   83.566687] target ucode: 0x28

[   83.573614] LKP: stdout: 493: current_version: 28, target_version: 28

[   83.583633] 2023-01-21 12:52:42 modprobe clk-gate_test

[   83.592330] 2023-01-21 12:52:43 rmmod clk-gate_test

[   83.600716] 2023-01-21 12:52:43 modprobe clk_test

[   83.608839] 2023-01-21 12:52:44 rmmod clk_test

[   83.616846] 2023-01-21 12:52:44 modprobe cpumask_kunit

[   83.625499] 2023-01-21 12:52:44 rmmod cpumask_kunit

[   83.634011] 2023-01-21 12:52:44 modprobe cros_kunit

[   84.069344]     ok 32 cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing
[   84.080532]     ok 33 cros_ec_proto_test_cmd_xfer_in_progress_xfer_error
[   84.100352]     ok 34 cros_ec_proto_test_cmd_xfer_in_progress_return_error
[   84.118223]     ok 35 cros_ec_proto_test_cmd_xfer_in_progress_return0
[   84.125917]     ok 36 cros_ec_proto_test_cmd_xfer_status_normal
[   84.133111]     ok 37 cros_ec_proto_test_cmd_xfer_status_xfer_error
[   84.150346]     ok 38 cros_ec_proto_test_cmd_xfer_status_return_error
[   84.157384]     ok 39 cros_ec_proto_test_get_next_event_no_mkbp_event
[   84.164601]     ok 40 cros_ec_proto_test_get_next_event_mkbp_event_ec_suspended
[   84.171845]     ok 41 cros_ec_proto_test_get_next_event_mkbp_event_version0
[   84.179944]     ok 42 cros_ec_proto_test_get_next_event_mkbp_event_version2
[   84.187691]     ok 43 cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc
[   84.195403]     ok 44 cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked
[   84.203653]     ok 45 cros_ec_proto_test_get_host_event_no_mkbp_event
[   84.212110]     ok 46 cros_ec_proto_test_get_host_event_not_host_event
[   84.219343]  cros_ec_proto_test: Invalid host event size
[   84.232492]     ok 47 cros_ec_proto_test_get_host_event_wrong_event_size
[   84.232656]     ok 48 cros_ec_proto_test_get_host_event_normal
[   84.240109]     ok 49 cros_ec_proto_test_check_features_cached
[   84.246764]     ok 50 cros_ec_proto_test_check_features_not_cached
[   84.253431]     ok 51 cros_ec_proto_test_get_sensor_count_normal
[   84.260552]     ok 52 cros_ec_proto_test_get_sensor_count_xfer_error
[   84.267345]     ok 53 cros_ec_proto_test_get_sensor_count_legacy
[   84.274494]     ok 54 cros_ec_proto_test_ec_cmd
[   84.281120] # cros_ec_proto_test: pass:54 fail:0 skip:0 total:54
[   84.286305] # Totals: pass:54 fail:0 skip:0 total:54
[   84.292957] ok 1 cros_ec_proto_test
[   84.308579] 2023-01-21 12:52:46 rmmod cros_kunit

[   84.336469] 2023-01-21 12:52:46 modprobe hid-uclogic-test

[   84.345123]     KTAP version 1
[   84.348844]     # Subtest: hid_uclogic_rdesc_test
[   84.348846]     1..1
[   84.354197]         KTAP version 1
[   84.361118]         # Subtest: hid_test_uclogic_template
[   84.361347]         ok 1 empty_template
[   84.367503]         ok 2 template_smaller_than_the_placeholder
[   84.372425]         ok 3 no_placeholder
[   84.379027]         ok 4 pen_placeholder_at_the_end_without_id
[   84.383660]         ok 5 frame_button_placeholder_at_the_end_without_id
[   84.390212]         ok 6 all_params_present_in_the_pen_template
[   84.397544]         ok 7 all_params_present_in_the_frame_template
[   84.404178]         ok 8 some_params_present_in_the_pen_template_with_complete_param_list
[   84.410967]         ok 9 some_params_present_in_the_pen_template_with_incomplete_param_list
[   84.419864]         ok 10 no_params_present_in_the_template
[   84.428832]     # hid_test_uclogic_template: pass:10 fail:0 skip:0 total:10
[   84.435058]     ok 1 hid_test_uclogic_template
[   84.442644] # Totals: pass:10 fail:0 skip:0 total:10
[   84.447741] ok 1 hid_uclogic_rdesc_test
[   84.463316] 2023-01-21 12:52:46 rmmod hid-uclogic-test

[   84.495988] 2023-01-21 12:52:46 modprobe iio-test-format

[   84.504792] calling  iio_init+0x0/0x1000 [industrialio] @ 797
[   84.511468] initcall iio_init+0x0/0x1000 [industrialio] returned 0 after 74 usecs
[   84.521723]     KTAP version 1
[   84.525435]     # Subtest: iio-format
[   84.525438]     1..6
[   84.529915]     ok 1 iio_test_iio_format_value_integer
[   84.533296]     ok 2 iio_test_iio_format_value_fixedpoint
[   84.539206]     ok 3 iio_test_iio_format_value_fractional
[   84.545348]     ok 4 iio_test_iio_format_value_fractional_log2
[   84.551515]     ok 5 iio_test_iio_format_value_multiple
[   84.558083]     ok 6 iio_test_iio_format_value_integer_64
[   84.563951] # iio-format: pass:6 fail:0 skip:0 total:6
[   84.569987] # Totals: pass:6 fail:0 skip:0 total:6
[   84.575764] ok 1 iio-format
[   84.590160] 2023-01-21 12:52:46 rmmod iio-test-format

[   84.618284] 2023-01-21 12:52:46 modprobe iio-test-rescale

[   84.626891] calling  rescale_driver_init+0x0/0x1000 [iio_rescale] @ 810
[   84.634282] initcall rescale_driver_init+0x0/0x1000 [iio_rescale] returned 0 after 127 usecs
[   84.645221]     KTAP version 1
[   84.648934]     # Subtest: iio-rescale
[   84.648936]     1..2
[   84.653332]         KTAP version 1
[   84.660248]         # Subtest: iio_rescale_test_scale
[   84.660403]         ok 1 typical IIO_VAL_INT, positive
[   84.666610]         ok 2 typical IIO_VAL_INT, negative
[   84.672481]         ok 3 typical IIO_VAL_FRACTIONAL, positive
[   84.678356]         ok 4 typical IIO_VAL_FRACTIONAL, negative
[   84.684810]         ok 5 typical IIO_VAL_FRACTIONAL_LOG2, positive
[   84.691353]         ok 6 typical IIO_VAL_FRACTIONAL_LOG2, negative
[   84.698334]         ok 7 typical IIO_VAL_INT_PLUS_NANO, positive
[   84.705260]         ok 8 typical IIO_VAL_INT_PLUS_NANO, negative
[   84.712000]         ok 9 typical IIO_VAL_INT_PLUS_MICRO, positive
[   84.718804]         ok 10 typical IIO_VAL_INT_PLUS_MICRO, negative
[   84.725681]         ok 11 small IIO_VAL_FRACTIONAL, 261/509 scaled by 90/1373754273
[   84.732646]         ok 12 small IIO_VAL_FRACTIONAL, 90/1373754273 scaled by 261/509
[   84.741054]         ok 13 small IIO_VAL_FRACTIONAL, 760/1373754273 scaled by 427/2727
[   84.749481]         ok 14 small IIO_VAL_FRACTIONAL, 761/1373754273 scaled by 427/2727
[   84.758056]         ok 15 small IIO_VAL_FRACTIONAL, 5/32768 scaled by 3/10000
[   84.766657]         ok 16 small IIO_VAL_FRACTIONAL, 0 < scale < 1
[   84.774562]         ok 17 small IIO_VAL_FRACTIONAL, -1 < scale < 0
[   84.781433]         ok 18 small IIO_VAL_FRACTIONAL, 0 < scale < 2
[   84.788393]         ok 19 small IIO_VAL_FRACTIONAL, -2 < scale < 0
[   84.795290]         ok 20 small IIO_VAL_FRACTIONAL_LOG2, 760/32768 scaled by 15/22
[   84.802263]         ok 21 small IIO_VAL_FRACTIONAL_LOG2, 761/32768 scaled by 15/22
[   84.810552]         ok 22 small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 1
[   84.818906]         ok 23 small IIO_VAL_FRACTIONAL_LOG2, -1 < scale < 0
[   84.826158]         ok 24 small IIO_VAL_FRACTIONAL_LOG2, 0 < scale < 2
[   84.833511]         ok 25 small IIO_VAL_FRACTIONAL_LOG2, -2 < scale < 0
[   84.840812]         ok 26 small IIO_VAL_INT_PLUS_MICRO, positive
[   84.848147]         ok 27 small IIO_VAL_INT_PLUS_MICRO, negative
[   84.854955]         ok 28 negative IIO_VAL_INT_PLUS_NANO, negative schan
[   84.861765]         ok 29 negative IIO_VAL_INT_PLUS_NANO, both negative
[   84.869263]         ok 30 negative IIO_VAL_INT_PLUS_NANO, 3 negative
[   84.876701]         ok 31 negative IIO_VAL_INT_PLUS_NANO, 4 negative
[   84.883828]         ok 32 negative IIO_VAL_INT_PLUS_NANO, negative, *val = 0
[   84.890963]         ok 33 decimal overflow IIO_VAL_INT_PLUS_NANO, positive
[   84.898769]         ok 34 decimal overflow IIO_VAL_INT_PLUS_NANO, negative
[   84.906401]         ok 35 decimal overflow IIO_VAL_INT_PLUS_NANO, negative schan
[   84.914061]         ok 36 decimal overflow IIO_VAL_INT_PLUS_MICRO, positive
[   84.922183]         ok 37 decimal overflow IIO_VAL_INT_PLUS_MICRO, negative
[   84.929931]         ok 38 decimal overflow IIO_VAL_INT_PLUS_MICRO, negative schan
[   84.937658]         ok 39 overflow IIO_VAL_FRACTIONAL, positive
[   84.945917]         ok 40 overflow IIO_VAL_FRACTIONAL, negative
[   84.952682]         ok 41 overflow IIO_VAL_FRACTIONAL_LOG2, positive
[   84.959474]         ok 42 overflow IIO_VAL_FRACTIONAL_LOG2, negative
[   84.966604]         ok 43 overflow IIO_VAL_INT_PLUS_NANO, positive
[   84.973761]         ok 44 overflow IIO_VAL_INT_PLUS_NANO, negative
[   84.980736]         ok 45 overflow IIO_VAL_INT_PLUS_NANO, negative schan
[   84.987706]         ok 46 overflow IIO_VAL_INT_PLUS_MICRO, positive
[   84.995140]         ok 47 overflow IIO_VAL_INT_PLUS_MICRO, negative
[   85.002150]         ok 48 overflow IIO_VAL_INT_PLUS_MICRO, negative schan
[   85.009047]     # iio_rescale_test_scale: pass:48 fail:0 skip:0 total:48
[   85.016468]     ok 1 iio_rescale_test_scale
[   85.023800]         KTAP version 1
[   85.032702]         # Subtest: iio_rescale_test_offset
[   85.032831]         ok 1 typical IIO_VAL_INT, positive
[   85.038770]         ok 2 typical IIO_VAL_INT, negative
[   85.044712]         ok 3 typical IIO_VAL_FRACTIONAL, positive
[   85.050639]         ok 4 typical IIO_VAL_FRACTIONAL, negative
[   85.057129]         ok 5 typical IIO_VAL_FRACTIONAL_LOG2, positive
[   85.063713]         ok 6 typical IIO_VAL_FRACTIONAL_LOG2, negative
[   85.070671]         ok 7 typical IIO_VAL_INT_PLUS_NANO, positive
[   85.077630]         ok 8 typical IIO_VAL_INT_PLUS_NANO, negative
[   85.084474]         ok 9 typical IIO_VAL_INT_PLUS_MICRO, positive
[   85.091307]         ok 10 typical IIO_VAL_INT_PLUS_MICRO, negative
[   85.098047]     # iio_rescale_test_offset: pass:10 fail:0 skip:0 total:10
[   85.104857]     ok 2 iio_rescale_test_offset
[   85.112267] # iio-rescale: pass:2 fail:0 skip:0 total:2
[   85.117188] # Totals: pass:58 fail:0 skip:0 total:58
[   85.123049] ok 1 iio-rescale
[   85.138552] 2023-01-21 12:52:46 rmmod iio-test-rescale

[   85.170571] 2023-01-21 12:52:46 modprobe overflow_kunit

[   85.179984]     KTAP version 1
[   85.183709]     # Subtest: overflow
[   85.183712]     1..21
[   85.188045]     # u8_u8__u8_overflow_test: 18 u8_u8__u8 arithmetic tests finished
[   85.199101]     ok 1 u8_u8__u8_overflow_test
[   85.199247]     # s8_s8__s8_overflow_test: 19 s8_s8__s8 arithmetic tests finished
[   85.212298]     ok 2 s8_s8__s8_overflow_test
[   85.212452]     # u16_u16__u16_overflow_test: 17 u16_u16__u16 arithmetic tests finished
[   85.225995]     ok 3 u16_u16__u16_overflow_test
[   85.226076]     # s16_s16__s16_overflow_test: 17 s16_s16__s16 arithmetic tests finished
[   85.239908]     ok 4 s16_s16__s16_overflow_test
[   85.239997]     # u32_u32__u32_overflow_test: 17 u32_u32__u32 arithmetic tests finished
[   85.253802]     ok 5 u32_u32__u32_overflow_test
[   85.253959]     # s32_s32__s32_overflow_test: 17 s32_s32__s32 arithmetic tests finished
[   85.267757]     ok 6 s32_s32__s32_overflow_test
[   85.267882]     # u64_u64__u64_overflow_test: 17 u64_u64__u64 arithmetic tests finished
[   85.281737]     ok 7 u64_u64__u64_overflow_test
[   85.281896]     # s64_s64__s64_overflow_test: 21 s64_s64__s64 arithmetic tests finished
[   85.295690]     ok 8 s64_s64__s64_overflow_test
[   85.295828]     # u32_u32__int_overflow_test: 2 u32_u32__int arithmetic tests finished
[   85.309593]     ok 9 u32_u32__int_overflow_test
[   85.309730]     # u32_u32__u8_overflow_test: 3 u32_u32__u8 arithmetic tests finished
[   85.323317]     ok 10 u32_u32__u8_overflow_test
[   85.323471]     # u8_u8__int_overflow_test: 3 u8_u8__int arithmetic tests finished
[   85.336832]     ok 11 u8_u8__int_overflow_test
[   85.336954]     # int_int__u8_overflow_test: 3 int_int__u8 arithmetic tests finished
[   85.350403]     ok 12 int_int__u8_overflow_test
[   85.350531]     # shift_sane_test: 36 sane shift tests finished
[   85.362268]     ok 13 shift_sane_test
[   85.362400]     # shift_overflow_test: 25 overflow shift tests finished
[   85.373986]     ok 14 shift_overflow_test
[   85.374087]     # shift_truncate_test: 27 truncate shift tests finished
[   85.386013]     ok 15 shift_truncate_test
[   85.386131]     # shift_nonsense_test: 25 nonsense shift tests finished
[   85.398053]     ok 16 shift_nonsense_test
[   85.398334]     # overflow_allocation_test: 11 allocation overflow tests finished
[   85.411116]     ok 17 overflow_allocation_test
[   85.411261]     # overflow_size_helpers_test: 43 overflow size helper tests finished
[   85.424715]     ok 18 overflow_size_helpers_test
[   85.424836]     # overflows_type_test: 658 overflows_type() tests finished
[   85.437608]     ok 19 overflows_type_test
[   85.437759]     # same_type_test: 0 __same_type() tests finished
[   85.449071]     ok 20 same_type_test
[   85.449151]     # castable_to_type_test: 103 castable_to_type() tests finished
[   85.461262]     ok 21 castable_to_type_test
[   85.461267] # overflow: pass:21 fail:0 skip:0 total:21
[   85.466119] # Totals: pass:21 fail:0 skip:0 total:21
[   85.471900] ok 1 overflow
[   85.487121] 2023-01-21 12:52:47 rmmod overflow_kunit

[   85.527485] 2023-01-21 12:52:47 modprobe snd-soc-avs-i2s-test

[   85.536338] calling  init_soundcore+0x0/0x1000 [soundcore] @ 906
[   85.543042] initcall init_soundcore+0x0/0x1000 [soundcore] returned 0 after 61 usecs
[   85.558294] calling  alsa_sound_init+0x0/0x8c [snd] @ 906
[   85.564400] initcall alsa_sound_init+0x0/0x8c [snd] returned 0 after 56 usecs
[   85.575603] calling  alsa_timer_init+0x0/0x1000 [snd_timer] @ 906
[   85.582496] initcall alsa_timer_init+0x0/0x1000 [snd_timer] returned 0 after 169 usecs
[   85.599753] calling  alsa_pcm_init+0x0/0x1000 [snd_pcm] @ 906
[   85.606156] initcall alsa_pcm_init+0x0/0x1000 [snd_pcm] returned 0 after 20 usecs
[   85.635411] calling  snd_soc_init+0x0/0x9b [snd_soc_core] @ 906
[   85.642422] initcall snd_soc_init+0x0/0x9b [snd_soc_core] returned 0 after 440 usecs
[   85.652486] calling  avs_i2s_test_driver_init+0x0/0x1000 [snd_soc_avs_i2s_test] @ 906
[   85.661004] initcall avs_i2s_test_driver_init+0x0/0x1000 [snd_soc_avs_i2s_test] returned 0 after 69 usecs
[   85.677053] 2023-01-21 12:52:47 rmmod snd-soc-avs-i2s-test

[   85.717205] 2023-01-21 12:52:47 modprobe soc-utils-test

[   85.725643]     KTAP version 1
[   85.729370]     # Subtest: soc-utils
[   85.729374]     1..2
[   85.733841]     ok 1 test_tdm_params_to_bclk
[   85.736906]     ok 2 test_snd_soc_params_to_bclk
[   85.742103] # soc-utils: pass:2 fail:0 skip:0 total:2
[   85.747368] # Totals: pass:2 fail:0 skip:0 total:2
[   85.753070] ok 1 soc-utils
[   85.767216] 2023-01-21 12:52:47 rmmod soc-utils-test

[   85.798223] 2023-01-21 12:52:47 modprobe stackinit_kunit

[   85.806993]     KTAP version 1
[   85.810706]     # Subtest: stackinit
[   85.810708]     1..65
[   85.815077]     ok 1 test_u8_zero
[   85.818253]     ok 2 test_u16_zero
[   85.822648]     ok 3 test_u32_zero
[   85.826873]     ok 4 test_u64_zero
[   85.831051]     ok 5 test_char_array_zero
[   85.835202]     ok 6 test_small_hole_zero
[   85.839978]     ok 7 test_big_hole_zero
[   85.844735]     ok 8 test_trailing_hole_zero
[   85.849359]     ok 9 test_packed_zero
[   85.854397]     ok 10 test_small_hole_dynamic_partial
[   85.858867]     ok 11 test_big_hole_dynamic_partial
[   85.864710]     ok 12 test_trailing_hole_dynamic_partial
[   85.870347]     ok 13 test_packed_dynamic_partial
[   85.876426]     ok 14 test_small_hole_assigned_dynamic_partial
[   85.881923]     ok 15 test_big_hole_assigned_dynamic_partial
[   85.888516]     ok 16 test_trailing_hole_assigned_dynamic_partial
[   85.894958]     ok 17 test_packed_assigned_dynamic_partial
[   85.901829]     ok 18 test_small_hole_static_partial
[   85.908065]     ok 19 test_big_hole_static_partial
[   85.913823]     ok 20 test_trailing_hole_static_partial
[   85.919424]     ok 21 test_packed_static_partial
[   85.925409]     ok 22 test_small_hole_static_all # SKIP XFAIL uninit bytes: 3
[   85.938509]     ok 23 test_big_hole_static_all # SKIP XFAIL uninit bytes: 124
[   85.946378]     ok 24 test_trailing_hole_static_all # SKIP XFAIL uninit bytes: 7
[   85.954504]     ok 25 test_packed_static_all
[   85.954595]     ok 26 test_small_hole_dynamic_all # SKIP XFAIL uninit bytes: 3
[   85.967442]     ok 27 test_big_hole_dynamic_all # SKIP XFAIL uninit bytes: 124
[   85.975439]     ok 28 test_trailing_hole_dynamic_all # SKIP XFAIL uninit bytes: 7
[   85.983685]     ok 29 test_packed_dynamic_all
[   85.983795]     ok 30 test_small_hole_runtime_partial # SKIP XFAIL uninit bytes: 23
[   85.997120]     ok 31 test_big_hole_runtime_partial # SKIP XFAIL uninit bytes: 127
[   86.005461]     ok 32 test_trailing_hole_runtime_partial # SKIP XFAIL uninit bytes: 24
[   86.014064]     ok 33 test_packed_runtime_partial # SKIP XFAIL uninit bytes: 24
[   86.022063]     ok 34 test_small_hole_runtime_all # SKIP XFAIL uninit bytes: 3
[   86.029983]     ok 35 test_big_hole_runtime_all # SKIP XFAIL uninit bytes: 124
[   86.037962]     ok 36 test_trailing_hole_runtime_all # SKIP XFAIL uninit bytes: 7
[   86.046125]     ok 37 test_packed_runtime_all
[   86.046266]     ok 38 test_small_hole_assigned_static_partial
[   86.051366]     ok 39 test_big_hole_assigned_static_partial
[   86.057973]     ok 40 test_trailing_hole_assigned_static_partial
[   86.064310]     ok 41 test_packed_assigned_static_partial
[   86.071044]     ok 42 test_small_hole_assigned_static_all # SKIP XFAIL uninit bytes: 3
[   86.085672]     ok 43 test_big_hole_assigned_static_all # SKIP XFAIL uninit bytes: 124
[   86.094315]     ok 44 test_trailing_hole_assigned_static_all # SKIP XFAIL uninit bytes: 7
[   86.103160]     ok 45 test_packed_assigned_static_all
[   86.103244]     ok 46 test_small_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 3
[   86.117627]     ok 47 test_big_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 124
[   86.126414]     ok 48 test_trailing_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 7
[   86.135439]     ok 49 test_packed_assigned_dynamic_all
[   86.135530]     ok 50 test_small_hole_assigned_copy # SKIP XFAIL uninit bytes: 3
[   86.149497]     ok 51 test_big_hole_assigned_copy # SKIP XFAIL uninit bytes: 124
[   86.157663]     ok 52 test_trailing_hole_assigned_copy # SKIP XFAIL uninit bytes: 7
[   86.166061]     ok 53 test_packed_assigned_copy
[   86.166127]     ok 54 test_u8_none # SKIP XFAIL uninit bytes: 1
[   86.177986]     ok 55 test_u16_none # SKIP XFAIL uninit bytes: 2
[   86.184743]     ok 56 test_u32_none # SKIP XFAIL uninit bytes: 4
[   86.191463]     ok 57 test_u64_none # SKIP XFAIL uninit bytes: 8
[   86.198201]     ok 58 test_char_array_none # SKIP XFAIL uninit bytes: 16
[   86.205597]     ok 59 test_switch_1_none # SKIP XFAIL uninit bytes: 80
[   86.212856]     ok 60 test_switch_2_none # SKIP XFAIL uninit bytes: 80
[   86.220137]     ok 61 test_small_hole_none # SKIP XFAIL uninit bytes: 24
[   86.227630]     ok 62 test_big_hole_none # SKIP XFAIL uninit bytes: 128
[   86.235028]     ok 63 test_trailing_hole_none # SKIP XFAIL uninit bytes: 32
[   86.242775]     ok 64 test_packed_none # SKIP XFAIL uninit bytes: 32
[   86.249917]     ok 65 test_user # SKIP XFAIL uninit bytes: 32
[   86.256302] # stackinit: pass:31 fail:0 skip:34 total:65
[   86.256317] # Totals: pass:31 fail:0 skip:34 total:65
[   86.262275] ok 1 stackinit
[   86.277577] 2023-01-21 12:52:48 rmmod stackinit_kunit


--jA4K3bP4o8S3U350
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kunit.yaml
suite: kunit
testcase: kunit
category: functional
kunit:
  group: group-02
job_origin: kunit.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-hsw-d03
tbox_group: lkp-hsw-d03
submit_id: 63cbc78750daa652bb923f6a
job_file: "/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-21179-q1mfdh-0.yaml"
id: 2ef0d9bba1df20300bae566a9743ec1c87383133
queuer_version: "/zday/lkp"

#! hosts/lkp-hsw-d03
model: Haswell
nr_node: 1
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST31000524AS_6VPHDMY6-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G6_BTWA6075012T480FGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G6_BTWA6075012T480FGN-part2"
brand: Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/queue/cyclic
commit: cc3ff324b29f06b124b57f745fcc4ec624c87d16

#! include/testbox/lkp-hsw-d03
ucode: '0x28'
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
bisect_dmesg: true

#! include/kunit
need_kconfig:
- BINFMT_ELF_KUNIT_TEST: y
- CLK_GATE_KUNIT_TEST: m
- CLK_KUNIT_TEST: m
- CPUMASK_KUNIT_TEST: m
- CHROME_PLATFORMS: y
- CROS_EC: m
- CROS_KUNIT: m
- FIPS_SIGNATURE_SELFTEST: y
- FPROBE: y
- FPROBE_SANITY_TEST: y
- HID_UCLOGIC: m
- HID_KUNIT_TEST: m
- IIO: m
- IIO_FORMAT_KUNIT_TEST: m
- IIO_RESCALE: m
- IIO_RESCALE_KUNIT_TEST: m
- OVERFLOW_KUNIT_TEST: m
- SOUND: m
- SND: m
- SND_SOC: m
- SND_SOC_INTEL_AVS: m
- SND_SOC_INTEL_AVS_MACH_I2S_TEST: m
- SND_SOC_UTILS_KUNIT_TEST: m
- STACKINIT_KUNIT_TEST: m
kconfig: x86_64-rhel-8.3-kunit
enqueue_time: 2023-01-21 19:07:51.500554227 +08:00
_id: 63cbc78750daa652bb923f6a
_rt: "/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 7d54d3fcdaa6c8e053ed21160dd229cae8681ae4
base_commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
branch: linux-devel/devel-hourly-20230119-184644
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kunit/group-02/lkp-hsw-d03/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f
- branch=linux-devel/devel-hourly-20230119-184644
- job=/lkp/jobs/scheduled/lkp-hsw-d03/kunit-group-02-debian-11.1-x86_64-20220510.cgz-cc3ff324b29f06b124b57f745fcc4ec624c87d16-20230121-21179-q1mfdh-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kunit
- commit=cc3ff324b29f06b124b57f745fcc4ec624c87d16
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230119125122/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.1.0-rc4-00067-gc771b4eabd6a
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kunit/gcc-11/cc3ff324b29f06b124b57f745fcc4ec624c87d16/vmlinuz-6.2.0-rc1-00001-gcc3ff324b29f"
dequeue_time: 2023-01-21 19:40:33.533439791 +08:00

#! /db/releases/20230121104353/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 5.48 1.81 0.64 1/179 1072
start_time: '1674301623'
end_time: '1674301628'
version: "/lkp/lkp/.src-20230120-005110:3637c1aba:678144fc5"

--jA4K3bP4o8S3U350
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

modprobe clk-gate_test
rmmod clk-gate_test
modprobe clk_test
rmmod clk_test
modprobe cpumask_kunit
rmmod cpumask_kunit
modprobe cros_kunit
rmmod cros_kunit
modprobe hid-uclogic-test
rmmod hid-uclogic-test
modprobe iio-test-format
rmmod iio-test-format
modprobe iio-test-rescale
rmmod iio-test-rescale
modprobe overflow_kunit
rmmod overflow_kunit
modprobe snd-soc-avs-i2s-test
rmmod snd-soc-avs-i2s-test
modprobe soc-utils-test
rmmod soc-utils-test
modprobe stackinit_kunit
rmmod stackinit_kunit

--jA4K3bP4o8S3U350--
