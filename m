Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F027025A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbjEOHEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjEOHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:04:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34BE71
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684134256; x=1715670256;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FG8uvBZ7gkdjn8249pZ0ruAekPviQHSKg/K39zaxYik=;
  b=NNmycSTF0DbSKYpw9G9Eijx3k1fviHPQru7mEjxzjFZTvu48GvHtQNH+
   26WTm5+bAwjzrvuo79ws806NoDvlsr6e4OzcMXx8NM2eGc5s7eF164y26
   AZIpj5y7wySiuWvUcRB/ZytbqhlASEQSE54LVLqmuGiuS0tb/bJ/z6gMC
   8PhbeRgjPZMzUs7Rzgs6kvLrX6LuJu082Jh2yuXcIBN347Xz+PFg6X4fQ
   F/o+VK2oO7Kl+GncjydNt1Lv2WZQ1f4kPcasoCero7woHQy6eZoimek4C
   lC6cIx3TVWtXwt/i1DDcJ146PcYPHUClusJ2c9R3kmjFWQe02nPAKwqp7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="348624992"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="yaml'?scan'208";a="348624992"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 00:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="733752759"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="yaml'?scan'208";a="733752759"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2023 00:04:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 00:04:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 00:04:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 00:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwdTacmSQ3lmYnMHDHOCX14pmyXxQw3SHjwhqJcg1QJ9klzA8wNO717forz8qSx7ISUfL4yRApQFxaA4bz/McATmETKZXO4RUmHPsArNrURMvAi34LmkGOSgPXPIKL/hWtBNmWtMwz0NBHkRTxj5qXdjicUw9Ptn4yU11U5ejx+GpK/ltsLUql3MzLdP9RWk3+X9z1X6yFNAx49hbmqi3hv8alm+uwFFPd5EZlb7pYaRl/W5oCYmmvGHmU2jh94OQZKxsu645lR+CDqToRJKDcLt+tGEpa0t70NNLNN0H/imd2zVm8GLMhU5Gk6cFuMzaMDAOkWf5wmFVDDgSNTIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upax4rrf1lWxvg5pA36i1PdqlKVyeH8iwxj/DtCdRnY=;
 b=TMytKJ84F6DQPNUDj1luhYqdkgLe2O7pVW4WTTvePrFTjbcAX7iVByeeFqIy8kD1Mrp9MpQQ56ojP+cDHyifRWDdicm3lGbss4o0RlUV2AkpdInKArVg4LJ5iB6VfrFT197F0o8fUfrb6wZ4iioiE188stS6CNrGhO4lcvK5b0UJ5otkM8TVxC6K5ZutQqwrB78rg2cjprAIrUgJTA6jPLBjPDCkTe2RoogLIiZXFVBQ7MvHmAQNKBwpVdz5wvBV2jjgihQ0jgDUpwQC29jAiDuaOdPWaRTdR3zUUtHRWQdhr9j9F81gM0YF4ccWuKucpv1tGuqozxArJ41xefZc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB7739.namprd11.prod.outlook.com (2603:10b6:8:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:04:06 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:04:05 +0000
Date:   Mon, 15 May 2023 15:00:44 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>
Subject: [linus:master] [sched] af7f588d8f: will-it-scale.per_thread_ops
 -13.9% regression
Message-ID: <202305151017.27581d75-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="znh8I0flPXpWTU/f"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab5e4ee-e74a-4153-4580-08db551291b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ai9VY9Bzwj1izfJB/ip3u/LeyBo8FpIC2kIN80oFAuFkBCQaDI3hR0x2W6p7D53t9pbRQcQQ7yhBK23fIT0vozuoYloVwbAg15Z4iVdWti7y0igI0nmzGEVmB2T1wyG0P03y/1SqQtHG9CTYmDZ+JxHNaHhRpJDuyUXg5E1Y+s+BnLgDnPrNzubWqA+hl0Z2+wFBBxOfJrY8npnEnypONQlDui0S2vxJWsmaRdspDO/SKupisOhViY7Y3RBgx5j/qKzrWUsZ6OeH2Vn5Uf39udzl2jQ71EmAKXLizF5XzWeZR3ueDkTmBNywiHwPaUPrY68PPwjYIbrjpubTaK2EVBB4dIXI+tKIkbxw4ONffymQ+iNdSg6dxxogw0zuiwboPRNaOY6T3OdqP8/BLITViTkXONh44cG6q87jDkCoR7ZHRrLubillZZeCLjtfHf6mGNC6O0qYs0PgTx9jQLU+RR6n3E6TCBci/lCBCmz14j1iiYnsocwZhkwNQMq8jRaNBjFCAuUtHFrTW66/Cg9M+zWA64H3iRHJAk7iD0y9Di3zsgf5ci9qFxPRu0v3ODVjMLvARz4mTVNEgdKHnqrKC9lfF4UicNg9nE/JzkBYtPX0ze6FR5AS0A6ZY3BLcECi5IZu4qyRaHIA02Ptt5jWfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(6512007)(6506007)(1076003)(26005)(83380400001)(41300700001)(38100700002)(6486002)(966005)(44144004)(21490400003)(6666004)(186003)(2616005)(54906003)(19627235002)(478600001)(66556008)(66946007)(6916009)(66476007)(82960400001)(4326008)(316002)(235185007)(5660300002)(8676002)(8936002)(86362001)(30864003)(2906002)(36756003)(2700100001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SfUXTdPzyL1CafDzVeMIxYx3qdUi6YVS0NlsTjmOfjS0MgNExBQhJ763+M?=
 =?iso-8859-1?Q?30OTJ9YmZnGSKpsyc+hSyLaVGot26QsP/9/w9grwihl7Cw9AhWPMSfTMDp?=
 =?iso-8859-1?Q?LPDfCrafZHVBAgnooaF2wDqBfOutTmw6F021yS/0RQEmsXR/kIiT6a99hD?=
 =?iso-8859-1?Q?7zc3U176ND/K8b1ihWUDn5ol1zhnBuMxNcMt7P/0f0mIcjeTOXvHhToeLS?=
 =?iso-8859-1?Q?dUXPhC4S5ezLCAyEkJ4LdkPxgwmb8px1QR44Tby2iViHQbqJEykZj435TS?=
 =?iso-8859-1?Q?GBMYFjJHCq69MM3oNuZA89PJbd2DODIELH6vFBYozRgCY26sweRi92vxbV?=
 =?iso-8859-1?Q?bY5HINKqGOlpD8c2f0jmUd6qZjx7ZMGuxWBfGGjLzDDd8kqlE43DPCv9DI?=
 =?iso-8859-1?Q?/+KJKt6B44euh7Rg3FH2OJsATvxGmqQnc7/OQByL53CJC5Zk3qsaYMidvM?=
 =?iso-8859-1?Q?mOz4V6oxKqwM/gLEg7yAE9ysMQjXHGnQOienJixILybZWXZsLNGsfzSwf+?=
 =?iso-8859-1?Q?8qNUCRRqV7/BXzl2cgAylFrpucjqfIT5ugU7bgnx2yYYqfA1CG0aZBRiCd?=
 =?iso-8859-1?Q?tiGwv2fa0ll2joEuttp4ISb9RQpxx9pevWNPuGL9fx0nCNvfeBuEHMBAHE?=
 =?iso-8859-1?Q?514hI0Bju/mMXNyXisJfKsXQukEWKCCVskggKLAUTgZ/9Jk9gMpGE230Ej?=
 =?iso-8859-1?Q?dVYrbyLTeF8rLZMQZjr0iBeocFHcvNbzlJ79YY1wEty6bKmvijtKImo5zj?=
 =?iso-8859-1?Q?C1ZxDiqkkFbX55smpnq9/gW4+HEXq7Onorb3xFwvlcNCOenj5D+bGkl79/?=
 =?iso-8859-1?Q?KV3clQz+sJFjAqYUZuKV5/WZbUJySddnzhfdpusaG7wcSI0XenRp+IShVq?=
 =?iso-8859-1?Q?nCFSfKqFB9BHyG7PGnQAmmmnSz1BKfNUS9H3ULAa4OsNmTJTQ65lZBAaSk?=
 =?iso-8859-1?Q?eLUHoEt9Mnu8OPuO/4MwKyNZMy0tsaldVNtBn9aKGI3EtvTCHqWaO+KT7G?=
 =?iso-8859-1?Q?3vFbQGWRuQPjmjyCynnc2OPTUVxX5zBVRIOpbRs7E0Ti3JODrcGGWYT5tZ?=
 =?iso-8859-1?Q?yen0AE60heQMk62HeB6THHvvcJ1+hXl5i9i0Y6IrAN6APO1xTGQOj8RnoX?=
 =?iso-8859-1?Q?h2FzZ3s2VXIn+ijoGWp9VuE05mAe8FMoOXL+pIVX3T2oznewAIG3wXOp7M?=
 =?iso-8859-1?Q?IwqTKqFCNzr8JGoj9OiIpu85YsCg0HBsMrsCJG5jIP9UxbBz94rZRF9JQY?=
 =?iso-8859-1?Q?X+6oQ3WKLlrERdj7FnzCGcCewyvSaCGEIbS94HDiJe/7LXxhd23vlIAHpb?=
 =?iso-8859-1?Q?YXfIGTocxU8dI4Fy198kIgSja7xUnyJP4wlHSDd3+Ch7VHCR6G8dU9xTFY?=
 =?iso-8859-1?Q?V8IDaXThD76cFAP7Fy+XCGaQpm9P8X04m/tNBclsOLm+tKkPbzLripgKU0?=
 =?iso-8859-1?Q?PpRrx+Kc331fj6kzZ27uGnEBGeUZfuEGZh4lA5oLrA+XYXvv7WymMXgii4?=
 =?iso-8859-1?Q?62o8sNUWoEqjpRHEMjIOnc+PsIagZxeY2ZCcQi/zzmepgebK6uoa2NHKHX?=
 =?iso-8859-1?Q?gLL39msDqlKeEvhYMg58VyqAtesijSIWWGJ0nvpnaDy6oQNQ3oy/F5cr61?=
 =?iso-8859-1?Q?eIV6Tdc52lbEsLFNRV+3vdrlXNLTIYjwge?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab5e4ee-e74a-4153-4580-08db551291b2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 07:04:05.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5kyUe1z+pja/p5z9Gp9oid+1eaAUwq0IeCIbKEoYcL7cvLvCQ6CEZBSKQZoyg5JK1efXx14eS9+WiLDxh/9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7739
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--znh8I0flPXpWTU/f
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

kernel test robot noticed a -13.9% regression of will-it-scale.per_thread_ops on:

commit: af7f588d8f7355bc4298dd1962d7826358fc95f0 ("sched: Introduce per-memory-map concurrency ID")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 224 threads 2 sockets (Sapphire Rapids) with 256G memory
parameters:

	test: context_switch1
	cpufreq_governor: performance

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -73.8% regression                                      |
| test machine     | 224 threads 2 sockets (Sapphire Rapids) with 256G memory                                           |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=16                                                                                         |
|                  | test=context_switch1                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -57.9% regression                                      |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=16                                                                                         |
|                  | test=context_switch1                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -85.0% regression                                      |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=thread                                                                                        |
|                  | nr_task=50%                                                                                        |
|                  | test=context_switch1                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput -9.0% regression                                         |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | runtime=300s                                                                                       |
|                  | size=2T                                                                                            |
|                  | test=shm-xread-seq-mt                                                                              |
+------------------+----------------------------------------------------------------------------------------------------+

FYI, we noticed that commit 223baf9d17f2 (sched: Fix performance
regression introduced by mm_cid) fixed a sysbench regression, but
will-it-scale context_switch1 benchmark still saw a regression on this
fix commit.

Furthermore, we applied the code diff in below link [1] on mainline, and
the will-it-scale score was restored to the original level before this
patch.

[1] https://lore.kernel.org/lkml/d96164a6-c522-1bfc-8b37-333726cdc573@efficios.com/


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com


Details are as below:

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/context_switch1/will-it-scale

commit: 
  99babd04b2 ("selftests/rseq: Implement rseq numa node id field selftest")
  af7f588d8f ("sched: Introduce per-memory-map concurrency ID")

99babd04b2505471 af7f588d8f7355bc4298dd1962d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    629260            -1.2%     621753        will-it-scale.1.linear
    629260            -1.2%     621753        will-it-scale.1.processes
    613314            -1.5%     604163        will-it-scale.1.threads
  70477120            -1.2%   69636432        will-it-scale.112.linear
   5615798 ±  4%     -72.0%    1571768 ±  3%  will-it-scale.112.threads
     24.94 ±  2%     -90.0%       2.50 ±  4%  will-it-scale.112.threads_idle
 1.057e+08            -1.2%  1.045e+08        will-it-scale.168.linear
  56978825           -20.6%   45250154 ±  2%  will-it-scale.168.threads
      7.49           -73.8%       1.96 ± 28%  will-it-scale.168.threads_idle
  1.41e+08            -1.2%  1.393e+08        will-it-scale.224.linear
  95368601            +1.9%   97207305        will-it-scale.224.processes
 1.082e+08            +1.4%  1.097e+08        will-it-scale.224.threads
  35238560            -1.2%   34818216        will-it-scale.56.linear
   8809640 ±  2%     -76.2%    2092567        will-it-scale.56.threads
     68.53            -3.4%      66.22        will-it-scale.56.threads_idle
    328629           -13.9%     282968        will-it-scale.per_thread_ops
      0.68            +3.2%       0.70        will-it-scale.scalability
 4.074e+08 ± 12%     -37.1%  2.564e+08 ±  8%  will-it-scale.time.involuntary_context_switches
     17476            +1.4%      17713        will-it-scale.time.system_time
      1623           -15.7%       1369        will-it-scale.time.user_time
 6.135e+09            -8.6%  5.607e+09        will-it-scale.time.voluntary_context_switches
 4.584e+08            -4.2%   4.39e+08        will-it-scale.workload
 4.804e+09           -13.3%  4.166e+09        cpuidle..usage
      0.12 ±  4%      -0.0        0.09 ±  3%  mpstat.cpu.all.soft%
  22357676           -62.5%    8384327 ±  4%  vmstat.memory.cache
  59747111            -6.3%   55960083        vmstat.system.cs
    433036 ± 12%    +511.7%    2648925 ± 42%  numa-numastat.node0.local_node
    572995 ± 11%    +391.1%    2814064 ± 39%  numa-numastat.node0.numa_hit
   8059420           -69.0%    2496648 ± 43%  numa-numastat.node1.local_node
   8122292           -68.6%    2550541 ± 42%  numa-numastat.node1.numa_hit
 2.202e+08 ±  5%     -82.0%   39691191 ± 11%  turbostat.C1
      0.93 ±  5%      -0.8        0.09 ± 14%  turbostat.C1%
 1.101e+08 ±  2%     -56.5%   47858373        turbostat.C1E
      3.22            -0.5        2.73        turbostat.POLL%
    231050         +1893.9%    4607008 ±  4%  meminfo.Active
    230970         +1894.6%    4606928 ±  4%  meminfo.Active(anon)
    219559 ±  5%     -22.6%     170030 ± 15%  meminfo.AnonHugePages
    572890           -24.2%     434172        meminfo.AnonPages
  21995823           -62.4%    8263088 ±  4%  meminfo.Cached
  25221015           -55.0%   11347952 ±  3%  meminfo.Committed_AS
  19440153           -93.9%    1192582 ± 23%  meminfo.Inactive
  19440011           -93.9%    1192439 ± 23%  meminfo.Inactive(anon)
    214830           -14.7%     183232        meminfo.KReclaimable
  25424026           -56.0%   11175036 ±  3%  meminfo.Memused
    214830           -14.7%     183232        meminfo.SReclaimable
  19098913           -71.9%    5366191 ±  6%  meminfo.Shmem
  25832239           -34.2%   16986009        meminfo.max_used_kB
    110043 ± 15%     -88.5%      12679 ± 98%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   2804771 ±  2%     -69.8%     846737 ± 85%  sched_debug.cfs_rq:/.MIN_vruntime.max
    504968 ±  9%     -82.6%      88033 ± 76%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    110043 ± 15%     -88.5%      12679 ± 98%  sched_debug.cfs_rq:/.max_vruntime.avg
   2804771 ±  2%     -69.8%     846738 ± 85%  sched_debug.cfs_rq:/.max_vruntime.max
    504968 ±  9%     -82.6%      88033 ± 76%  sched_debug.cfs_rq:/.max_vruntime.stddev
    854772 ±  2%     +12.8%     964472 ±  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
     73087 ± 59%    +734.2%     609692 ± 44%  sched_debug.cfs_rq:/.spread0.max
    861849 ±  2%     +12.1%     966253 ±  2%  sched_debug.cfs_rq:/.spread0.stddev
    322.78 ±  2%     -14.0%     277.54 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    470921 ±  4%     +11.5%     525288 ±  4%  sched_debug.cpu.avg_idle.avg
     10146 ± 89%    +197.5%      30184 ± 27%  sched_debug.cpu.avg_idle.min
    166.82 ± 15%     -82.9%      28.54 ±  6%  sched_debug.cpu.clock.stddev
      0.00 ± 15%     -78.3%       0.00 ± 16%  sched_debug.cpu.next_balance.stddev
  29334462            -9.5%   26550823        sched_debug.cpu.nr_switches.avg
   9400046           -12.1%    8262067        sched_debug.cpu.nr_switches.stddev
      1494 ± 50%  +1.6e+05%    2458393 ± 56%  numa-meminfo.node0.Active
      1459 ± 53%  +1.7e+05%    2458381 ± 56%  numa-meminfo.node0.Active(anon)
    193090 ± 23%    +315.9%     803087 ± 36%  numa-meminfo.node0.Inactive
    193026 ± 23%    +316.0%     803069 ± 36%  numa-meminfo.node0.Inactive(anon)
      9933 ±  9%     +50.4%      14936 ±  4%  numa-meminfo.node0.PageTables
      6124 ± 15%  +49221.4%    3020604 ± 55%  numa-meminfo.node0.Shmem
    229095          +841.3%    2156586 ± 64%  numa-meminfo.node1.Active
    229051          +841.5%    2156518 ± 64%  numa-meminfo.node1.Active(anon)
    145346 ± 16%     -45.5%      79245 ± 34%  numa-meminfo.node1.AnonHugePages
    383868 ± 12%     -49.7%     192976 ± 22%  numa-meminfo.node1.AnonPages
  19095555           -87.0%    2485880 ± 58%  numa-meminfo.node1.FilePages
  19201636           -98.0%     390419 ± 19%  numa-meminfo.node1.Inactive
  19201557           -98.0%     390295 ± 19%  numa-meminfo.node1.Inactive(anon)
    102686 ±  9%     -34.7%      67069 ± 15%  numa-meminfo.node1.KReclaimable
   2789340 ±  3%     -49.4%    1410452 ± 52%  numa-meminfo.node1.Mapped
 1.113e+08           +15.3%  1.283e+08        numa-meminfo.node1.MemFree
  20783078           -81.8%    3782627 ± 38%  numa-meminfo.node1.MemUsed
     16570 ±  5%     -38.1%      10254 ±  7%  numa-meminfo.node1.PageTables
    102686 ±  9%     -34.7%      67069 ± 15%  numa-meminfo.node1.SReclaimable
  19047079           -87.6%    2354397 ± 60%  numa-meminfo.node1.Shmem
    282546 ±  6%     -14.1%     242658 ±  7%  numa-meminfo.node1.Slab
    364.56 ± 53%  +1.7e+05%     615291 ± 56%  numa-vmstat.node0.nr_active_anon
     48203 ± 23%    +317.2%     201111 ± 35%  numa-vmstat.node0.nr_inactive_anon
      2477 ± 10%     +50.9%       3738 ±  4%  numa-vmstat.node0.nr_page_table_pages
      1530 ± 15%  +49298.5%     756126 ± 55%  numa-vmstat.node0.nr_shmem
    364.56 ± 53%  +1.7e+05%     615292 ± 56%  numa-vmstat.node0.nr_zone_active_anon
     48203 ± 23%    +317.2%     201111 ± 35%  numa-vmstat.node0.nr_zone_inactive_anon
    573038 ± 11%    +390.9%    2813153 ± 39%  numa-vmstat.node0.numa_hit
    433108 ± 12%    +511.4%    2648015 ± 42%  numa-vmstat.node0.numa_local
     57253          +843.2%     540005 ± 64%  numa-vmstat.node1.nr_active_anon
     95911 ± 12%     -49.6%      48299 ± 22%  numa-vmstat.node1.nr_anon_pages
   4773715           -87.0%     622469 ± 58%  numa-vmstat.node1.nr_file_pages
  27815434           +15.3%   32063992        numa-vmstat.node1.nr_free_pages
   4800160           -98.0%      97769 ± 19%  numa-vmstat.node1.nr_inactive_anon
    697703 ±  3%     -49.3%     353752 ± 52%  numa-vmstat.node1.nr_mapped
      4135 ±  5%     -37.9%       2567 ±  7%  numa-vmstat.node1.nr_page_table_pages
   4761596           -87.6%     589599 ± 60%  numa-vmstat.node1.nr_shmem
     25670 ±  9%     -34.7%      16769 ± 15%  numa-vmstat.node1.nr_slab_reclaimable
     57253          +843.2%     540006 ± 64%  numa-vmstat.node1.nr_zone_active_anon
   4800159           -98.0%      97769 ± 19%  numa-vmstat.node1.nr_zone_inactive_anon
   8122528           -68.6%    2548812 ± 42%  numa-vmstat.node1.numa_hit
   8059656           -69.0%    2494919 ± 43%  numa-vmstat.node1.numa_local
     57680         +1900.0%    1153633 ±  4%  proc-vmstat.nr_active_anon
    143171           -24.2%     108550        proc-vmstat.nr_anon_pages
   5919284            +6.0%    6274221        proc-vmstat.nr_dirty_background_threshold
  11853042            +6.0%   12563784        proc-vmstat.nr_dirty_threshold
   5493638           -62.4%    2067724 ±  4%  proc-vmstat.nr_file_pages
  59564263            +6.0%   63118840        proc-vmstat.nr_free_pages
   4854706           -93.9%     298169 ± 23%  proc-vmstat.nr_inactive_anon
      6640            -4.7%       6328        proc-vmstat.nr_page_table_pages
   4769410           -71.8%    1343500 ±  6%  proc-vmstat.nr_shmem
     53693           -14.7%      45811        proc-vmstat.nr_slab_reclaimable
     57680         +1900.0%    1153633 ±  4%  proc-vmstat.nr_zone_active_anon
   4854706           -93.9%     298169 ± 23%  proc-vmstat.nr_zone_inactive_anon
    683375 ± 10%     -50.0%     341609 ±  4%  proc-vmstat.numa_hint_faults
    519396 ± 17%     -60.2%     206845 ± 27%  proc-vmstat.numa_hint_faults_local
   8698455           -38.3%    5371241        proc-vmstat.numa_hit
    938.89 ± 18%     -55.8%     414.71 ±  8%  proc-vmstat.numa_huge_pte_updates
   8495696           -39.4%    5152209        proc-vmstat.numa_local
   1313649 ±  5%     -46.7%     700042 ±  3%  proc-vmstat.numa_pte_updates
     61945         +1240.4%     830307 ± 21%  proc-vmstat.pgactivate
   8928138           -37.8%    5550603        proc-vmstat.pgalloc_normal
   2256846 ±  2%     -11.1%    2006618        proc-vmstat.pgfault
   1520379 ±  2%    +268.9%    5607989        proc-vmstat.pgfree
      0.38 ±  4%    +115.9%       0.82 ± 11%  perf-stat.i.MPKI
 7.631e+10            -4.8%  7.269e+10        perf-stat.i.branch-instructions
      0.67            -0.1        0.61        perf-stat.i.branch-miss-rate%
 4.989e+08            -5.5%  4.715e+08        perf-stat.i.branch-misses
   6418393            -8.1%    5897662 ±  5%  perf-stat.i.cache-misses
  50457351 ±  5%     +51.6%   76473775 ± 10%  perf-stat.i.cache-references
  60968060            -6.7%   56856550        perf-stat.i.context-switches
      2.14 ±  2%     +13.1%       2.42        perf-stat.i.cpi
  4.35e+11            +1.7%  4.424e+11        perf-stat.i.cpu-cycles
      1058 ± 14%     -21.6%     830.16 ±  4%  perf-stat.i.cpu-migrations
    385252 ±  4%     +63.0%     627819 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.01 ± 22%      -0.0        0.00 ± 12%  perf-stat.i.dTLB-load-miss-rate%
   2628303 ±  7%     -65.0%     920193 ±  5%  perf-stat.i.dTLB-load-misses
 1.104e+11            -6.0%  1.038e+11        perf-stat.i.dTLB-loads
      0.00 ± 13%      +0.0        0.00 ± 12%  perf-stat.i.dTLB-store-miss-rate%
    242451 ±  5%     -19.0%     196450 ± 11%  perf-stat.i.dTLB-store-misses
 6.626e+10            -8.4%  6.071e+10        perf-stat.i.dTLB-stores
 3.816e+11            -5.8%  3.595e+11        perf-stat.i.instructions
      0.80            -6.6%       0.75        perf-stat.i.ipc
      1.94            +1.7%       1.97        perf-stat.i.metric.GHz
    504.83 ±  2%      -4.4%     482.60        perf-stat.i.metric.K/sec
      1129            -6.2%       1058        perf-stat.i.metric.M/sec
      6259 ±  2%     -11.2%       5560        perf-stat.i.minor-faults
     58.32 ±  3%     +29.9       88.22 ±  6%  perf-stat.i.node-load-miss-rate%
   1117525           +34.5%    1502746 ± 10%  perf-stat.i.node-load-misses
    458656 ±  5%     -70.6%     134710 ± 30%  perf-stat.i.node-loads
      6260 ±  2%     -11.2%       5562        perf-stat.i.page-faults
      0.13 ±  5%     +61.1%       0.22 ± 10%  perf-stat.overall.MPKI
     12.66 ±  5%      -4.9        7.76 ± 14%  perf-stat.overall.cache-miss-rate%
      1.15            +7.5%       1.24        perf-stat.overall.cpi
     67823           +10.3%      74790 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  7%      -0.0        0.00 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.87            -7.0%       0.81        perf-stat.overall.ipc
     69.79 ±  2%     +21.7       91.45 ±  3%  perf-stat.overall.node-load-miss-rate%
    260155            -1.1%     257287        perf-stat.overall.path-length
 7.514e+10            -4.2%  7.195e+10        perf-stat.ps.branch-instructions
 4.914e+08            -5.1%  4.664e+08        perf-stat.ps.branch-misses
  50614911 ±  5%     +52.5%   77201196 ± 10%  perf-stat.ps.cache-references
  60049636            -6.4%   56232111        perf-stat.ps.context-switches
 4.331e+11            +1.8%  4.408e+11        perf-stat.ps.cpu-cycles
      1048 ± 13%     -21.2%     826.67 ±  4%  perf-stat.ps.cpu-migrations
   2706759 ±  7%     -65.6%     930018 ±  5%  perf-stat.ps.dTLB-load-misses
 1.087e+11            -5.5%  1.027e+11        perf-stat.ps.dTLB-loads
    242516 ±  5%     -19.3%     195733 ± 11%  perf-stat.ps.dTLB-store-misses
 6.523e+10            -7.9%  6.005e+10        perf-stat.ps.dTLB-stores
 3.757e+11            -5.3%  3.558e+11        perf-stat.ps.instructions
      6291 ±  2%     -11.8%       5547        perf-stat.ps.minor-faults
   1103763           +36.5%    1507093 ± 10%  perf-stat.ps.node-load-misses
    478062 ±  5%     -71.3%     137270 ± 29%  perf-stat.ps.node-loads
      6292 ±  2%     -11.8%       5549        perf-stat.ps.page-faults
 1.192e+14            -5.3%  1.129e+14        perf-stat.total.instructions
     20.06 ±  2%     -20.1        0.00        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
     22.16 ±  2%     -17.8        4.38 ±  3%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
     22.02 ±  2%     -17.7        4.35 ±  3%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
     20.05 ±  2%     -16.1        3.97 ±  3%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
     58.25            -9.4       48.81        perf-profile.calltrace.cycles-pp.__libc_read
     11.88 ±  2%      -9.3        2.53 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
     11.73            -9.2        2.48 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     10.32 ±  2%      -9.1        1.18 ±  3%  perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
     11.28            -8.8        2.45 ±  6%  perf-profile.calltrace.cycles-pp.__libc_write
     10.60 ±  2%      -8.5        2.08 ±  3%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
     10.69            -8.4        2.33 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
     10.59 ±  2%      -8.3        2.26 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
     10.62            -8.3        2.31 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     10.49            -8.3        2.24 ±  5%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     10.36 ±  2%      -8.2        2.19 ±  3%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
     10.61 ±  3%      -8.1        2.48 ± 13%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      8.71 ±  2%      -8.1        0.66 ± 54%  perf-profile.calltrace.cycles-pp.unwind_next_frame.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain
     56.47            -8.0       48.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     56.28            -7.8       48.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      9.88            -7.8        2.08 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      9.76            -7.7        2.02 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      9.76            -7.7        2.10 ±  5%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.48 ±  2%      -7.5        1.95 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
     55.87            -7.5       48.35        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     55.45            -7.2       48.28        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      8.86 ±  2%      -7.0        1.84 ±  3%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      8.63 ±  2%      -6.7        1.90 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      8.41 ±  2%      -6.6        1.80 ±  3%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      8.42 ±  2%      -6.6        1.86 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
     54.70            -6.5       48.19        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.30 ±  2%      -6.5        1.85 ±  5%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      8.18 ±  2%      -6.5        1.73 ±  3%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      8.10 ±  2%      -6.4        1.72 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      8.20 ±  2%      -6.4        1.83 ±  5%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      6.10 ±  2%      -6.1        0.00        perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      7.43 ±  2%      -6.0        1.47 ±  3%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      6.92 ±  2%      -5.4        1.50 ±  3%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      6.85 ±  2%      -5.4        1.46 ±  3%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      6.68 ±  2%      -5.3        1.43 ±  3%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      6.70 ±  2%      -5.2        1.46 ±  4%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle.do_idle
      6.50 ±  2%      -5.1        1.39 ±  3%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle
      6.47 ±  2%      -5.1        1.37 ±  3%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
      6.40 ±  2%      -5.0        1.36 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      5.69 ±  2%      -4.9        0.84 ±  5%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      5.85 ±  2%      -4.7        1.14 ±  3%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      5.83 ±  2%      -4.6        1.25 ±  4%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.pipe_read.vfs_read
      5.66 ±  2%      -4.4        1.21 ±  4%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.pipe_read
     52.13            -4.4       47.75        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.50 ±  2%      -4.3        1.16 ±  3%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
     51.86            -4.1       47.71        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      3.00 ±  6%      -2.4        0.58 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.00 ±  6%      -2.4        0.58 ±  2%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     28.01           +19.1       47.12        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     27.98           +19.1       47.11        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.90           +19.2       47.09        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     28.25           +19.3       47.57        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     13.04           +30.9       43.94        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     12.84           +31.1       43.91        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00           +41.3       41.26        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle
      0.00           +41.5       41.49        perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle.do_idle
      0.00           +41.6       41.57        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00           +41.8       41.80        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule
      0.00           +42.0       42.01        perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule.pipe_read
      0.00           +42.1       42.08        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
     27.66 ±  2%     -21.6        6.09 ±  3%  perf-profile.children.cycles-pp.perf_tp_event
     26.84 ±  2%     -21.0        5.84 ±  3%  perf-profile.children.cycles-pp.__perf_event_overflow
     26.57 ±  2%     -20.8        5.79 ±  3%  perf-profile.children.cycles-pp.perf_event_output_forward
     21.19 ±  2%     -20.4        0.79 ±  8%  perf-profile.children.cycles-pp.finish_task_switch
     24.08 ±  2%     -19.2        4.85 ±  3%  perf-profile.children.cycles-pp.perf_prepare_sample
     22.32 ±  2%     -17.8        4.53 ±  3%  perf-profile.children.cycles-pp.perf_callchain
     22.19 ±  2%     -17.7        4.51 ±  3%  perf-profile.children.cycles-pp.get_perf_callchain
     68.01           -16.5       51.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.76           -16.3       51.48        perf-profile.children.cycles-pp.do_syscall_64
     20.43 ±  2%     -16.3        4.15 ±  3%  perf-profile.children.cycles-pp.perf_callchain_kernel
     16.08 ±  2%     -12.8        3.30 ±  3%  perf-profile.children.cycles-pp.unwind_next_frame
     12.85 ±  2%     -10.0        2.80 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_switch
     58.48            -9.6       48.86        perf-profile.children.cycles-pp.__libc_read
     11.84            -9.3        2.50 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
     12.30 ±  2%      -9.1        3.21 ±  4%  perf-profile.children.cycles-pp.__libc_write
     10.55 ±  2%      -8.4        2.14 ±  3%  perf-profile.children.cycles-pp.__unwind_start
     11.30 ±  2%      -8.4        2.94 ±  3%  perf-profile.children.cycles-pp.ksys_write
     10.60 ±  2%      -8.3        2.26 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
     10.42 ±  2%      -8.2        2.20 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
     10.93 ±  2%      -8.1        2.84 ±  3%  perf-profile.children.cycles-pp.vfs_write
      9.96            -7.9        2.09 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      9.92            -7.8        2.08 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      9.80            -7.7        2.11 ±  5%  perf-profile.children.cycles-pp.pipe_write
     55.91            -7.5       48.37        perf-profile.children.cycles-pp.ksys_read
      9.65 ±  2%      -7.5        2.12 ±  3%  perf-profile.children.cycles-pp.update_curr
     55.47            -7.2       48.30        perf-profile.children.cycles-pp.vfs_read
      8.95 ±  2%      -7.0        1.98 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      8.65 ±  2%      -6.7        1.91 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
     54.85            -6.6       48.21        perf-profile.children.cycles-pp.pipe_read
      8.43 ±  2%      -6.6        1.86 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      8.35 ±  2%      -6.5        1.85 ±  5%  perf-profile.children.cycles-pp.autoremove_wake_function
      8.23 ±  2%      -6.4        1.84 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      6.86 ±  2%      -5.4        1.46 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      5.79 ±  2%      -4.9        0.87 ±  5%  perf-profile.children.cycles-pp.poll_idle
     52.14            -4.3       47.81        perf-profile.children.cycles-pp.schedule
      3.81 ±  5%      -3.7        0.15 ±  6%  perf-profile.children.cycles-pp.__switch_to
      4.46 ±  2%      -3.5        0.91 ±  3%  perf-profile.children.cycles-pp.__orc_find
      3.03 ±  6%      -2.4        0.58 ±  2%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      3.03 ±  6%      -2.4        0.58 ±  2%  perf-profile.children.cycles-pp.intel_idle
      2.85 ±  2%      -2.3        0.58 ±  3%  perf-profile.children.cycles-pp.stack_access_ok
      2.44 ±  2%      -2.0        0.48 ±  3%  perf-profile.children.cycles-pp.unwind_get_return_address
      2.08 ±  2%      -1.7        0.41 ±  3%  perf-profile.children.cycles-pp.__kernel_text_address
      2.09 ±  2%      -1.6        0.44 ±  3%  perf-profile.children.cycles-pp.orc_find
      2.00            -1.5        0.49 ± 10%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.87            -1.5        0.39 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.53 ±  2%      -1.2        0.30 ±  3%  perf-profile.children.cycles-pp.kernel_text_address
      1.37 ±  2%      -1.0        0.33 ± 14%  perf-profile.children.cycles-pp.menu_select
      1.49            -1.0        0.46 ± 17%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.43            -1.0        0.45 ± 17%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.26            -0.9        0.34 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      1.13 ±  2%      -0.9        0.23 ±  4%  perf-profile.children.cycles-pp.perf_callchain_user
      1.24            -0.9        0.35 ± 15%  perf-profile.children.cycles-pp.enqueue_entity
      1.53 ±  2%      -0.8        0.75 ±  4%  perf-profile.children.cycles-pp.perf_output_sample
      0.96 ±  3%      -0.8        0.18 ±  3%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.94            -0.7        0.24 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.79 ±  3%      -0.6        0.16 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.76 ±  3%      -0.6        0.13 ±  8%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.75 ±  2%      -0.6        0.13 ±  8%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.91 ±  4%      -0.6        0.30 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.72            -0.6        0.11 ±  4%  perf-profile.children.cycles-pp.prepare_to_wait_event
      1.16 ±  2%      -0.6        0.58 ±  4%  perf-profile.children.cycles-pp.__output_copy
      0.70            -0.6        0.14 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.74 ±  2%      -0.6        0.19 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.67 ±  2%      -0.5        0.14 ±  3%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.65            -0.5        0.12 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      1.01            -0.5        0.49 ±  4%  perf-profile.children.cycles-pp.perf_output_copy
      0.69 ±  2%      -0.5        0.19 ± 22%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.59            -0.5        0.11 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.55 ±  2%      -0.5        0.10 ±  6%  perf-profile.children.cycles-pp.mutex_lock
      0.67 ±  6%      -0.4        0.23 ± 12%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.52            -0.4        0.11 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.50 ±  2%      -0.4        0.10 ±  4%  perf-profile.children.cycles-pp.core_kernel_text
      0.58 ±  4%      -0.4        0.20 ± 17%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.49 ±  2%      -0.4        0.13 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.42            -0.3        0.08 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.45 ±  5%      -0.3        0.11 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      0.43 ±  2%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.52 ±  8%      -0.3        0.20 ± 13%  perf-profile.children.cycles-pp.copyin
      0.42 ±  5%      -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.43 ±  5%      -0.3        0.12 ± 11%  perf-profile.children.cycles-pp.ktime_get
      0.48 ±  4%      -0.3        0.17 ± 18%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.59 ±  3%      -0.3        0.29 ±  6%  perf-profile.children.cycles-pp.memcpy_erms
      0.38 ±  2%      -0.3        0.07 ±  7%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.38 ±  5%      -0.3        0.08 ±  8%  perf-profile.children.cycles-pp.__fget_files
      0.36 ±  2%      -0.3        0.07 ±  4%  perf-profile.children.cycles-pp._copy_from_iter
      0.35 ±  4%      -0.3        0.07 ±  7%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.42 ±  3%      -0.3        0.16 ± 21%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.34 ±  7%      -0.3        0.07 ±  6%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.32            -0.3        0.06        perf-profile.children.cycles-pp.kvm_guest_state
      0.39 ±  2%      -0.3        0.13 ± 30%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.31 ±  2%      -0.3        0.06 ±  5%  perf-profile.children.cycles-pp._copy_to_iter
      0.29 ±  5%      -0.2        0.05        perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.31 ±  2%      -0.2        0.06 ±  5%  perf-profile.children.cycles-pp.os_xsave
      0.29 ±  2%      -0.2        0.05 ±  9%  perf-profile.children.cycles-pp.get_stack_info
      0.30 ±  2%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.29 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.29 ±  2%      -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.__might_resched
      0.28 ±  4%      -0.2        0.06 ± 10%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.27 ±  3%      -0.2        0.05 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.26 ±  2%      -0.2        0.05 ±  6%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.26 ±  3%      -0.2        0.05        perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.24 ±  4%      -0.2        0.04 ± 40%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.26 ±  2%      -0.2        0.07 ± 10%  perf-profile.children.cycles-pp.___perf_sw_event
      0.35 ± 11%      -0.2        0.17 ± 16%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.79 ± 11%      -0.2        0.63 ±  7%  perf-profile.children.cycles-pp.generic_perform_write
      0.22            -0.2        0.06        perf-profile.children.cycles-pp.read_tsc
      0.26 ±  3%      -0.2        0.10 ±  8%  perf-profile.children.cycles-pp.select_task_rq
      0.26 ±  3%      -0.2        0.11 ± 29%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.79 ± 11%      -0.2        0.64 ±  7%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.79 ± 11%      -0.1        0.65 ±  7%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.22 ±  3%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.21 ±  3%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.22 ±  6%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.14 ±  6%      -0.1        0.03 ± 86%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.16 ±  9%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__do_softirq
      0.14 ± 11%      -0.1        0.05 ± 43%  perf-profile.children.cycles-pp.rebalance_domains
      0.16 ±  2%      -0.1        0.08 ± 47%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.13 ±  5%      -0.1        0.05 ±  6%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.13 ±  3%      -0.1        0.07 ± 44%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.10 ±  4%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.memcpy
      0.11 ± 12%      -0.0        0.06 ± 18%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ±  6%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.15 ± 11%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.15 ±  6%      +0.1        0.23 ± 18%  perf-profile.children.cycles-pp.tick_sched_handle
      0.15 ±  7%      +0.1        0.23 ± 18%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.update_blocked_averages
      0.24 ± 16%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.start_kernel
      0.24 ± 16%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.24 ± 16%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.rest_init
      0.00            +0.9        0.85 ± 46%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.9        0.91 ± 45%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.9        0.93 ± 45%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +1.0        1.01 ± 44%  perf-profile.children.cycles-pp.load_balance
      0.16 ±  4%      +1.0        1.20 ± 41%  perf-profile.children.cycles-pp.newidle_balance
     28.01           +19.1       47.12        perf-profile.children.cycles-pp.start_secondary
     28.25           +19.3       47.57        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     28.25           +19.3       47.57        perf-profile.children.cycles-pp.cpu_startup_entry
     28.19           +19.4       47.55        perf-profile.children.cycles-pp.do_idle
     65.01           +27.1       92.13        perf-profile.children.cycles-pp.__schedule
     13.19           +31.2       44.38        perf-profile.children.cycles-pp.schedule_idle
      0.00           +83.5       83.49        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.42 ±  2%     +83.7       84.07        perf-profile.children.cycles-pp.prepare_task_switch
      0.36 ±  2%     +83.8       84.12        perf-profile.children.cycles-pp._raw_spin_lock
     20.28 ±  2%     -19.9        0.37 ±  7%  perf-profile.self.cycles-pp.finish_task_switch
     14.57           -14.2        0.39 ±  6%  perf-profile.self.cycles-pp.__schedule
      6.94 ±  2%      -5.5        1.41 ±  3%  perf-profile.self.cycles-pp.unwind_next_frame
      5.60 ±  2%      -4.8        0.79 ±  6%  perf-profile.self.cycles-pp.poll_idle
      3.77 ±  5%      -3.6        0.14 ±  4%  perf-profile.self.cycles-pp.__switch_to
      4.25 ±  2%      -3.4        0.87 ±  3%  perf-profile.self.cycles-pp.__orc_find
      3.03 ±  6%      -2.4        0.58 ±  2%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      2.31 ±  2%      -1.8        0.47 ±  3%  perf-profile.self.cycles-pp.stack_access_ok
      1.87 ±  2%      -1.5        0.40 ±  3%  perf-profile.self.cycles-pp.orc_find
      0.97 ±  2%      -0.8        0.19 ±  3%  perf-profile.self.cycles-pp.__unwind_start
      0.94 ±  2%      -0.7        0.19 ±  4%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.75 ±  2%      -0.6        0.15 ±  3%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.69 ±  2%      -0.6        0.13 ±  8%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.67            -0.5        0.14 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.64            -0.5        0.11 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.70            -0.5        0.18 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.51            -0.4        0.07 ±  7%  perf-profile.self.cycles-pp.pipe_read
      0.55 ±  2%      -0.4        0.11 ±  4%  perf-profile.self.cycles-pp.kernel_text_address
      0.65 ±  6%      -0.4        0.22 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.52 ±  3%      -0.4        0.09 ±  3%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.47 ±  2%      -0.4        0.09 ±  5%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.48 ±  2%      -0.4        0.11 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.47 ±  2%      -0.4        0.09 ±  5%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.45 ±  2%      -0.4        0.09 ±  3%  perf-profile.self.cycles-pp.__kernel_text_address
      0.45 ±  3%      -0.4        0.09 ±  3%  perf-profile.self.cycles-pp.get_perf_callchain
      0.43 ±  2%      -0.3        0.09 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.40 ±  3%      -0.3        0.06 ±  5%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.43            -0.3        0.11 ± 13%  perf-profile.self.cycles-pp.enqueue_entity
      0.36 ±  2%      -0.3        0.07 ±  4%  perf-profile.self.cycles-pp.core_kernel_text
      0.36 ±  2%      -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.do_idle
      0.37 ±  5%      -0.3        0.08 ±  7%  perf-profile.self.cycles-pp.__fget_files
      0.38 ±  2%      -0.3        0.10 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.55 ±  4%      -0.3        0.26 ±  6%  perf-profile.self.cycles-pp.memcpy_erms
      0.33 ±  2%      -0.3        0.06 ±  8%  perf-profile.self.cycles-pp.__libc_read
      0.33            -0.3        0.06 ±  8%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.33 ±  3%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.33 ±  6%      -0.3        0.07 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.31 ±  3%      -0.3        0.06        perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.40 ±  4%      -0.2        0.15 ± 21%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.41 ±  3%      -0.2        0.17 ± 25%  perf-profile.self.cycles-pp.perf_tp_event
      0.30 ±  2%      -0.2        0.06 ±  8%  perf-profile.self.cycles-pp.os_xsave
      0.31 ±  7%      -0.2        0.07 ±  9%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.48            -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.__output_copy
      0.29 ±  2%      -0.2        0.06        perf-profile.self.cycles-pp.perf_callchain_user
      0.30 ±  2%      -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.__libc_write
      0.28            -0.2        0.06        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.26 ±  2%      -0.2        0.04 ± 40%  perf-profile.self.cycles-pp.kvm_guest_state
      0.26            -0.2        0.05        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.26 ±  3%      -0.2        0.06        perf-profile.self.cycles-pp.__might_resched
      0.22 ±  2%      -0.2        0.03 ± 86%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.25 ±  4%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.dequeue_entity
      0.33 ±  3%      -0.2        0.16 ±  2%  perf-profile.self.cycles-pp.perf_output_sample
      0.22 ±  4%      -0.2        0.06 ±  8%  perf-profile.self.cycles-pp.update_rq_clock
      0.22 ± 10%      -0.2        0.07 ± 17%  perf-profile.self.cycles-pp.ktime_get
      0.21 ±  2%      -0.2        0.06 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.18 ±  2%      -0.1        0.04 ± 65%  perf-profile.self.cycles-pp.___perf_sw_event
      0.19 ±  5%      -0.1        0.06 ± 41%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.20 ±  5%      -0.1        0.08 ± 42%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.20            -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.21 ±  3%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.14 ±  4%      -0.1        0.06 ± 43%  perf-profile.self.cycles-pp.newidle_balance
      0.15 ±  4%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.prepare_task_switch
      0.13 ±  5%      -0.1        0.05 ±  6%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.12 ±  2%      -0.1        0.06 ±  5%  perf-profile.self.cycles-pp.perf_output_copy
      0.12 ±  5%      -0.1        0.06 ± 43%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.14 ± 11%      +0.1        0.21 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.33            +0.3        0.62 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.7        0.66 ± 45%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00           +83.5       83.49        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/context_switch1/will-it-scale

commit: 
  99babd04b2 ("selftests/rseq: Implement rseq numa node id field selftest")
  af7f588d8f ("sched: Introduce per-memory-map concurrency ID")

99babd04b2505471 af7f588d8f7355bc4298dd1962d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   9168456           -73.8%    2400232 ± 10%  will-it-scale.16.threads
    573027           -73.8%     150014 ± 10%  will-it-scale.per_thread_ops
   9168456           -73.8%    2400232 ± 10%  will-it-scale.workload
 2.864e+09           -73.1%  7.715e+08 ± 11%  cpuidle..usage
      6.10            +1.0        7.15        mpstat.cpu.all.sys%
      1.13 ±  3%      -0.9        0.27 ± 10%  mpstat.cpu.all.usr%
  22292871 ±  7%     -78.9%    4696291 ± 10%  vmstat.memory.cache
     19.00 ±  3%     -14.7%      16.20 ±  2%  vmstat.procs.r
  18144385           -73.8%    4753330 ±  9%  vmstat.system.cs
    483366           +35.8%     656610 ±  5%  vmstat.system.in
   1555224 ±  5%     +60.7%    2499655 ± 18%  turbostat.C1
  87537260 ± 26%     +24.1%  1.086e+08 ± 14%  turbostat.C1E
     47.94 ± 62%     +27.4       75.30 ± 24%  turbostat.C1E%
      0.59           -66.0%       0.20 ±  8%  turbostat.IPC
 1.468e+08           +35.9%  1.995e+08 ±  5%  turbostat.IRQ
 2.746e+09           -76.2%  6.523e+08 ± 14%  turbostat.POLL
      1.67 ±  2%      -1.0        0.68 ±  4%  turbostat.POLL%
     34.20            -9.9%      30.80        turbostat.PkgTmp
    433.23 ±  2%     -10.4%     388.15        turbostat.PkgWatt
     33394 ±  5%    +814.1%     305243 ± 32%  numa-vmstat.node1.nr_active_anon
     55976 ±  9%     -22.7%      43246 ± 10%  numa-vmstat.node1.nr_anon_pages
   4483729 ± 33%     -88.5%     513735 ± 65%  numa-vmstat.node1.nr_file_pages
  28119032 ±  5%     +14.5%   32194305        numa-vmstat.node1.nr_free_pages
   4336878 ± 31%     -97.7%      97706 ± 85%  numa-vmstat.node1.nr_inactive_anon
   1758120 ± 22%     -91.3%     153214 ± 43%  numa-vmstat.node1.nr_mapped
      4166 ± 30%     -75.4%       1025 ± 21%  numa-vmstat.node1.nr_page_table_pages
   4314309 ± 32%     -91.7%     359713 ± 46%  numa-vmstat.node1.nr_shmem
     33394 ±  5%    +814.1%     305243 ± 32%  numa-vmstat.node1.nr_zone_active_anon
   4336876 ± 31%     -97.7%      97706 ± 85%  numa-vmstat.node1.nr_zone_inactive_anon
    134596 ±  6%    +807.2%    1221042 ± 32%  numa-meminfo.node1.Active
    134504 ±  6%    +807.7%    1220946 ± 32%  numa-meminfo.node1.Active(anon)
    223873 ±  9%     -22.7%     172976 ± 10%  numa-meminfo.node1.AnonPages
  17932980 ± 33%     -88.5%    2055168 ± 65%  numa-meminfo.node1.FilePages
  17344798 ± 31%     -97.7%     391247 ± 85%  numa-meminfo.node1.Inactive
  17344618 ± 31%     -97.7%     391073 ± 85%  numa-meminfo.node1.Inactive(anon)
   7027715 ± 22%     -91.3%     614131 ± 43%  numa-meminfo.node1.Mapped
 1.125e+08 ±  5%     +14.5%  1.288e+08        numa-meminfo.node1.MemFree
  19565762 ± 30%     -83.3%    3266862 ± 41%  numa-meminfo.node1.MemUsed
     16664 ± 30%     -75.4%       4105 ± 21%  numa-meminfo.node1.PageTables
  17255300 ± 32%     -91.7%    1439083 ± 46%  numa-meminfo.node1.Shmem
    421445 ±  2%     -16.6%     351355        meminfo.AnonPages
  22061123 ±  7%     -79.5%    4530612 ± 11%  meminfo.Cached
  20088958 ±  8%     -87.8%    2443971 ± 21%  meminfo.Committed_AS
  19170771 ± 11%     -97.0%     574987 ± 60%  meminfo.Inactive
  19170591 ± 11%     -97.0%     574813 ± 60%  meminfo.Inactive(anon)
    213051           -18.3%     173997        meminfo.KReclaimable
   7430615 ± 13%     -90.5%     705190 ± 33%  meminfo.Mapped
  25328866 ±  7%     -71.9%    7127544 ±  7%  meminfo.Memused
     21777 ±  8%     -63.7%       7906 ±  7%  meminfo.PageTables
    213051           -18.3%     173997        meminfo.SReclaimable
  19164273 ±  8%     -91.5%    1633768 ± 30%  meminfo.Shmem
  26692881           -39.4%   16170877 ±  7%  meminfo.max_used_kB
     65901 ± 13%     -98.2%       1210 ±143%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   1327262 ± 10%     -93.4%      87886 ±144%  sched_debug.cfs_rq:/.MIN_vruntime.max
    265536 ±  3%     -96.2%      10166 ±144%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     65901 ± 13%     -98.2%       1210 ±143%  sched_debug.cfs_rq:/.max_vruntime.avg
   1327262 ± 10%     -93.4%      87886 ±144%  sched_debug.cfs_rq:/.max_vruntime.max
    265536 ±  3%     -96.2%      10166 ±144%  sched_debug.cfs_rq:/.max_vruntime.stddev
     33780 ± 13%     +39.7%      47201 ± 13%  sched_debug.cfs_rq:/.min_vruntime.min
    979.30 ±  2%     -15.8%     824.68 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    978.91 ±  2%     -17.1%     811.25 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    860.31 ±  2%     -30.0%     601.91 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
      1736 ±  3%    +506.1%      10522 ± 91%  sched_debug.cpu.avg_idle.min
      0.09 ±  4%     -13.4%       0.08 ±  5%  sched_debug.cpu.nr_running.avg
  10630744 ± 12%     -71.4%    3041094 ±  6%  sched_debug.cpu.nr_switches.avg
  74675547 ± 12%     -71.5%   21318321 ±  6%  sched_debug.cpu.nr_switches.max
  26031282 ± 12%     -71.4%    7440127 ±  6%  sched_debug.cpu.nr_switches.stddev
    105357 ±  2%     -16.6%      87842        proc-vmstat.nr_anon_pages
   5921091            +7.7%    6375494        proc-vmstat.nr_dirty_background_threshold
  11856660            +7.7%   12766578        proc-vmstat.nr_dirty_threshold
   5515701 ±  7%     -79.5%    1132643 ± 11%  proc-vmstat.nr_file_pages
  59582345            +7.6%   64133047        proc-vmstat.nr_free_pages
   4793162 ± 11%     -97.0%     143617 ± 60%  proc-vmstat.nr_inactive_anon
   1858672 ± 13%     -90.6%     175442 ± 33%  proc-vmstat.nr_mapped
      5443 ±  8%     -63.7%       1976 ±  7%  proc-vmstat.nr_page_table_pages
   4791488 ±  8%     -91.5%     408431 ± 30%  proc-vmstat.nr_shmem
     53263           -18.3%      43499        proc-vmstat.nr_slab_reclaimable
    103557            -1.4%     102106        proc-vmstat.nr_slab_unreclaimable
   4793162 ± 11%     -97.0%     143617 ± 60%  proc-vmstat.nr_zone_inactive_anon
    260965 ±  3%     -73.8%      68247 ± 12%  proc-vmstat.numa_hint_faults
    210545 ±  4%     -91.7%      17501 ± 29%  proc-vmstat.numa_hint_faults_local
   8964679           -46.3%    4809967 ± 10%  proc-vmstat.numa_hit
      1384 ± 19%     -89.0%     151.80 ± 23%  proc-vmstat.numa_huge_pte_updates
   8648086           -46.7%    4607108 ± 10%  proc-vmstat.numa_local
   1033314 ± 14%     -80.9%     197728 ± 15%  proc-vmstat.numa_pte_updates
   8998915           -45.0%    4950106 ±  9%  proc-vmstat.pgalloc_normal
   1704072 ±  2%     -23.0%    1311857 ±  3%  proc-vmstat.pgfault
      0.45 ±  8%    +168.1%       1.19 ±  3%  perf-stat.i.MPKI
  2.07e+10           -65.5%  7.138e+09 ±  7%  perf-stat.i.branch-instructions
 1.334e+08           -66.0%   45319480 ±  8%  perf-stat.i.branch-misses
      8.65 ±  7%      -4.0        4.68 ±  6%  perf-stat.i.cache-miss-rate%
   7550889 ±  5%     -48.6%    3883482 ± 15%  perf-stat.i.cache-misses
  18312903           -73.8%    4797849 ± 10%  perf-stat.i.context-switches
      0.99          +203.5%       3.00 ±  7%  perf-stat.i.cpi
 9.998e+10            -1.4%  9.855e+10        perf-stat.i.cpu-cycles
    122169 ± 13%    +148.0%     302970 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.02 ±  3%      -0.0        0.00 ±  5%  perf-stat.i.dTLB-load-miss-rate%
   5554209 ±  3%     -97.0%     168530 ± 11%  perf-stat.i.dTLB-load-misses
 2.912e+10           -67.7%  9.412e+09 ±  7%  perf-stat.i.dTLB-loads
      0.00 ± 13%      -0.0        0.00 ±  8%  perf-stat.i.dTLB-store-miss-rate%
    316990 ± 13%     -85.2%      46788 ± 18%  perf-stat.i.dTLB-store-misses
 1.752e+10           -71.8%  4.938e+09 ±  9%  perf-stat.i.dTLB-stores
 1.016e+11           -66.7%  3.386e+10 ±  7%  perf-stat.i.instructions
      1.02           -66.2%       0.34 ±  7%  perf-stat.i.ipc
      0.45            -1.4%       0.44        perf-stat.i.metric.GHz
    299.03 ±  6%     -30.0%     209.39 ± 10%  perf-stat.i.metric.K/sec
    300.64           -68.1%      95.93 ±  8%  perf-stat.i.metric.M/sec
      4904           -27.1%       3576 ±  4%  perf-stat.i.minor-faults
     52.06 ± 27%     +42.6       94.61        perf-stat.i.node-load-miss-rate%
   1131145 ± 23%     -47.4%     595531 ± 25%  perf-stat.i.node-load-misses
   1002828 ± 32%     -96.5%      35044 ± 23%  perf-stat.i.node-loads
      4904           -27.1%       3576 ±  4%  perf-stat.i.page-faults
      0.46 ±  8%    +168.7%       1.23 ±  2%  perf-stat.overall.MPKI
     16.33 ±  4%      -7.0        9.34 ±  6%  perf-stat.overall.cache-miss-rate%
      0.98          +197.4%       2.93 ±  7%  perf-stat.overall.cpi
     13283 ±  6%     +94.7%      25864 ± 15%  perf-stat.overall.cycles-between-cache-misses
      0.02 ±  3%      -0.0        0.00 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 13%      -0.0        0.00 ± 10%  perf-stat.overall.dTLB-store-miss-rate%
      1.02           -66.2%       0.34 ±  7%  perf-stat.overall.ipc
     53.52 ± 19%     +40.4       93.95        perf-stat.overall.node-load-miss-rate%
   3330788           +27.6%    4250478 ±  2%  perf-stat.overall.path-length
 2.063e+10           -65.5%  7.117e+09 ±  7%  perf-stat.ps.branch-instructions
  1.33e+08           -66.0%   45185662 ±  8%  perf-stat.ps.branch-misses
   7528642 ±  5%     -48.3%    3888889 ± 15%  perf-stat.ps.cache-misses
  18252001           -73.8%    4781904 ± 10%  perf-stat.ps.context-switches
 9.965e+10            -1.4%  9.823e+10        perf-stat.ps.cpu-cycles
   5544297 ±  3%     -97.0%     168873 ± 11%  perf-stat.ps.dTLB-load-misses
 2.903e+10           -67.7%  9.384e+09 ±  7%  perf-stat.ps.dTLB-loads
    316419 ± 13%     -85.2%      46843 ± 19%  perf-stat.ps.dTLB-store-misses
 1.746e+10           -71.8%  4.923e+09 ±  9%  perf-stat.ps.dTLB-stores
 1.013e+11           -66.7%  3.376e+10 ±  7%  perf-stat.ps.instructions
      4885           -26.8%       3577 ±  4%  perf-stat.ps.minor-faults
   1127461 ± 23%     -47.3%     593739 ± 25%  perf-stat.ps.node-load-misses
   1001303 ± 32%     -96.4%      36005 ± 22%  perf-stat.ps.node-loads
      4885           -26.8%       3577 ±  4%  perf-stat.ps.page-faults
 3.054e+13           -66.7%  1.018e+13 ±  7%  perf-stat.total.instructions
     34.69           -20.3       14.42 ± 13%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
     34.45           -20.1       14.34 ± 13%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
     31.23 ±  2%     -18.2       13.07 ± 13%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
     20.47 ±  2%     -12.3        8.15 ± 13%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
     18.88           -11.5        7.40 ± 13%  perf-profile.calltrace.cycles-pp.__libc_write
     17.86           -10.9        7.01 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
     17.75           -10.8        6.97 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     17.53           -10.6        6.90 ± 13%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     19.27 ±  2%     -10.6        8.64 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     16.91 ±  2%     -10.3        6.65 ± 13%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
     16.38            -9.9        6.47 ± 13%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.36 ±  2%      -9.5        6.84 ± 13%  perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
     14.54            -8.7        5.86 ± 13%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     15.76            -8.6        7.19 ± 13%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
     14.21            -8.5        5.73 ± 13%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
     14.11            -8.4        5.69 ± 13%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
     15.42            -8.4        7.05 ± 13%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
     13.97            -8.3        5.64 ± 13%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
     13.81 ±  2%      -8.0        5.79 ± 13%  perf-profile.calltrace.cycles-pp.unwind_next_frame.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain
     14.00            -7.6        6.43 ± 13%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
     11.27 ±  2%      -7.5        3.75 ± 12%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.pipe_read.vfs_read
     10.99 ±  2%      -7.3        3.64 ± 12%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.pipe_read
     12.19            -7.3        4.89 ± 13%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     10.72 ±  2%      -7.2        3.55 ± 12%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
     11.91            -7.1        4.78 ± 13%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
     13.13            -7.0        6.08 ± 13%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
     12.84            -6.9        5.95 ± 13%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
     11.43 ±  2%      -6.8        4.62 ± 13%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
     12.56            -6.7        5.82 ± 13%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
     11.32 ±  2%      -6.7        4.58 ± 13%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
     12.46            -6.7        5.77 ± 13%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      9.69 ±  2%      -5.8        3.85 ± 14%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template
     10.64            -5.7        4.94 ± 13%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
     10.56 ±  2%      -5.6        4.95 ± 13%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
     10.24 ±  2%      -5.4        4.81 ± 13%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle.do_idle
      9.23 ±  2%      -5.3        3.91 ± 13%  perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      9.97            -5.3        4.68 ± 13%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle
     14.74            -4.4       10.31 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     11.02            -2.5        8.53 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     10.67            -2.4        8.25 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.87            -2.1        0.76 ± 42%  perf-profile.calltrace.cycles-pp.perf_output_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
      5.01            -1.9        3.08 ± 11%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.13 ±  2%      -1.9        1.23 ± 15%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.76            -1.7        1.07 ± 15%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      2.92 ±  4%      -1.5        1.44 ± 18%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.07 ±  2%      -1.3        0.81 ± 15%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.96 ±  2%      -1.2        0.76 ± 15%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
      1.60 ±  2%      -1.0        0.63 ± 15%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue
      1.30            -1.0        0.34 ± 82%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.68 ±  8%      -0.8        0.86 ± 29%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.46            -0.8        0.64 ± 13%  perf-profile.calltrace.cycles-pp.perf_output_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      1.37 ± 16%      -0.5        0.90        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
      0.44 ± 50%      +0.6        1.05 ± 21%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.43 ± 50%      +0.6        1.05 ± 21%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.rest_init
      0.00            +0.7        0.67 ±  7%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
     41.34            +1.9       43.24        perf-profile.calltrace.cycles-pp.__libc_read
     38.47            +3.6       42.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     38.19            +3.8       42.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     37.53            +4.3       41.80        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     36.83            +4.7       41.56        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     35.95            +5.3       41.23        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.14            +7.7       39.84        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     31.80            +7.9       39.70 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     34.12           +10.2       44.37        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     34.07           +10.3       44.35        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     33.94           +10.3       44.27        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.09           +10.5       45.63        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     14.13           +17.8       31.89 ±  3%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     13.80           +18.0       31.76 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00           +24.3       24.34 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle
      0.00           +25.1       25.13 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule
      0.00           +25.3       25.28 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle.do_idle
      0.00           +25.5       25.54 ±  8%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00           +25.9       25.88 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule.pipe_read
      0.00           +26.1       26.10 ±  8%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
     46.54           -27.0       19.49 ± 13%  perf-profile.children.cycles-pp.perf_tp_event
     45.22           -26.2       18.97 ± 13%  perf-profile.children.cycles-pp.__perf_event_overflow
     44.82           -26.0       18.82 ± 13%  perf-profile.children.cycles-pp.perf_event_output_forward
     37.76           -22.0       15.72 ± 13%  perf-profile.children.cycles-pp.perf_prepare_sample
     35.11           -20.4       14.66 ± 13%  perf-profile.children.cycles-pp.perf_callchain
     34.91           -20.3       14.59 ± 13%  perf-profile.children.cycles-pp.get_perf_callchain
     32.01           -18.6       13.46 ± 13%  perf-profile.children.cycles-pp.perf_callchain_kernel
     25.16 ±  2%     -14.5       10.65 ± 13%  perf-profile.children.cycles-pp.unwind_next_frame
     22.28 ±  2%     -13.4        8.91 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_switch
     21.63 ±  2%     -11.9        9.70 ± 10%  perf-profile.children.cycles-pp.__libc_write
     19.92 ±  2%     -10.9        8.98 ± 10%  perf-profile.children.cycles-pp.ksys_write
     19.32 ±  2%     -10.6        8.69 ± 10%  perf-profile.children.cycles-pp.vfs_write
     16.44            -9.9        6.50 ± 13%  perf-profile.children.cycles-pp.pipe_write
     16.82            -9.8        7.05 ± 13%  perf-profile.children.cycles-pp.__unwind_start
     14.58            -8.7        5.87 ± 13%  perf-profile.children.cycles-pp.__wake_up_common_lock
     15.79            -8.6        7.20 ± 13%  perf-profile.children.cycles-pp.dequeue_task_fair
     14.23            -8.5        5.73 ± 13%  perf-profile.children.cycles-pp.__wake_up_common
     15.53            -8.4        7.10 ± 13%  perf-profile.children.cycles-pp.dequeue_entity
     14.13            -8.4        5.70 ± 13%  perf-profile.children.cycles-pp.autoremove_wake_function
     14.03            -8.4        5.67 ± 13%  perf-profile.children.cycles-pp.try_to_wake_up
     14.25            -7.7        6.58 ± 13%  perf-profile.children.cycles-pp.update_curr
     58.80            -7.5       51.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.22            -7.3        4.90 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
     58.45            -7.3       51.19        perf-profile.children.cycles-pp.do_syscall_64
     13.24            -7.1        6.18 ± 12%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
     15.07            -4.6       10.47 ±  5%  perf-profile.children.cycles-pp.cpuidle_idle_call
      6.83            -3.9        2.91 ± 13%  perf-profile.children.cycles-pp.__orc_find
      5.92            -3.5        2.41 ± 13%  perf-profile.children.cycles-pp.perf_output_sample
      4.58            -2.7        1.86 ± 14%  perf-profile.children.cycles-pp.__output_copy
      4.53            -2.6        1.91 ± 13%  perf-profile.children.cycles-pp.stack_access_ok
     11.21            -2.6        8.65 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
     11.14            -2.5        8.62 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.96            -2.4        1.60 ± 13%  perf-profile.children.cycles-pp.perf_output_copy
      5.46            -2.2        3.24 ± 10%  perf-profile.children.cycles-pp.poll_idle
      3.78            -2.2        1.58 ± 12%  perf-profile.children.cycles-pp.unwind_get_return_address
      3.24 ±  2%      -2.0        1.27 ± 14%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.27            -2.0        1.31 ± 13%  perf-profile.children.cycles-pp.sched_ttwu_pending
      3.31 ±  2%      -1.9        1.42 ± 13%  perf-profile.children.cycles-pp.orc_find
      3.20            -1.9        1.34 ± 13%  perf-profile.children.cycles-pp.__kernel_text_address
      3.04 ±  4%      -1.6        1.49 ± 18%  perf-profile.children.cycles-pp.menu_select
      2.43            -1.5        0.98 ± 13%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.32            -1.4        0.93 ± 13%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.29            -1.4        0.90 ± 14%  perf-profile.children.cycles-pp.memcpy_erms
      2.32            -1.3        0.97 ± 13%  perf-profile.children.cycles-pp.kernel_text_address
      2.02            -1.2        0.81 ± 13%  perf-profile.children.cycles-pp.enqueue_entity
      2.04 ±  2%      -1.2        0.89 ± 14%  perf-profile.children.cycles-pp.update_load_avg
      1.83            -1.1        0.72 ± 13%  perf-profile.children.cycles-pp.perf_callchain_user
      1.77            -0.9        0.83 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.72            -0.9        0.79 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.75 ±  8%      -0.9        0.89 ± 28%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.45            -0.9        0.60 ± 13%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      1.26 ±  2%      -0.8        0.49 ± 13%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      1.20 ±  2%      -0.7        0.46 ± 13%  perf-profile.children.cycles-pp.__switch_to
      1.35            -0.7        0.61 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      1.14            -0.7        0.48 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.03            -0.6        0.38 ± 12%  perf-profile.children.cycles-pp.__switch_to_asm
      1.46 ± 10%      -0.6        0.83 ± 16%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.06 ±  2%      -0.6        0.45 ± 12%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      1.00 ±  2%      -0.6        0.40 ± 13%  perf-profile.children.cycles-pp.set_next_entity
      0.85 ±  2%      -0.6        0.25 ± 16%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.99 ±  2%      -0.6        0.39 ± 13%  perf-profile.children.cycles-pp.prepare_to_wait_event
      1.06 ±  7%      -0.6        0.51 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.88 ±  2%      -0.5        0.37 ± 12%  perf-profile.children.cycles-pp.__entry_text_start
      1.14 ± 13%      -0.5        0.64 ± 36%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.71 ±  2%      -0.5        0.22 ± 16%  perf-profile.children.cycles-pp._copy_from_iter
      1.22 ± 13%      -0.5        0.73 ± 16%  perf-profile.children.cycles-pp.copyin
      0.81 ±  2%      -0.5        0.33 ± 13%  perf-profile.children.cycles-pp.core_kernel_text
      0.78 ±  4%      -0.5        0.32 ± 13%  perf-profile.children.cycles-pp.mutex_lock
      0.65 ±  2%      -0.4        0.22 ± 12%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.76 ±  2%      -0.4        0.35 ± 10%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.73 ±  8%      -0.4        0.33 ± 10%  perf-profile.children.cycles-pp.__fdget_pos
      0.72            -0.4        0.33 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.68 ±  8%      -0.4        0.29 ± 11%  perf-profile.children.cycles-pp.__fget_light
      0.66 ±  5%      -0.4        0.29 ± 14%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.72            -0.4        0.35 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.55 ±  2%      -0.4        0.18 ± 14%  perf-profile.children.cycles-pp._copy_to_iter
      0.70 ±  6%      -0.4        0.33 ±  7%  perf-profile.children.cycles-pp.sysvec_call_function_single
      1.78 ± 12%      -0.4        1.41 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.55            -0.3        0.20 ± 14%  perf-profile.children.cycles-pp.kvm_guest_state
      0.62            -0.3        0.28 ± 13%  perf-profile.children.cycles-pp.select_task_rq
      0.60 ±  8%      -0.3        0.26 ± 10%  perf-profile.children.cycles-pp.__fget_files
      0.56 ±  5%      -0.3        0.22 ± 13%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.51 ±  3%      -0.3        0.20 ± 12%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.51 ±  3%      -0.3        0.20 ± 13%  perf-profile.children.cycles-pp.os_xsave
      0.51            -0.3        0.21 ± 14%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.53            -0.3        0.23 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.93 ± 14%      -0.3        0.63 ± 14%  perf-profile.children.cycles-pp.ktime_get
      0.46            -0.3        0.17 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.48 ±  2%      -0.3        0.19 ± 13%  perf-profile.children.cycles-pp.get_stack_info
      0.53 ±  2%      -0.3        0.24 ± 12%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.92 ± 18%      -0.3        0.64 ± 16%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.47 ±  2%      -0.3        0.19 ± 15%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.54 ±  7%      -0.3        0.27 ±  6%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.45            -0.3        0.17 ± 11%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.48 ±  2%      -0.3        0.20 ±  8%  perf-profile.children.cycles-pp.__might_resched
      0.46            -0.3        0.19 ± 11%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.44 ±  4%      -0.3        0.17 ± 15%  perf-profile.children.cycles-pp.security_file_permission
      0.35 ±  3%      -0.3        0.09 ± 14%  perf-profile.children.cycles-pp.__might_fault
      0.42            -0.2        0.17 ± 11%  perf-profile.children.cycles-pp.memcpy
      0.51 ±  2%      -0.2        0.26 ± 11%  perf-profile.children.cycles-pp.___perf_sw_event
      0.39 ±  2%      -0.2        0.16 ± 11%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.35 ±  3%      -0.2        0.12 ± 16%  perf-profile.children.cycles-pp.touch_atime
      0.36 ±  6%      -0.2        0.13 ± 15%  perf-profile.children.cycles-pp.get_callchain_entry
      0.46 ±  2%      -0.2        0.23 ±  5%  perf-profile.children.cycles-pp.read_tsc
      0.37 ±  2%      -0.2        0.15 ± 12%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.35 ±  5%      -0.2        0.13 ± 12%  perf-profile.children.cycles-pp.update_cfs_group
      0.34 ±  3%      -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.copyout
      0.35 ±  2%      -0.2        0.14 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.34 ±  5%      -0.2        0.13 ± 17%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.32            -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.30 ±  5%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.atime_needs_update
      0.31 ±  2%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.36 ±  2%      -0.2        0.17 ±  7%  perf-profile.children.cycles-pp.ct_idle_exit
      0.28 ±  2%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.28            -0.2        0.10 ± 10%  perf-profile.children.cycles-pp.fput
      0.29 ±  5%      -0.2        0.11 ± 12%  perf-profile.children.cycles-pp.reweight_entity
      0.32 ±  3%      -0.2        0.14 ± 11%  perf-profile.children.cycles-pp.mutex_unlock
      0.28 ±  3%      -0.2        0.10 ± 15%  perf-profile.children.cycles-pp.__might_sleep
      0.28 ±  4%      -0.2        0.11 ± 15%  perf-profile.children.cycles-pp.perf_misc_flags
      0.26 ±  2%      -0.2        0.09 ± 12%  perf-profile.children.cycles-pp.perf_instruction_pointer
      0.26 ±  2%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.28 ±  2%      -0.2        0.11 ± 10%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.27            -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.finish_wait
      0.27 ±  4%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.current_time
      0.37 ±  2%      -0.2        0.21 ±  8%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.25 ±  5%      -0.2        0.10 ± 11%  perf-profile.children.cycles-pp.perf_swevent_event
      0.65 ±  2%      -0.2        0.50 ±  8%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.24 ± 10%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.perf_output_end
      0.24 ±  3%      -0.1        0.10 ± 13%  perf-profile.children.cycles-pp.get_stack_info_noinstr
      0.24 ±  2%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.25            -0.1        0.11 ± 15%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.24 ±  4%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.23 ±  6%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.22 ±  6%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.24 ±  3%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.24 ±  2%      -0.1        0.11 ± 13%  perf-profile.children.cycles-pp.__is_insn_slot_addr
      0.23 ±  3%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.22 ±  4%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.18 ±  2%      -0.1        0.06 ± 10%  perf-profile.children.cycles-pp.place_entity
      0.23 ±  3%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.59 ± 15%      -0.1        0.48 ±  7%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.21 ±  6%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.file_update_time
      0.19 ±  7%      -0.1        0.08 ± 21%  perf-profile.children.cycles-pp.update_min_vruntime
      0.17 ±  2%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.17 ±  3%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.switch_fpu_return
      0.17 ±  4%      -0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__calc_delta
      0.18 ±  4%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.16 ±  2%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.testcase
      0.18 ±  2%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.pick_next_entity
      0.21 ±  3%      -0.1        0.11 ± 15%  perf-profile.children.cycles-pp.select_idle_sibling
      0.18 ±  4%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.15 ±  2%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.15 ±  6%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.aa_file_perm
      0.15 ±  2%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__perf_event_account_interrupt
      0.16 ±  4%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.is_bpf_text_address
      0.15 ±  2%      -0.1        0.06 ± 18%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.13 ±  5%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.in_task_stack
      0.15 ±  4%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  4%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.16 ±  4%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.16 ±  4%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.13 ±  8%      -0.1        0.05 ± 52%  perf-profile.children.cycles-pp.check_preempt_curr
      0.12 ±  8%      -0.1        0.03 ± 82%  perf-profile.children.cycles-pp.rb_next
      0.12 ± 14%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.cpuacct_charge
      0.34 ±  4%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.12 ±  6%      -0.1        0.03 ± 84%  perf-profile.children.cycles-pp.__update_idle_core
      0.14 ±  7%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.19 ± 14%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.11 ±  5%      -0.1        0.03 ± 82%  perf-profile.children.cycles-pp.is_module_text_address
      0.20 ± 15%      -0.1        0.12 ± 15%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      0.12 ±  3%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.14 ±  2%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.llist_add_batch
      0.17 ± 12%      -0.1        0.10 ± 32%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.13 ±  5%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.sched_clock
      0.13 ±  5%      -0.1        0.06 ± 12%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.13 ±  3%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.send_call_function_single_ipi
      0.12 ±  4%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.is_ftrace_trampoline
      0.11 ±  4%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.schedule_debug
      0.20 ± 16%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.ordered_events__queue
      0.16 ± 12%      -0.1        0.09 ± 33%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.13 ±  4%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.16 ± 16%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.20 ±  4%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.14 ± 16%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.09 ± 15%      -0.1        0.04 ± 51%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.10 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.11 ± 19%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.folio_add_lru
      0.12 ± 16%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__folio_alloc
      0.12 ± 16%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__alloc_pages
      0.10 ± 16%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.05 ± 50%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.10 ± 14%      +0.0        0.14 ± 17%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.10 ± 16%      +0.0        0.14 ± 18%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.10 ± 16%      +0.0        0.14 ± 18%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.04 ± 50%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.06 ±  8%      +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.06 ±  6%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.08 ± 10%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.__perf_mmap__read_init
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.perf_mmap__read_init
      0.00            +0.2        0.23 ± 18%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.00            +0.2        0.24 ± 17%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.22 ±  2%      +0.5        0.69 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
     41.73            +1.7       43.40        perf-profile.children.cycles-pp.__libc_read
     37.62            +4.2       41.84        perf-profile.children.cycles-pp.ksys_read
     36.89            +4.7       41.60        perf-profile.children.cycles-pp.vfs_read
     36.13            +5.2       41.30        perf-profile.children.cycles-pp.pipe_read
     32.16            +7.7       39.86        perf-profile.children.cycles-pp.schedule
     34.12           +10.2       44.37        perf-profile.children.cycles-pp.start_secondary
     35.09           +10.5       45.63        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.09           +10.5       45.63        perf-profile.children.cycles-pp.cpu_startup_entry
     34.97           +10.6       45.57        perf-profile.children.cycles-pp.do_idle
     14.68           +18.3       32.96 ±  4%  perf-profile.children.cycles-pp.schedule_idle
     46.43           +26.2       72.65 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.00           +49.6       49.57 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.81 ±  2%     +50.9       51.66 ±  8%  perf-profile.children.cycles-pp.prepare_task_switch
      0.58 ±  2%     +50.9       51.44 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
     10.88 ±  2%      -6.3        4.59 ± 13%  perf-profile.self.cycles-pp.unwind_next_frame
      6.51            -3.7        2.77 ± 13%  perf-profile.self.cycles-pp.__orc_find
      3.68            -2.1        1.54 ± 13%  perf-profile.self.cycles-pp.stack_access_ok
      2.97 ±  2%      -1.7        1.27 ± 13%  perf-profile.self.cycles-pp.orc_find
      4.42 ±  2%      -1.4        3.00 ± 10%  perf-profile.self.cycles-pp.poll_idle
      2.09            -1.3        0.82 ± 15%  perf-profile.self.cycles-pp.memcpy_erms
      1.91            -1.1        0.80 ± 14%  perf-profile.self.cycles-pp.__output_copy
      2.28 ± 10%      -1.0        1.32        perf-profile.self.cycles-pp.__schedule
      1.58            -0.9        0.64 ± 12%  perf-profile.self.cycles-pp.__unwind_start
      1.50 ±  2%      -0.9        0.61 ± 14%  perf-profile.self.cycles-pp.perf_callchain_kernel
      1.19 ±  2%      -0.7        0.47 ± 13%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      1.21            -0.7        0.50 ± 13%  perf-profile.self.cycles-pp.perf_output_sample
      1.29 ±  2%      -0.7        0.58 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      1.14 ±  3%      -0.7        0.44 ± 13%  perf-profile.self.cycles-pp.__switch_to
      1.01 ±  2%      -0.6        0.37 ± 12%  perf-profile.self.cycles-pp.__switch_to_asm
      1.08            -0.6        0.46 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.43 ± 11%      -0.6        0.81 ± 15%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.91 ±  2%      -0.5        0.37 ± 14%  perf-profile.self.cycles-pp.kernel_text_address
      1.47 ± 15%      -0.5        0.93        perf-profile.self.cycles-pp.finish_task_switch
      0.96            -0.5        0.46 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.74 ±  2%      -0.5        0.28 ± 12%  perf-profile.self.cycles-pp.perf_tp_event
      0.73 ±  3%      -0.4        0.29 ± 14%  perf-profile.self.cycles-pp.get_perf_callchain
      0.75 ±  3%      -0.4        0.31 ± 13%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.65 ±  2%      -0.4        0.21 ± 15%  perf-profile.self.cycles-pp.pipe_read
      0.72 ±  2%      -0.4        0.29 ± 11%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.70            -0.4        0.27 ± 13%  perf-profile.self.cycles-pp.enqueue_entity
      0.74 ±  2%      -0.4        0.31 ± 12%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.71 ±  2%      -0.4        0.28 ± 14%  perf-profile.self.cycles-pp.update_load_avg
      0.72 ±  2%      -0.4        0.30 ± 12%  perf-profile.self.cycles-pp.__kernel_text_address
      0.61 ±  2%      -0.4        0.26 ± 14%  perf-profile.self.cycles-pp.do_idle
      0.60            -0.3        0.26 ±  9%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.62 ±  5%      -0.3        0.27 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.58 ±  2%      -0.3        0.24 ± 13%  perf-profile.self.cycles-pp.core_kernel_text
      0.58 ±  9%      -0.3        0.25 ± 12%  perf-profile.self.cycles-pp.__fget_files
      0.63            -0.3        0.31 ± 13%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.51 ±  3%      -0.3        0.20 ± 14%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.50 ±  3%      -0.3        0.19 ± 12%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.51 ±  2%      -0.3        0.21 ±  7%  perf-profile.self.cycles-pp.__libc_write
      0.50 ±  3%      -0.3        0.20 ± 13%  perf-profile.self.cycles-pp.os_xsave
      0.49 ±  2%      -0.3        0.19 ± 14%  perf-profile.self.cycles-pp.perf_callchain_user
      0.50            -0.3        0.20 ± 15%  perf-profile.self.cycles-pp.perf_output_copy
      0.49 ±  5%      -0.3        0.19 ± 14%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.49            -0.3        0.20 ± 13%  perf-profile.self.cycles-pp.__libc_read
      0.49 ±  3%      -0.3        0.20 ± 20%  perf-profile.self.cycles-pp.update_curr
      0.44 ±  2%      -0.3        0.16 ± 14%  perf-profile.self.cycles-pp.kvm_guest_state
      0.44            -0.3        0.17 ± 10%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.47 ±  2%      -0.3        0.20 ± 13%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.37 ±  3%      -0.2        0.13 ± 13%  perf-profile.self.cycles-pp.pipe_write
      0.43 ±  2%      -0.2        0.18 ±  8%  perf-profile.self.cycles-pp.__might_resched
      0.39 ±  2%      -0.2        0.14 ± 14%  perf-profile.self.cycles-pp.vfs_read
      0.37 ±  4%      -0.2        0.14 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.44 ±  2%      -0.2        0.22 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.41 ±  6%      -0.2        0.19 ± 15%  perf-profile.self.cycles-pp.dequeue_entity
      0.34 ±  7%      -0.2        0.12 ± 16%  perf-profile.self.cycles-pp.get_callchain_entry
      0.35 ±  2%      -0.2        0.14 ± 14%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.31 ±  5%      -0.2        0.12 ± 15%  perf-profile.self.cycles-pp.update_cfs_group
      0.32            -0.2        0.12 ± 13%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.29 ±  6%      -0.2        0.09 ± 10%  perf-profile.self.cycles-pp.try_to_wake_up
      0.32 ±  5%      -0.2        0.13 ± 12%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.27 ±  3%      -0.2        0.08 ± 14%  perf-profile.self.cycles-pp.ksys_read
      0.30 ±  2%      -0.2        0.11 ± 11%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.29 ±  2%      -0.2        0.11 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.31 ±  3%      -0.2        0.13 ± 15%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.31 ±  4%      -0.2        0.14 ± 15%  perf-profile.self.cycles-pp.mutex_lock
      0.27 ±  3%      -0.2        0.09 ± 15%  perf-profile.self.cycles-pp.do_syscall_64
      0.27 ±  4%      -0.2        0.10 ± 14%  perf-profile.self.cycles-pp.__perf_event_overflow
      0.27 ±  5%      -0.2        0.10 ± 13%  perf-profile.self.cycles-pp.reweight_entity
      0.29 ±  3%      -0.2        0.12 ±  8%  perf-profile.self.cycles-pp.update_rq_clock
      0.29 ±  4%      -0.2        0.13 ± 10%  perf-profile.self.cycles-pp.mutex_unlock
      0.25 ±  3%      -0.2        0.08 ± 14%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.26 ±  3%      -0.2        0.10 ± 14%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.26 ±  2%      -0.2        0.10 ± 11%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.36 ±  3%      -0.2        0.21 ± 13%  perf-profile.self.cycles-pp.___perf_sw_event
      0.24            -0.2        0.09 ± 12%  perf-profile.self.cycles-pp.fput
      0.34 ±  2%      -0.2        0.19 ±  9%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.23 ±  3%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.__might_sleep
      0.25 ±  2%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.set_next_entity
      0.29            -0.1        0.14 ± 12%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.23 ±  4%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.63 ±  2%      -0.1        0.49 ±  7%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.22 ±  2%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.18 ±  2%      -0.1        0.05 ± 52%  perf-profile.self.cycles-pp._copy_from_iter
      0.22 ± 11%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.perf_output_end
      0.28 ± 22%      -0.1        0.15 ± 38%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.22            -0.1        0.09 ± 11%  perf-profile.self.cycles-pp.schedule_idle
      0.23 ±  2%      -0.1        0.10 ±  7%  perf-profile.self.cycles-pp.vfs_write
      0.54 ±  3%      -0.1        0.41 ±  4%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.20 ±  2%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.perf_callchain
      0.21 ±  6%      -0.1        0.08 ± 15%  perf-profile.self.cycles-pp.perf_swevent_event
      0.22 ±  2%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.get_stack_info
      0.20 ±  3%      -0.1        0.08 ± 15%  perf-profile.self.cycles-pp.schedule
      0.20 ±  3%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.memcpy
      0.21 ±  3%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.22 ±  2%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.20 ±  2%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.20 ±  2%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.19 ±  5%      -0.1        0.07 ± 18%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.18 ±  2%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.19 ±  8%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__entry_text_start
      0.18 ±  2%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.17 ±  2%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.16 ±  3%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.switch_fpu_return
      0.23 ±  3%      -0.1        0.13 ± 15%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.30 ±  2%      -0.1        0.20 ± 17%  perf-profile.self.cycles-pp.prepare_task_switch
      0.18 ±  2%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.__is_insn_slot_addr
      0.13 ±  3%      -0.1        0.03 ± 82%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.15 ±  3%      -0.1        0.06 ± 12%  perf-profile.self.cycles-pp.current_time
      0.15 ±  3%      -0.1        0.06 ± 12%  perf-profile.self.cycles-pp.testcase
      0.16 ±  5%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.__calc_delta
      0.15 ±  3%      -0.1        0.06 ± 15%  perf-profile.self.cycles-pp.perf_misc_flags
      0.17 ±  2%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.17 ±  5%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.15 ±  3%      -0.1        0.06 ± 12%  perf-profile.self.cycles-pp.pick_next_entity
      0.15 ±  7%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.13 ±  7%      -0.1        0.05 ± 52%  perf-profile.self.cycles-pp.aa_file_perm
      0.13 ±  3%      -0.1        0.04 ± 51%  perf-profile.self.cycles-pp.__perf_event_account_interrupt
      0.15 ±  6%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.update_min_vruntime
      0.15 ±  5%      -0.1        0.06 ± 12%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.16            -0.1        0.07 ± 13%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.15 ±  5%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.34 ±  4%      -0.1        0.25 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.14 ±  5%      -0.1        0.06 ± 12%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.12 ±  3%      -0.1        0.04 ± 51%  perf-profile.self.cycles-pp.send_call_function_single_ipi
      0.11 ±  3%      -0.1        0.03 ± 82%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.14 ±  5%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.llist_add_batch
      0.12 ±  4%      -0.1        0.04 ± 50%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ± 15%      -0.1        0.04 ± 50%  perf-profile.self.cycles-pp.cpuacct_charge
      0.13 ±  3%      -0.1        0.06 ± 10%  perf-profile.self.cycles-pp.ct_idle_exit
      0.13 ±  3%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.get_stack_info_noinstr
      0.14 ±  2%      -0.1        0.07 ±  9%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.13 ±  7%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.12 ±  4%      -0.1        0.04 ± 51%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.13 ±  5%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.11 ±  3%      -0.1        0.04 ± 50%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.19 ± 17%      -0.1        0.12 ± 27%  perf-profile.self.cycles-pp.queue_event
      0.13 ± 15%      -0.1        0.07 ± 63%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.20 ±  5%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.10 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.01 ±200%      +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.2        0.21 ± 18%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.21 ±  2%      +0.5        0.69 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.54            +1.3        1.84        perf-profile.self.cycles-pp._raw_spin_lock
      0.00           +49.6       49.57 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/thread/16/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  99babd04b2 ("selftests/rseq: Implement rseq numa node id field selftest")
  af7f588d8f ("sched: Introduce per-memory-map concurrency ID")

99babd04b2505471 af7f588d8f7355bc4298dd1962d 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:6          -17%            :6     kmsg.EDAC_skx:Can't_find_handle_for_NVDIMM_ADR=
          1:6          -17%            :6     kmsg.microcode:Attempting_late_microcode_loading-it_is_dangerous_and_taints_the_kernel
          1:6          -17%            :6     kmsg.microcode:You_should_switch_to_early_loading,if_possible
         %stddev     %change         %stddev
             \          |                \  
   4324658 ±  3%     -57.9%    1818800        will-it-scale.16.threads
    270290 ±  3%     -57.9%     113674        will-it-scale.per_thread_ops
   4324658 ±  3%     -57.9%    1818800        will-it-scale.workload
 1.329e+09 ±  3%     -58.0%  5.581e+08        cpuidle..usage
     12.36 ±  2%      +2.9       15.22        mpstat.cpu.all.sys%
      5.59            -3.0        2.57 ±  4%  mpstat.cpu.all.usr%
     19.17           -11.3%      17.00        vmstat.procs.r
   8547612 ±  2%     -58.0%    3593440        vmstat.system.cs
    233179           +16.0%     270468 ±  2%  vmstat.system.in
    158734 ± 25%    +182.8%     448837 ± 18%  turbostat.C1
      0.14 ±  5%     -48.8%       0.07        turbostat.IPC
  70953881           +16.1%   82393754 ±  2%  turbostat.IRQ
 1.286e+09 ±  3%     -60.0%  5.137e+08        turbostat.POLL
      1.67 ±  6%      -0.7        1.00 ±  2%  turbostat.POLL%
    252.48            -8.1%     232.09        turbostat.PkgWatt
    114167 ± 20%     -93.5%       7417 ± 59%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   1525472           -76.4%     359932 ± 59%  sched_debug.cfs_rq:/.MIN_vruntime.max
    387653 ± 11%     -87.1%      49952 ± 56%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.39 ±  6%     -24.3%       0.29 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
     22932 ±  5%     +13.0%      25920 ±  3%  sched_debug.cfs_rq:/.load.avg
     59500 ±  4%     +55.5%      92526 ± 68%  sched_debug.cfs_rq:/.load.max
    114167 ± 20%     -93.5%       7417 ± 59%  sched_debug.cfs_rq:/.max_vruntime.avg
   1525472           -76.4%     359932 ± 59%  sched_debug.cfs_rq:/.max_vruntime.max
    387653 ± 11%     -87.1%      49952 ± 56%  sched_debug.cfs_rq:/.max_vruntime.stddev
    671631 ±  3%     -16.0%     564476 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   1542612           -17.8%    1267561        sched_debug.cfs_rq:/.min_vruntime.max
    708750           -18.9%     575136        sched_debug.cfs_rq:/.min_vruntime.stddev
      0.37 ±  6%     -24.7%       0.28 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
   -848558           -19.6%    -682164        sched_debug.cfs_rq:/.spread0.avg
  -1486548           -18.5%   -1211535        sched_debug.cfs_rq:/.spread0.min
    708763           -18.9%     575149        sched_debug.cfs_rq:/.spread0.stddev
    214.42           -10.2%     192.45 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      3058 ±  4%    +113.4%       6526 ±  6%  sched_debug.cpu.avg_idle.min
      1063 ±  2%     -14.8%     906.25 ±  5%  sched_debug.cpu.curr->pid.avg
      0.20 ±  4%     -13.3%       0.17 ±  2%  sched_debug.cpu.nr_running.avg
  12311145 ±  3%     -57.7%    5209198        sched_debug.cpu.nr_switches.avg
  40179926 ±  3%     -57.8%   16957686        sched_debug.cpu.nr_switches.max
  18457770 ±  3%     -57.7%    7805110        sched_debug.cpu.nr_switches.stddev
      1.48 ± 33%    +393.8%       7.31 ± 14%  perf-stat.i.MPKI
 9.306e+09           -51.2%  4.543e+09 ±  5%  perf-stat.i.branch-instructions
 1.571e+08 ±  2%     -49.6%   79141069 ±  4%  perf-stat.i.branch-misses
  67978805 ± 32%    +129.9%  1.563e+08 ± 13%  perf-stat.i.cache-references
   8635700 ±  3%     -58.0%    3628862        perf-stat.i.context-switches
      2.00          +112.1%       4.24 ±  2%  perf-stat.i.cpi
    152.95 ±  4%     +10.5%     168.99 ±  2%  perf-stat.i.cpu-migrations
   9807863 ±  8%     -54.4%    4473079 ± 12%  perf-stat.i.dTLB-load-misses
 1.313e+10           -52.5%  6.241e+09 ±  4%  perf-stat.i.dTLB-loads
 7.867e+09           -54.9%  3.549e+09 ±  4%  perf-stat.i.dTLB-stores
   9070094 ±  3%     -58.2%    3793161 ± 49%  perf-stat.i.iTLB-load-misses
  11272936 ±  7%     -50.6%    5566942 ±  8%  perf-stat.i.iTLB-loads
 4.592e+10           -51.8%  2.214e+10 ±  5%  perf-stat.i.instructions
      0.50           -51.9%       0.24 ±  4%  perf-stat.i.ipc
    660.44 ± 31%     -85.8%      93.67 ±  4%  perf-stat.i.metric.K/sec
    291.58           -52.2%     139.32 ±  4%  perf-stat.i.metric.M/sec
      1.48 ± 32%    +375.8%       7.06 ± 12%  perf-stat.overall.MPKI
      1.99          +108.2%       4.14 ±  4%  perf-stat.overall.cpi
      0.50           -51.9%       0.24 ±  4%  perf-stat.overall.ipc
   3197936 ±  3%     +14.7%    3668175 ±  4%  perf-stat.overall.path-length
 9.276e+09           -51.2%  4.528e+09 ±  5%  perf-stat.ps.branch-instructions
 1.566e+08 ±  2%     -49.6%   78882571 ±  4%  perf-stat.ps.branch-misses
  67767931 ± 32%    +129.8%  1.557e+08 ± 13%  perf-stat.ps.cache-references
   8606808 ±  3%     -58.0%    3616809        perf-stat.ps.context-switches
    152.61 ±  4%     +10.4%     168.54 ±  2%  perf-stat.ps.cpu-migrations
   9780257 ±  8%     -54.4%    4458181 ± 12%  perf-stat.ps.dTLB-load-misses
 1.309e+10           -52.5%  6.221e+09 ±  4%  perf-stat.ps.dTLB-loads
 7.842e+09           -54.9%  3.538e+09 ±  4%  perf-stat.ps.dTLB-stores
   9039813 ±  3%     -58.2%    3780389 ± 49%  perf-stat.ps.iTLB-load-misses
  11235261 ±  7%     -50.6%    5548664 ±  8%  perf-stat.ps.iTLB-loads
 4.577e+10           -51.8%  2.207e+10 ±  5%  perf-stat.ps.instructions
 1.381e+13           -51.7%  6.671e+12 ±  4%  perf-stat.total.instructions
     20.96 ±  7%      -9.2       11.78 ± 32%  perf-profile.calltrace.cycles-pp.__libc_write
     15.02 ± 20%      -4.7       10.34 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.46 ± 28%      -2.9        2.58 ±  7%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.64 ± 32%      -2.4        2.25 ± 11%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      4.55 ± 28%      -2.4        2.18 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.70 ± 37%      -1.9        1.84 ± 12%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      3.55 ± 39%      -1.8        1.78 ± 12%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
      2.78 ± 33%      -1.5        1.31 ±  6%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_read
      2.63 ± 39%      -1.4        1.28 ±  7%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_write
      2.60 ± 32%      -1.3        1.33 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      2.27 ± 20%      -1.2        1.05 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      2.29 ± 35%      -1.1        1.15 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      2.08 ± 32%      -1.1        0.94 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.74 ± 34%      -0.9        0.83 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.25 ± 45%      -0.9        0.36 ± 71%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      1.18 ± 29%      -0.9        0.30 ±100%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      1.07 ± 34%      -0.8        0.26 ±100%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_read
      1.06 ± 38%      -0.8        0.27 ±100%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_write
      1.03 ± 21%      -0.7        0.28 ±100%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.38 ± 23%      -0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      0.00            +0.8        0.83 ± 11%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
     40.47 ±  4%      +2.9       43.39 ±  2%  perf-profile.calltrace.cycles-pp.__libc_read
     34.36 ±  8%      +6.8       41.18 ± 10%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     34.34 ±  8%      +6.8       41.17 ± 10%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     34.08 ±  8%      +7.0       41.04 ± 10%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.35 ±  8%      +7.0       42.35 ± 10%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     32.51 ± 14%      +7.7       40.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     30.86 ± 16%      +8.5       39.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     27.80 ± 22%     +10.0       37.80        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     27.05 ± 23%     +10.4       37.42        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     25.85 ± 26%     +11.0       36.84        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.15 ± 38%     +13.5       34.64        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     20.97 ± 39%     +13.6       34.56        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      9.89 ± 37%     +16.4       26.25 ± 18%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      9.57 ± 39%     +16.5       26.10 ± 18%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00           +18.8       18.81 ± 49%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle
      0.00           +19.3       19.34 ± 47%  perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle.do_idle
      0.29 ±100%     +19.4       19.72 ± 46%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00           +19.8       19.76 ± 45%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule
      0.00           +20.3       20.31 ± 44%  perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule.pipe_read
      0.29 ±100%     +20.4       20.67 ± 43%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
     22.18 ±  7%      -9.1       13.08 ± 38%  perf-profile.children.cycles-pp.__libc_write
     15.50 ± 20%      -4.9       10.61 ±  7%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.65 ± 29%      -3.0        2.66 ±  7%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      5.48 ± 35%      -2.8        2.67 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      5.08 ± 26%      -2.5        2.61 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      4.74 ± 28%      -2.5        2.27 ±  8%  perf-profile.children.cycles-pp.menu_select
      4.94 ± 33%      -2.4        2.55 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      4.06 ± 30%      -1.9        2.13 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      3.89 ± 32%      -1.8        2.06 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      3.16 ± 21%      -1.6        1.59 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.19 ± 34%      -1.4        1.75 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
      2.62 ± 18%      -1.4        1.25 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      2.41 ± 35%      -1.3        1.15 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      2.17 ± 32%      -1.2        0.98 ± 12%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.76 ± 42%      -1.1        0.66 ± 13%  perf-profile.children.cycles-pp.__switch_to_asm
      1.56 ± 48%      -1.1        0.51 ±  9%  perf-profile.children.cycles-pp.__switch_to
      1.97 ± 34%      -1.0        0.95 ±  5%  perf-profile.children.cycles-pp.ktime_get
      1.84 ± 34%      -1.0        0.88 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      1.54 ± 23%      -0.8        0.74 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.98 ± 51%      -0.7        0.26 ± 20%  perf-profile.children.cycles-pp.os_xsave
      1.26 ± 30%      -0.7        0.55 ± 16%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.15 ± 33%      -0.6        0.52 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      1.40 ± 10%      -0.6        0.79 ± 12%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.17 ± 34%      -0.6        0.58 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.06 ± 32%      -0.5        0.52 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.93 ± 26%      -0.5        0.41 ±  5%  perf-profile.children.cycles-pp.select_task_rq
      1.04 ± 21%      -0.5        0.52 ± 10%  perf-profile.children.cycles-pp.copy_page_from_iter
      1.18 ± 12%      -0.5        0.66 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
      0.92 ± 34%      -0.5        0.47 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      0.88 ± 36%      -0.4        0.45 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.85 ± 36%      -0.4        0.42 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.88 ± 34%      -0.4        0.45 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.78 ± 23%      -0.4        0.35 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.75 ± 38%      -0.4        0.32 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.76 ± 31%      -0.4        0.34 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.65 ± 39%      -0.4        0.26 ± 21%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.71 ± 42%      -0.4        0.32 ± 11%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.75 ± 35%      -0.4        0.37 ±  4%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.80 ± 22%      -0.4        0.43 ± 12%  perf-profile.children.cycles-pp._copy_from_iter
      0.64 ± 34%      -0.4        0.26 ±  6%  perf-profile.children.cycles-pp._copy_to_iter
      0.71 ± 18%      -0.4        0.34 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.67 ± 38%      -0.3        0.34 ±  3%  perf-profile.children.cycles-pp.__fget_files
      0.75 ± 29%      -0.3        0.42 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
      0.64 ± 40%      -0.3        0.32 ± 16%  perf-profile.children.cycles-pp.reweight_entity
      0.66 ± 22%      -0.3        0.34 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.65 ± 20%      -0.3        0.36 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.44 ± 42%      -0.3        0.16 ±  6%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.52 ± 31%      -0.3        0.25 ±  5%  perf-profile.children.cycles-pp.__might_resched
      0.47 ± 18%      -0.3        0.20 ± 36%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.55 ± 24%      -0.3        0.29 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.47 ± 29%      -0.3        0.22 ±  5%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.54 ±  5%      -0.3        0.29 ± 20%  perf-profile.children.cycles-pp.touch_atime
      0.47 ± 10%      -0.3        0.22 ± 12%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.45 ± 35%      -0.2        0.22 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.43 ± 23%      -0.2        0.21 ±  9%  perf-profile.children.cycles-pp.__might_fault
      0.36 ± 37%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.37 ± 42%      -0.2        0.15 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      0.35 ± 26%      -0.2        0.15 ± 23%  perf-profile.children.cycles-pp.__calc_delta
      0.43 ±  6%      -0.2        0.22 ± 23%  perf-profile.children.cycles-pp.atime_needs_update
      0.35 ± 45%      -0.2        0.14 ±  6%  perf-profile.children.cycles-pp.file_update_time
      0.36 ± 27%      -0.2        0.16 ±  8%  perf-profile.children.cycles-pp.pick_next_entity
      0.53 ± 16%      -0.2        0.34 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.39 ± 35%      -0.2        0.19 ±  7%  perf-profile.children.cycles-pp.__cond_resched
      0.38 ± 37%      -0.2        0.19 ±  6%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.28 ± 52%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.32 ± 30%      -0.2        0.13 ± 12%  perf-profile.children.cycles-pp.copyout
      0.34 ± 15%      -0.2        0.16 ± 24%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.34 ±  8%      -0.2        0.18 ± 23%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.33 ± 33%      -0.2        0.16 ± 15%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.31 ± 38%      -0.2        0.15 ± 10%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.28 ± 30%      -0.2        0.12 ±  8%  perf-profile.children.cycles-pp.select_idle_sibling
      0.29 ± 31%      -0.2        0.14 ±  5%  perf-profile.children.cycles-pp.copy_user_short_string
      0.30 ± 26%      -0.2        0.16 ±  9%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.27 ± 34%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.fput
      0.25 ± 39%      -0.1        0.11 ±  5%  perf-profile.children.cycles-pp.cpuacct_charge
      0.28 ± 30%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.28 ±  9%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.current_time
      0.24 ± 32%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.22 ± 29%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.finish_wait
      0.15 ± 17%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.llist_reverse_order
      0.22 ± 27%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.23 ± 28%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.put_prev_entity
      0.21 ± 26%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.20 ± 38%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.25 ± 28%      -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.18 ± 18%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.update_min_vruntime
      0.22 ± 13%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.19 ± 36%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.switch_fpu_return
      0.19 ± 29%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.16 ± 21%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.20 ± 14%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.check_preempt_curr
      0.19 ± 31%      -0.1        0.10 ± 16%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.19 ± 21%      -0.1        0.09 ± 12%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.20 ±  8%      -0.1        0.10 ± 23%  perf-profile.children.cycles-pp.get_cpu_device
      0.16 ±  9%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.rb_erase
      0.14 ±  9%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.clear_buddies
      0.20 ± 25%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__update_idle_core
      0.16 ± 25%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.llist_add_batch
      0.17 ± 22%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.testcase
      0.18 ± 34%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.18 ±  9%      -0.1        0.10 ± 22%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.19 ± 20%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.17 ± 39%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.13 ± 11%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.put_prev_task_idle
      0.18 ± 15%      -0.1        0.10 ± 33%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.12 ± 44%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.11 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.schedule_debug
      0.16 ± 29%      -0.1        0.08 ±  7%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.14 ± 14%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.18 ± 26%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.10 ± 23%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.send_call_function_single_ipi
      0.14 ± 24%      -0.1        0.07        perf-profile.children.cycles-pp.ct_kernel_exit
      0.13 ± 23%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ± 38%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__x64_sys_write
      0.08 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.init_wait_entry
      0.12 ± 30%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__x64_sys_read
      0.08 ± 10%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.child
      0.10 ± 19%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp._find_first_zero_bit
      0.28 ± 23%      +0.6        0.85 ± 11%  perf-profile.children.cycles-pp.switch_mm_irqs_off
     40.66 ±  4%      +2.8       43.50 ±  2%  perf-profile.children.cycles-pp.__libc_read
     34.36 ±  8%      +6.8       41.18 ± 10%  perf-profile.children.cycles-pp.start_secondary
     35.35 ±  8%      +7.0       42.35 ± 10%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.35 ±  8%      +7.0       42.35 ± 10%  perf-profile.children.cycles-pp.cpu_startup_entry
     35.24 ±  8%      +7.0       42.28 ± 10%  perf-profile.children.cycles-pp.do_idle
     27.86 ± 22%     +10.0       37.84        perf-profile.children.cycles-pp.ksys_read
     27.09 ± 23%     +10.4       37.45        perf-profile.children.cycles-pp.vfs_read
     25.98 ± 26%     +10.9       36.90        perf-profile.children.cycles-pp.pipe_read
     21.16 ± 38%     +13.5       34.65        perf-profile.children.cycles-pp.schedule
     10.22 ± 36%     +16.9       27.08 ± 18%  perf-profile.children.cycles-pp.schedule_idle
     31.01 ± 38%     +30.5       61.54 ±  8%  perf-profile.children.cycles-pp.__schedule
      0.00           +38.8       38.77 ± 47%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.66 ± 29%     +39.5       40.18 ± 45%  perf-profile.children.cycles-pp._raw_spin_lock
      1.00 ± 18%     +39.6       40.61 ± 44%  perf-profile.children.cycles-pp.prepare_task_switch
      5.48 ± 35%      -2.8        2.67 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.56 ± 33%      -2.2        2.36 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.36 ± 34%      -1.6        1.72        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.10 ± 36%      -1.1        0.99 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      1.75 ± 42%      -1.1        0.65 ± 12%  perf-profile.self.cycles-pp.__switch_to_asm
      1.94 ± 28%      -1.0        0.98 ±  5%  perf-profile.self.cycles-pp.menu_select
      1.42 ± 47%      -0.9        0.48 ±  9%  perf-profile.self.cycles-pp.__switch_to
      2.45 ± 29%      -0.8        1.63        perf-profile.self.cycles-pp.__schedule
      0.97 ± 51%      -0.7        0.26 ± 20%  perf-profile.self.cycles-pp.os_xsave
      1.21 ± 33%      -0.6        0.62 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      1.14 ± 33%      -0.6        0.57 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.11 ± 15%      -0.6        0.55 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      1.01 ± 31%      -0.5        0.50        perf-profile.self.cycles-pp.read_tsc
      1.15 ± 12%      -0.5        0.65 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.95 ± 36%      -0.5        0.45 ± 12%  perf-profile.self.cycles-pp.ktime_get
      0.81 ± 34%      -0.4        0.36 ±  6%  perf-profile.self.cycles-pp.pipe_read
      0.73 ± 17%      -0.4        0.29 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      0.84 ± 24%      -0.4        0.40 ±  7%  perf-profile.self.cycles-pp.pipe_write
      0.80 ± 41%      -0.4        0.37 ± 17%  perf-profile.self.cycles-pp.do_idle
      0.75 ± 22%      -0.4        0.34 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.70 ± 27%      -0.4        0.31 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.64 ± 13%      -0.4        0.28 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.67 ± 34%      -0.3        0.33 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.65 ± 18%      -0.3        0.32 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.66 ± 38%      -0.3        0.33 ±  4%  perf-profile.self.cycles-pp.__fget_files
      0.63 ± 40%      -0.3        0.31 ± 16%  perf-profile.self.cycles-pp.reweight_entity
      0.71 ± 27%      -0.3        0.40 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.55 ± 20%      -0.3        0.25 ±  6%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.53 ± 25%      -0.3        0.26 ±  2%  perf-profile.self.cycles-pp.set_next_entity
      0.44 ± 42%      -0.3        0.16 ±  6%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.52 ± 31%      -0.3        0.25 ±  6%  perf-profile.self.cycles-pp.__might_resched
      0.45 ± 32%      -0.3        0.20 ± 11%  perf-profile.self.cycles-pp.vfs_write
      0.48 ± 37%      -0.2        0.23 ±  5%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.47 ± 29%      -0.2        0.23 ±  6%  perf-profile.self.cycles-pp.mutex_lock
      0.44 ± 35%      -0.2        0.21 ±  3%  perf-profile.self.cycles-pp.vfs_read
      0.42 ± 18%      -0.2        0.18 ± 39%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.47 ± 30%      -0.2        0.23 ±  6%  perf-profile.self.cycles-pp.newidle_balance
      0.45 ± 29%      -0.2        0.22 ±  4%  perf-profile.self.cycles-pp.__libc_write
      0.51 ±  9%      -0.2        0.28 ± 25%  perf-profile.self.cycles-pp.update_curr
      0.48 ± 23%      -0.2        0.25 ± 11%  perf-profile.self.cycles-pp.___perf_sw_event
      0.42 ± 34%      -0.2        0.19 ±  5%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.43 ± 33%      -0.2        0.22 ±  9%  perf-profile.self.cycles-pp.__libc_read
      0.36 ± 43%      -0.2        0.14 ±  6%  perf-profile.self.cycles-pp.mutex_unlock
      0.34 ± 24%      -0.2        0.14 ± 23%  perf-profile.self.cycles-pp.__calc_delta
      0.28 ± 52%      -0.2        0.09 ±  9%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.30 ± 36%      -0.2        0.12 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.30 ± 30%      -0.2        0.12 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
      0.34 ± 37%      -0.2        0.16 ±  8%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.28 ± 34%      -0.2        0.11 ± 13%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.30 ±  7%      -0.2        0.14 ± 38%  perf-profile.self.cycles-pp.try_to_wake_up
      0.29 ± 46%      -0.2        0.14 ±  4%  perf-profile.self.cycles-pp.schedule_idle
      0.28 ± 37%      -0.2        0.13 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.28 ± 30%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.copy_user_short_string
      0.24 ± 32%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.27 ±  7%      -0.1        0.13 ± 14%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.29 ± 22%      -0.1        0.15 ± 10%  perf-profile.self.cycles-pp._copy_from_iter
      0.30 ± 16%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.22 ± 20%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.28 ± 29%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.24 ± 35%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.24 ± 39%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.26 ± 30%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.27 ± 23%      -0.1        0.15 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
      0.23 ± 17%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.40 ± 12%      -0.1        0.28 ± 17%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.21 ± 36%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.fput
      0.15 ± 18%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.17 ± 35%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp._copy_to_iter
      0.20 ± 32%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.18 ±  7%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.select_task_rq
      0.20 ± 15%      -0.1        0.09 ± 21%  perf-profile.self.cycles-pp.current_time
      0.18 ± 37%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.switch_fpu_return
      0.19 ± 35%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.16 ± 23%      -0.1        0.06 ± 15%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.18 ± 39%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.22 ± 24%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.ksys_read
      0.16 ± 15%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.update_min_vruntime
      0.16 ± 20%      -0.1        0.07 ± 23%  perf-profile.self.cycles-pp.check_preempt_curr
      0.19 ± 29%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.put_prev_entity
      0.14 ±  9%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.18 ± 31%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.18 ± 21%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.18 ± 23%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.22 ± 26%      -0.1        0.13 ± 12%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.12 ±  8%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.put_prev_task_idle
      0.18 ± 32%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.18 ±  9%      -0.1        0.09 ± 26%  perf-profile.self.cycles-pp.ksys_write
      0.19 ±  8%      -0.1        0.10 ± 23%  perf-profile.self.cycles-pp.get_cpu_device
      0.19 ± 32%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.__fget_light
      0.17 ± 33%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ± 31%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.select_idle_sibling
      0.20 ±  2%      -0.1        0.12 ± 27%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.16 ± 27%      -0.1        0.08 ± 15%  perf-profile.self.cycles-pp.llist_add_batch
      0.17 ± 19%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.15 ± 30%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.16 ± 37%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.14 ± 11%      -0.1        0.06 ± 47%  perf-profile.self.cycles-pp.rb_erase
      0.17 ± 26%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.17 ± 20%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.__update_idle_core
      0.16 ± 22%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.testcase
      0.17 ± 16%      -0.1        0.09 ± 31%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.12 ± 31%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.__wake_up_common
      0.18 ± 10%      -0.1        0.10 ± 36%  perf-profile.self.cycles-pp.atime_needs_update
      0.14 ± 43%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.file_update_time
      0.12 ± 15%      -0.1        0.04 ± 70%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.11 ±  9%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.schedule_debug
      0.16 ± 16%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.16 ± 35%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.14 ± 19%      -0.1        0.07 ± 27%  perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.15 ± 30%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.10 ± 23%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.send_call_function_single_ipi
      0.15 ±  8%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.14 ± 34%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.12 ± 21%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ± 38%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__x64_sys_write
      0.08 ± 26%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.rb_insert_color
      0.14 ±  8%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__might_fault
      0.12 ± 28%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__x64_sys_read
      0.10 ± 29%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.10 ± 21%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.touch_atime
      0.08 ± 10%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.child
      0.00            +0.1        0.07 ± 25%  perf-profile.self.cycles-pp._find_first_zero_bit
      0.28 ± 23%      +0.6        0.85 ± 11%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.65 ± 30%      +0.8        1.41 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00           +38.8       38.76 ± 47%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  99babd04b2 ("selftests/rseq: Implement rseq numa node id field selftest")
  af7f588d8f ("sched: Introduce per-memory-map concurrency ID")

99babd04b2505471 af7f588d8f7355bc4298dd1962d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   8413415 ±  2%     -85.0%    1259200        will-it-scale.52.threads
     22.36           -83.3%       3.74        will-it-scale.52.threads_idle
    161796 ±  2%     -85.0%      24214        will-it-scale.per_thread_ops
   8413415 ±  2%     -85.0%    1259200        will-it-scale.workload
     10216 ±  2%     -40.9%       6040 ±  2%  uptime.idle
 2.233e+09           -73.2%  5.989e+08        cpuidle..time
  2.46e+09 ±  2%     -89.5%  2.577e+08 ±  3%  cpuidle..usage
    329714 ± 11%    +232.0%    1094566 ± 72%  numa-numastat.node0.local_node
    374570 ±  9%    +205.7%    1145060 ± 69%  numa-numastat.node0.numa_hit
   4491204 ±  2%     -53.1%    2106039 ± 36%  numa-numastat.node1.local_node
   4540680 ±  2%     -52.7%    2149877 ± 35%  numa-numastat.node1.numa_hit
     22.83           -18.4        4.43 ±  2%  mpstat.cpu.all.idle%
      1.44            +0.2        1.68        mpstat.cpu.all.irq%
      0.12 ±  2%      -0.0        0.10        mpstat.cpu.all.soft%
     59.94           +30.2       90.11        mpstat.cpu.all.sys%
     15.67           -12.0        3.68        mpstat.cpu.all.usr%
     22.83           -78.1%       5.00        vmstat.cpu.id
     60.33           +50.6%      90.83        vmstat.cpu.sy
     15.00           -80.0%       3.00        vmstat.cpu.us
  14294773 ±  2%     -53.0%    6714843 ±  9%  vmstat.memory.cache
     59.50           -12.3%      52.17        vmstat.procs.r
  16450432 ±  2%     -85.4%    2405190        vmstat.system.cs
    276754           +52.0%     420615 ±  2%  vmstat.system.in
   1431257 ±  8%   +1030.1%   16174000 ±  6%  turbostat.C1
      0.02 ± 17%      +0.3        0.29 ±  7%  turbostat.C1%
      0.77 ±  6%     +31.1%       1.01 ±  4%  turbostat.CPU%c1
     53.67 ±  2%     -14.6%      45.83 ±  2%  turbostat.CoreTmp
      0.09 ±  4%     -78.2%       0.02        turbostat.IPC
  84431937           +52.1%  1.284e+08 ±  2%  turbostat.IRQ
      6.83 ±  3%      -6.8        0.00        turbostat.PKG_%
 2.458e+09 ±  2%     -90.2%   2.41e+08 ±  3%  turbostat.POLL
      6.16            -5.5        0.69 ±  5%  turbostat.POLL%
     53.50 ±  2%     -13.1%      46.50 ±  3%  turbostat.PkgTmp
    365.46           -17.4%     301.75        turbostat.PkgWatt
     92948         +1761.8%    1730551 ±  4%  meminfo.Active
     92857         +1763.6%    1730458 ±  4%  meminfo.Active(anon)
    475097           -26.0%     351530        meminfo.AnonPages
  14131358 ±  2%     -53.3%    6596409 ±  9%  meminfo.Cached
  12167680 ±  2%     -62.9%    4516022 ±  5%  meminfo.Committed_AS
  11089942 ±  2%     -83.8%    1794273 ± 16%  meminfo.Inactive
  11089749 ±  2%     -83.8%    1794082 ± 16%  meminfo.Inactive(anon)
    146766           -11.5%     129954        meminfo.KReclaimable
   5019103 ±  3%     -69.4%    1533664 ±  7%  meminfo.Mapped
  16059430 ±  2%     -48.9%    8206619 ±  7%  meminfo.Memused
     14911 ±  2%     -47.7%       7796 ±  2%  meminfo.PageTables
    146766           -11.5%     129954        meminfo.SReclaimable
  10707913 ±  2%     -70.4%    3172409 ±  6%  meminfo.Shmem
  16146332 ±  2%     -25.6%   12012181 ±  4%  meminfo.max_used_kB
    382.33 ± 13%  +30777.3%     118054 ± 98%  numa-vmstat.node0.nr_active_anon
     44471 ± 32%    +315.1%     184580 ± 82%  numa-vmstat.node0.nr_inactive_anon
     44053          +211.7%     137333 ± 75%  numa-vmstat.node0.nr_mapped
      1598 ±  2%  +15438.7%     248438 ±106%  numa-vmstat.node0.nr_shmem
    382.33 ± 13%  +30777.3%     118054 ± 98%  numa-vmstat.node0.nr_zone_active_anon
     44471 ± 32%    +315.1%     184580 ± 82%  numa-vmstat.node0.nr_zone_inactive_anon
    374056 ±  9%    +206.0%    1144611 ± 69%  numa-vmstat.node0.numa_hit
    329200 ± 11%    +232.4%    1094117 ± 72%  numa-vmstat.node0.numa_local
     22812         +1275.5%     313777 ± 42%  numa-vmstat.node1.nr_active_anon
     75507 ± 19%     -55.4%      33711 ± 22%  numa-vmstat.node1.nr_anon_pages
   2702384 ±  2%     -78.4%     583457 ± 37%  numa-vmstat.node1.nr_file_pages
   2727949 ±  2%     -90.3%     264439 ± 35%  numa-vmstat.node1.nr_inactive_anon
   1210795 ±  3%     -79.6%     247430 ± 32%  numa-vmstat.node1.nr_mapped
      3083 ±  3%     -61.4%       1188 ± 24%  numa-vmstat.node1.nr_page_table_pages
   2675300 ±  2%     -79.7%     544388 ± 41%  numa-vmstat.node1.nr_shmem
     15383 ±  3%     -31.4%      10547 ± 10%  numa-vmstat.node1.nr_slab_reclaimable
     22812         +1275.5%     313776 ± 42%  numa-vmstat.node1.nr_zone_active_anon
   2727947 ±  2%     -90.3%     264439 ± 35%  numa-vmstat.node1.nr_zone_inactive_anon
   4540436 ±  2%     -52.7%    2149540 ± 35%  numa-vmstat.node1.numa_hit
   4490961 ±  3%     -53.1%    2105702 ± 36%  numa-vmstat.node1.numa_local
      1577 ± 15%  +29859.5%     472661 ± 98%  numa-meminfo.node0.Active
      1532 ± 13%  +30744.5%     472639 ± 98%  numa-meminfo.node0.Active(anon)
    177949 ± 32%    +315.0%     738476 ± 82%  numa-meminfo.node0.Inactive
    177854 ± 32%    +315.2%     738443 ± 82%  numa-meminfo.node0.Inactive(anon)
    176243          +211.6%     549130 ± 76%  numa-meminfo.node0.Mapped
      6399 ±  2%  +15435.9%     994269 ±107%  numa-meminfo.node0.Shmem
     94498 ±  6%   +1225.9%    1252939 ± 42%  numa-meminfo.node1.Active
     94453 ±  6%   +1226.4%    1252867 ± 42%  numa-meminfo.node1.Active(anon)
    155852 ± 34%     -68.9%      48404 ± 41%  numa-meminfo.node1.AnonHugePages
    301933 ± 19%     -55.4%     134805 ± 22%  numa-meminfo.node1.AnonPages
    376400 ± 15%     -43.1%     214145 ± 19%  numa-meminfo.node1.AnonPages.max
  10818908 ±  2%     -78.5%    2330479 ± 37%  numa-meminfo.node1.FilePages
  10917966 ±  2%     -90.3%    1056761 ± 35%  numa-meminfo.node1.Inactive
  10917868 ±  2%     -90.3%    1056603 ± 35%  numa-meminfo.node1.Inactive(anon)
     61560 ±  3%     -31.5%      42189 ± 10%  numa-meminfo.node1.KReclaimable
   4856202 ±  3%     -79.7%     987910 ± 32%  numa-meminfo.node1.Mapped
  11816207 ±  2%     -74.2%    3046680 ± 28%  numa-meminfo.node1.MemUsed
     12364 ±  2%     -61.6%       4742 ± 24%  numa-meminfo.node1.PageTables
     61560 ±  3%     -31.5%      42189 ± 10%  numa-meminfo.node1.SReclaimable
  10710570 ±  2%     -79.7%    2174201 ± 41%  numa-meminfo.node1.Shmem
    147398           -13.8%     127057 ±  6%  numa-meminfo.node1.Slab
     23418         +1746.6%     432430 ±  4%  proc-vmstat.nr_active_anon
    118759           -26.0%      87887        proc-vmstat.nr_anon_pages
   4488037            +4.4%    4684192        proc-vmstat.nr_dirty_background_threshold
   8987049            +4.4%    9379838        proc-vmstat.nr_dirty_threshold
   3533819 ±  2%     -53.3%    1648861 ±  9%  proc-vmstat.nr_file_pages
  45164003            +4.3%   47128423        proc-vmstat.nr_free_pages
   2773197 ±  2%     -83.8%     448466 ± 16%  proc-vmstat.nr_inactive_anon
   1256312 ±  3%     -69.5%     383482 ±  6%  proc-vmstat.nr_mapped
      3731 ±  2%     -48.1%       1936 ±  3%  proc-vmstat.nr_page_table_pages
   2677956 ±  2%     -70.4%     792860 ±  6%  proc-vmstat.nr_shmem
     36695           -11.5%      32488        proc-vmstat.nr_slab_reclaimable
     23418         +1746.6%     432430 ±  4%  proc-vmstat.nr_zone_active_anon
   2773197 ±  2%     -83.8%     448466 ± 16%  proc-vmstat.nr_zone_inactive_anon
    624422 ± 17%     -60.7%     245678 ± 15%  proc-vmstat.numa_hint_faults
    539128 ± 21%     -73.5%     142632 ± 19%  proc-vmstat.numa_hint_faults_local
   4916730 ±  2%     -33.0%    3296362        proc-vmstat.numa_hit
      2036 ± 18%     -83.4%     337.33 ± 17%  proc-vmstat.numa_huge_pte_updates
   4822398 ±  2%     -33.6%    3202031        proc-vmstat.numa_local
   1802325 ±  4%     -69.5%     550361 ±  9%  proc-vmstat.numa_pte_updates
     83499 ±162%   +1435.7%    1282307 ± 12%  proc-vmstat.pgactivate
   5055756 ±  2%     -32.8%    3395392        proc-vmstat.pgalloc_normal
   1857025 ±  5%     -26.5%    1365139 ±  2%  proc-vmstat.pgfault
    742457 ±  9%    +350.4%    3344225        proc-vmstat.pgfree
     39235            +8.1%      42423 ±  6%  proc-vmstat.pgreuse
    308870 ± 19%     -99.3%       2179 ±115%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   4280681           -94.7%     226660 ±115%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1073798 ±  9%     -97.9%      22118 ±115%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.68 ±  2%     +13.8%       0.77        sched_debug.cfs_rq:/.h_nr_running.avg
      0.42 ±  2%     -21.5%       0.33 ±  3%  sched_debug.cfs_rq:/.h_nr_running.stddev
      0.67 ± 45%    +183.3%       1.89 ±  8%  sched_debug.cfs_rq:/.load_avg.min
    308870 ± 19%     -99.3%       2179 ±115%  sched_debug.cfs_rq:/.max_vruntime.avg
   4280681           -94.7%     226660 ±115%  sched_debug.cfs_rq:/.max_vruntime.max
   1073798 ±  9%     -97.9%      22118 ±115%  sched_debug.cfs_rq:/.max_vruntime.stddev
   4201184           -19.5%    3381693        sched_debug.cfs_rq:/.min_vruntime.avg
   4494117           -13.4%    3892039 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
   4124946           -19.2%    3331483        sched_debug.cfs_rq:/.min_vruntime.min
      0.68           +12.2%       0.76        sched_debug.cfs_rq:/.nr_running.avg
      0.39 ±  3%     -20.5%       0.31 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
    451.34           -10.3%     404.65        sched_debug.cfs_rq:/.runnable_avg.avg
      1319           -11.5%       1167 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    154.04           -13.1%     133.83 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    447.52           -10.2%     401.95        sched_debug.cfs_rq:/.util_avg.avg
    135.46           -11.1%     120.41 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    230.77 ±  3%     -23.8%     175.94 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    940.25 ±  3%     -12.9%     818.86 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.max
    225.80           -10.3%     202.54        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    148237 ±  2%     +20.6%     178708        sched_debug.cpu.avg_idle.avg
      4546 ± 13%    +579.3%      30886 ±  2%  sched_debug.cpu.avg_idle.min
      5.75           +33.2%       7.66        sched_debug.cpu.clock.stddev
      2742 ±  3%     -10.0%       2468 ±  3%  sched_debug.cpu.curr->pid.avg
      6610 ± 23%     -31.1%       4557 ± 23%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  5%     +42.1%       0.00 ± 29%  sched_debug.cpu.next_balance.stddev
      0.52 ±  4%     -11.0%       0.47 ±  3%  sched_debug.cpu.nr_running.avg
  23781980 ±  2%     -85.3%    3489556        sched_debug.cpu.nr_switches.avg
  26139865 ±  3%     -70.4%    7732937 ± 11%  sched_debug.cpu.nr_switches.max
  20830845 ±  5%     -85.8%    2960756 ±  6%  sched_debug.cpu.nr_switches.min
   1902082 ± 27%     -74.7%     480695 ± 16%  sched_debug.cpu.nr_switches.stddev
      1.76 ± 17%    +206.4%       5.38 ±  3%  perf-stat.i.MPKI
 1.904e+10           -73.1%   5.12e+09        perf-stat.i.branch-instructions
      1.64            -0.5        1.15        perf-stat.i.branch-miss-rate%
 3.056e+08 ±  2%     -80.9%   58311136 ±  2%  perf-stat.i.branch-misses
     20.15 ± 13%      +6.3       26.45 ±  2%  perf-stat.i.cache-miss-rate%
  16636101 ±  2%     -85.4%    2432393        perf-stat.i.context-switches
      3.12 ±  2%    +296.6%      12.37        perf-stat.i.cpi
      1861           -33.6%       1236        perf-stat.i.cpu-migrations
      0.08 ±  5%      -0.0        0.04 ±  3%  perf-stat.i.dTLB-load-miss-rate%
  20981469 ±  5%     -85.8%    2981601 ±  5%  perf-stat.i.dTLB-load-misses
 2.678e+10           -74.9%   6.71e+09        perf-stat.i.dTLB-loads
      0.00 ± 18%      +0.0        0.00 ± 23%  perf-stat.i.dTLB-store-miss-rate%
    233103 ± 18%     -67.8%      74993 ± 22%  perf-stat.i.dTLB-store-misses
 1.604e+10           -82.2%  2.863e+09 ±  2%  perf-stat.i.dTLB-stores
  11175689 ±  3%     -82.1%    2004383 ± 24%  perf-stat.i.iTLB-load-misses
  23053320 ±  6%     -81.3%    4309745 ± 13%  perf-stat.i.iTLB-loads
 9.415e+10           -74.4%  2.406e+10        perf-stat.i.instructions
      8923 ±  2%     +47.9%      13200 ± 22%  perf-stat.i.instructions-per-iTLB-miss
      0.33           -74.4%       0.08        perf-stat.i.ipc
    596.29           -76.2%     142.20        perf-stat.i.metric.M/sec
      5512 ±  6%     -29.0%       3912 ±  3%  perf-stat.i.minor-faults
     56.02           +41.6       97.64        perf-stat.i.node-load-miss-rate%
   1970708 ±  4%    +314.9%    8176399 ±  4%  perf-stat.i.node-load-misses
   2639467 ±  5%     -89.9%     266188 ± 29%  perf-stat.i.node-loads
     85.83           +13.0       98.81        perf-stat.i.node-store-miss-rate%
   1884736 ±  3%    +152.2%    4752825 ±  2%  perf-stat.i.node-store-misses
    357304 ±  3%     -74.0%      93012 ±  6%  perf-stat.i.node-stores
      5512 ±  6%     -29.0%       3913 ±  3%  perf-stat.i.page-faults
      1.74 ± 16%    +210.5%       5.41 ±  3%  perf-stat.overall.MPKI
      1.60            -0.5        1.14        perf-stat.overall.branch-miss-rate%
     19.62 ± 13%      +6.0       25.62 ±  2%  perf-stat.overall.cache-miss-rate%
      3.06          +290.5%      11.94        perf-stat.overall.cpi
      0.08 ±  5%      -0.0        0.04 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 18%      +0.0        0.00 ± 22%  perf-stat.overall.dTLB-store-miss-rate%
      8429 ±  2%     +50.4%      12675 ± 22%  perf-stat.overall.instructions-per-iTLB-miss
      0.33           -74.4%       0.08        perf-stat.overall.ipc
     42.42 ±  2%     +54.4       96.80        perf-stat.overall.node-load-miss-rate%
     84.10           +14.0       98.08        perf-stat.overall.node-store-miss-rate%
   3374614           +71.0%    5770768        perf-stat.overall.path-length
 1.898e+10           -73.1%  5.105e+09        perf-stat.ps.branch-instructions
 3.046e+08 ±  2%     -80.9%   58149017 ±  2%  perf-stat.ps.branch-misses
  16582299 ±  2%     -85.4%    2424954        perf-stat.ps.context-switches
      1861           -33.8%       1231        perf-stat.ps.cpu-migrations
  20900401 ±  5%     -85.7%    2979011 ±  5%  perf-stat.ps.dTLB-load-misses
 2.669e+10           -74.9%  6.691e+09        perf-stat.ps.dTLB-loads
    231656 ± 18%     -67.6%      74972 ± 22%  perf-stat.ps.dTLB-store-misses
 1.599e+10           -82.1%  2.855e+09 ±  2%  perf-stat.ps.dTLB-stores
  11141515 ±  3%     -82.0%    2001300 ± 24%  perf-stat.ps.iTLB-load-misses
  22975410 ±  6%     -81.3%    4295158 ± 13%  perf-stat.ps.iTLB-loads
 9.385e+10           -74.4%    2.4e+10        perf-stat.ps.instructions
      5511 ±  6%     -29.2%       3901 ±  3%  perf-stat.ps.minor-faults
   1964291 ±  4%    +315.4%    8159316 ±  4%  perf-stat.ps.node-load-misses
   2667620 ±  5%     -90.0%     268054 ± 29%  perf-stat.ps.node-loads
   1878586 ±  3%    +152.2%    4737805 ±  2%  perf-stat.ps.node-store-misses
    354848 ±  3%     -73.9%      92786 ±  6%  perf-stat.ps.node-stores
      5512 ±  6%     -29.2%       3902 ±  3%  perf-stat.ps.page-faults
 2.839e+13           -74.4%  7.266e+12        perf-stat.total.instructions
     26.70           -21.8        4.92 ±  2%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event
     26.52           -21.6        4.88 ±  2%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
     24.81           -20.3        4.54 ±  2%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
     19.22           -15.2        4.02 ±  3%  perf-profile.calltrace.cycles-pp.__libc_write
     16.54           -13.1        3.48 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
     15.23           -12.4        2.79        perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
     15.46           -12.2        3.28 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     13.72           -11.5        2.27 ±  2%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch
     13.79           -10.7        3.09 ±  7%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     13.58           -10.7        2.90 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     11.44 ±  2%     -10.3        1.17        perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
     12.38            -9.7        2.69 ±  2%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.12            -9.5        2.58 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      9.83 ±  2%      -9.2        0.60 ± 76%  perf-profile.calltrace.cycles-pp.unwind_next_frame.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain
     11.66            -9.2        2.44 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      9.47 ±  3%      -9.0        0.44 ± 44%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
     10.60            -8.2        2.37 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     10.31            -8.1        2.18 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
     10.31            -8.0        2.32 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
     10.23            -7.9        2.30 ±  3%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
     10.04            -7.8        2.26 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      9.04            -7.6        1.42 ±  2%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.pipe_read.vfs_read
      9.54            -7.5        2.04 ±  2%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      8.81            -7.4        1.36 ±  2%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.pipe_read
      9.34            -7.4        1.98 ±  2%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      7.56            -7.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      8.54            -7.2        1.32 ±  2%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      9.07            -7.1        1.93 ±  2%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      9.00            -7.1        1.92 ±  2%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      8.84            -7.0        1.80 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      8.29            -6.6        1.66 ±  2%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      8.19            -6.5        1.72 ±  4%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      7.98            -6.3        1.69 ±  3%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      7.59            -6.0        1.62 ±  3%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
      7.54            -5.9        1.60 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      7.28            -5.7        1.60        perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      7.08            -5.5        1.54        perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle.do_idle
      6.89            -5.5        1.34 ±  4%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      6.85            -5.4        1.49        perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle
      5.32            -4.0        1.27 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      5.26            -4.0        1.26 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.42            -3.7        0.74 ±  5%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     52.88            -3.6       49.32        perf-profile.calltrace.cycles-pp.__libc_read
      2.85 ±  2%      -2.3        0.57 ±  2%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.38            -2.1        0.26 ±100%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.75 ± 14%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      0.75 ± 14%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.75 ± 14%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.75 ± 14%      -0.4        0.37 ± 71%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen
      0.76 ± 14%      -0.4        0.39 ± 71%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn
      0.76 ± 14%      -0.4        0.40 ± 71%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn.perf_mmap__push
      0.73 ±  6%      +0.7        1.44 ±  8%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
      0.00            +0.8        0.76 ± 10%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.60 ±  6%      +0.8        1.41 ±  8%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.pipe_read
      0.00            +0.9        0.89 ±  9%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.00            +0.9        0.93 ±  9%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.00            +1.1        1.09 ± 10%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
     45.74            +2.2       47.91        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     45.24            +2.6       47.83        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     44.49            +3.2       47.69        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.00            +6.1       47.15        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     40.89            +6.2       47.13        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     25.48           +19.7       45.16        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     25.46           +19.7       45.16        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     25.73           +19.8       45.52        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     25.30           +19.8       45.14        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     11.35           +31.1       42.42        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     11.18           +31.2       42.39        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00           +39.4       39.41        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle
      0.00           +39.6       39.63        perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle.do_idle
      0.00           +39.7       39.73        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00           +40.2       40.19        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule
      0.00           +40.4       40.41        perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule.pipe_read
      0.00           +40.5       40.50        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
     33.56           -26.7        6.85 ±  2%  perf-profile.children.cycles-pp.perf_tp_event
     32.38           -25.7        6.64 ±  2%  perf-profile.children.cycles-pp.__perf_event_overflow
     32.13           -25.5        6.59 ±  2%  perf-profile.children.cycles-pp.perf_event_output_forward
     29.34           -23.8        5.53 ±  2%  perf-profile.children.cycles-pp.perf_prepare_sample
     27.00           -21.9        5.14 ±  2%  perf-profile.children.cycles-pp.perf_callchain
     26.82           -21.7        5.10 ±  2%  perf-profile.children.cycles-pp.get_perf_callchain
     25.26           -20.5        4.79 ±  2%  perf-profile.children.cycles-pp.perf_callchain_kernel
     20.14           -15.5        4.66        perf-profile.children.cycles-pp.__libc_write
     18.18           -14.7        3.44        perf-profile.children.cycles-pp.unwind_next_frame
     66.41           -13.7       52.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.42           -13.4        3.05        perf-profile.children.cycles-pp.perf_trace_sched_switch
     64.30           -12.1       52.24        perf-profile.children.cycles-pp.do_syscall_64
     14.42           -11.0        3.45        perf-profile.children.cycles-pp.ksys_write
     13.86           -10.5        3.34        perf-profile.children.cycles-pp.vfs_write
     12.41            -9.7        2.70 ±  3%  perf-profile.children.cycles-pp.pipe_write
     10.68 ±  2%      -9.7        1.02 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
     11.71 ±  2%      -9.6        2.14        perf-profile.children.cycles-pp.__unwind_start
     12.13            -9.6        2.58 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
     11.72            -9.3        2.45 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
     10.62            -8.2        2.38 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
     10.68            -8.2        2.48 ±  2%  perf-profile.children.cycles-pp.update_curr
     10.32            -8.0        2.32 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
     10.25            -7.9        2.31 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
     10.06            -7.8        2.27 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      9.79            -7.5        2.29 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      8.99            -7.2        1.82 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
      8.19            -6.5        1.73 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      5.37            -4.1        1.28 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
      5.33            -4.1        1.27 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.52            -3.8        0.76 ±  4%  perf-profile.children.cycles-pp.poll_idle
     52.99            -3.6       49.35        perf-profile.children.cycles-pp.__libc_read
      3.85            -3.1        0.75 ±  3%  perf-profile.children.cycles-pp.unwind_get_return_address
      3.84            -3.1        0.75 ±  3%  perf-profile.children.cycles-pp.__orc_find
      3.53            -2.8        0.71 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.18            -2.5        0.68 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.05            -2.4        0.69 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      2.92            -2.4        0.56 ±  3%  perf-profile.children.cycles-pp.__kernel_text_address
      2.89 ±  3%      -2.3        0.58        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      2.66 ±  2%      -2.2        0.46        perf-profile.children.cycles-pp.stack_access_ok
      2.39            -1.9        0.48 ±  2%  perf-profile.children.cycles-pp.orc_find
      2.20 ±  5%      -1.9        0.34 ±  7%  perf-profile.children.cycles-pp.menu_select
      2.62            -1.8        0.78 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.19            -1.8        0.44 ±  4%  perf-profile.children.cycles-pp.kernel_text_address
      2.50 ±  2%      -1.7        0.76 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.04 ±  2%      -1.4        0.61 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      1.58 ±  3%      -1.1        0.44 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      1.42            -1.1        0.29 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      1.48 ±  2%      -1.1        0.35 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.30 ±  3%      -1.1        0.21 ±  4%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      1.10 ±  3%      -0.9        0.22 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.99            -0.9        0.12 ±  4%  perf-profile.children.cycles-pp.perf_output_begin_forward
      1.02 ±  4%      -0.9        0.15 ±  9%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.93 ±  2%      -0.8        0.12 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.93 ±  3%      -0.8        0.17 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      1.02 ±  2%      -0.8        0.26 ±  8%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.91 ±  2%      -0.7        0.18 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.82 ±  6%      -0.7        0.12 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.86            -0.7        0.18 ±  3%  perf-profile.children.cycles-pp.perf_callchain_user
      0.80 ±  4%      -0.7        0.13 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      0.78 ±  2%      -0.7        0.13 ± 10%  perf-profile.children.cycles-pp.__switch_to_asm
      0.79 ±  4%      -0.6        0.15 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.74 ±  3%      -0.6        0.10 ± 11%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.71 ±  6%      -0.6        0.11 ±  5%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.70 ±  3%      -0.6        0.11 ±  6%  perf-profile.children.cycles-pp.__switch_to
      1.44 ±  4%      -0.6        0.86        perf-profile.children.cycles-pp.perf_output_sample
      2.24 ±  4%      -0.5        1.70 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.72 ±  2%      -0.5        0.20 ±  9%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.58 ±  4%      -0.5        0.08 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.62 ±  2%      -0.5        0.14 ±  5%  perf-profile.children.cycles-pp.core_kernel_text
      0.59 ± 11%      -0.5        0.11 ±  8%  perf-profile.children.cycles-pp.copy_page_from_iter
      1.17 ±  3%      -0.5        0.69        perf-profile.children.cycles-pp.__output_copy
      0.57 ±  4%      -0.4        0.12 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.54 ±  4%      -0.4        0.11 ±  4%  perf-profile.children.cycles-pp.__fget_light
      0.47 ±  8%      -0.4        0.05 ±  8%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.94 ±  4%      -0.4        0.53        perf-profile.children.cycles-pp.perf_output_copy
      0.52 ±  6%      -0.4        0.11 ± 10%  perf-profile.children.cycles-pp.security_file_permission
      0.47 ±  6%      -0.4        0.08 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.47 ± 14%      -0.4        0.08 ± 20%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.45 ±  4%      -0.4        0.06 ±  7%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.52 ±  3%      -0.4        0.15 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.47            -0.4        0.10 ±  3%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.46 ± 10%      -0.4        0.09 ±  9%  perf-profile.children.cycles-pp._copy_from_iter
      0.44            -0.4        0.08 ±  8%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.45 ±  4%      -0.4        0.10 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.45 ±  3%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.41 ± 12%      -0.3        0.07 ± 19%  perf-profile.children.cycles-pp._copy_to_iter
      0.41 ±  5%      -0.3        0.08 ± 11%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.81 ±  3%      -0.3        0.48        perf-profile.children.cycles-pp.memcpy_erms
      0.41 ±  2%      -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.__fget_files
      0.38 ±  3%      -0.3        0.06 ±  9%  perf-profile.children.cycles-pp.__update_idle_core
      0.38 ± 18%      -0.3        0.07 ± 18%  perf-profile.children.cycles-pp.touch_atime
      0.80 ± 17%      -0.3        0.50 ± 16%  perf-profile.children.cycles-pp.generic_perform_write
      0.38 ±  2%      -0.3        0.08 ±  6%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.80 ± 17%      -0.3        0.51 ± 16%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.42            -0.3        0.12 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.81 ± 17%      -0.3        0.52 ± 16%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.44 ±  9%      -0.3        0.16 ± 10%  perf-profile.children.cycles-pp.copyin
      0.41 ±  3%      -0.3        0.13 ±  5%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.35 ±  6%      -0.3        0.07 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.30 ±  3%      -0.3        0.02 ± 99%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.30 ± 22%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.atime_needs_update
      0.35 ±  7%      -0.3        0.08 ± 24%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.32 ±  5%      -0.3        0.06 ± 11%  perf-profile.children.cycles-pp.os_xsave
      0.32 ± 24%      -0.3        0.05 ± 47%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.33 ±  3%      -0.3        0.07 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.29 ±  8%      -0.3        0.02 ± 99%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.32 ±  7%      -0.3        0.06 ±  8%  perf-profile.children.cycles-pp.get_stack_info
      0.40 ± 11%      -0.3        0.15 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.28 ±  9%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.32 ±  3%      -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.__might_resched
      0.26 ±  2%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.perf_instruction_pointer
      0.42 ±  3%      -0.2        0.19 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.27 ±  2%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.__might_fault
      0.27 ±  4%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.kvm_guest_state
      0.26 ±  3%      -0.2        0.06 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.25 ±  5%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.22 ±  7%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.get_callchain_entry
      0.22 ±  3%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.__cond_resched
      0.68 ±  3%      -0.2        0.49 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.81 ± 16%      -0.2        0.63 ± 17%  perf-profile.children.cycles-pp.writen
      0.81 ± 16%      -0.2        0.63 ± 17%  perf-profile.children.cycles-pp.record__pushfn
      0.60 ±  4%      -0.2        0.42 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.24 ±  5%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.30 ± 17%      -0.2        0.14 ± 13%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.19 ±  7%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.file_update_time
      0.34 ± 18%      -0.1        0.20 ± 17%  perf-profile.children.cycles-pp.shmem_write_begin
      0.33 ± 18%      -0.1        0.19 ± 18%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.47 ±  4%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.46 ±  4%      -0.1        0.33 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.14 ±  6%      -0.1        0.05        perf-profile.children.cycles-pp.native_irq_return_iret
      0.15 ±  5%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.select_idle_sibling
      0.17 ±  4%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.12 ± 12%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.place_entity
      0.19 ± 12%      -0.1        0.12 ± 29%  perf-profile.children.cycles-pp.process_simple
      0.18 ± 11%      -0.1        0.11 ± 27%  perf-profile.children.cycles-pp.ordered_events__queue
      0.12 ± 16%      -0.1        0.06 ± 45%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.13 ± 20%      -0.1        0.07 ± 15%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      0.31 ±  3%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.09 ± 21%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.10 ± 19%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.26 ±  4%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.10 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      0.23 ±  5%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.23 ±  5%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.update_blocked_averages
      0.09 ± 14%      +0.3        0.40 ± 13%  perf-profile.children.cycles-pp.intel_idle_irq
      0.09 ± 11%      +0.3        0.40 ± 13%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      0.00            +0.8        0.78 ± 10%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.61 ±  5%      +0.8        1.41 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.9        0.90 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.9        0.94 ±  9%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +1.1        1.11 ± 10%  perf-profile.children.cycles-pp.load_balance
     45.78            +2.2       47.94        perf-profile.children.cycles-pp.ksys_read
     45.26            +2.6       47.85        perf-profile.children.cycles-pp.vfs_read
     44.56            +3.1       47.71        perf-profile.children.cycles-pp.pipe_read
     41.02            +6.2       47.19        perf-profile.children.cycles-pp.schedule
     25.48           +19.7       45.16        perf-profile.children.cycles-pp.start_secondary
     25.73           +19.8       45.52        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     25.73           +19.8       45.52        perf-profile.children.cycles-pp.cpu_startup_entry
     25.66           +19.9       45.51        perf-profile.children.cycles-pp.do_idle
     11.49           +31.3       42.77        perf-profile.children.cycles-pp.schedule_idle
     52.29           +37.6       89.92        perf-profile.children.cycles-pp.__schedule
      0.63 ±  2%     +79.9       80.56        perf-profile.children.cycles-pp.prepare_task_switch
      0.00           +80.0       80.01        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.30           +80.3       80.56        perf-profile.children.cycles-pp._raw_spin_lock
      9.60 ±  3%      -9.2        0.40 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
      8.30 ±  2%      -7.8        0.46 ±  3%  perf-profile.self.cycles-pp.__schedule
      9.18 ±  2%      -7.5        1.72        perf-profile.self.cycles-pp.unwind_next_frame
      4.01            -3.3        0.68 ±  4%  perf-profile.self.cycles-pp.poll_idle
      3.81            -3.1        0.75 ±  3%  perf-profile.self.cycles-pp.__orc_find
      3.14 ±  2%      -2.5        0.62 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.18            -2.5        0.68 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.39            -2.0        0.41 ±  2%  perf-profile.self.cycles-pp.stack_access_ok
      2.24            -1.8        0.45 ±  2%  perf-profile.self.cycles-pp.orc_find
      2.16            -1.7        0.45 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.91            -1.5        0.37 ±  3%  perf-profile.self.cycles-pp.perf_callchain_kernel
      1.30            -1.1        0.23        perf-profile.self.cycles-pp.__unwind_start
      1.23            -1.0        0.26 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      1.14            -0.9        0.22 ±  3%  perf-profile.self.cycles-pp.kernel_text_address
      0.99 ±  5%      -0.8        0.14 ±  9%  perf-profile.self.cycles-pp.menu_select
      0.96 ±  2%      -0.8        0.11 ±  4%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.89            -0.7        0.18 ±  5%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.89 ±  2%      -0.7        0.18 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.81 ±  6%      -0.7        0.12 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.85 ±  5%      -0.7        0.16 ±  4%  perf-profile.self.cycles-pp.perf_tp_event
      0.78 ±  2%      -0.6        0.13 ± 10%  perf-profile.self.cycles-pp.__switch_to_asm
      0.73 ±  6%      -0.6        0.10 ± 14%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.73 ±  2%      -0.6        0.12 ±  4%  perf-profile.self.cycles-pp.__kernel_text_address
      0.72 ±  4%      -0.6        0.16 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
      0.67 ±  7%      -0.6        0.11 ±  9%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.66 ±  4%      -0.6        0.10 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.70 ±  4%      -0.5        0.18 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.55 ±  3%      -0.5        0.08 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.58 ±  6%      -0.5        0.11 ±  6%  perf-profile.self.cycles-pp.newidle_balance
      0.54 ±  4%      -0.4        0.11 ±  4%  perf-profile.self.cycles-pp.pipe_write
      0.52 ±  7%      -0.4        0.10 ±  5%  perf-profile.self.cycles-pp.pipe_read
      0.45 ± 11%      -0.4        0.05 ±  8%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.46            -0.4        0.09 ±  5%  perf-profile.self.cycles-pp.get_perf_callchain
      0.45 ±  5%      -0.4        0.08        perf-profile.self.cycles-pp.update_cfs_group
      0.46 ±  2%      -0.4        0.10 ±  3%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.42 ±  7%      -0.4        0.07 ±  7%  perf-profile.self.cycles-pp.dequeue_entity
      0.40 ±  7%      -0.3        0.06 ±  8%  perf-profile.self.cycles-pp.mutex_lock
      0.37 ±  4%      -0.3        0.02 ± 99%  perf-profile.self.cycles-pp.ktime_get
      0.44 ±  5%      -0.3        0.09 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.40 ± 11%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.44 ±  4%      -0.3        0.10 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.79 ±  3%      -0.3        0.47 ±  2%  perf-profile.self.cycles-pp.memcpy_erms
      0.40 ±  3%      -0.3        0.08 ±  5%  perf-profile.self.cycles-pp.__fget_files
      0.40 ±  3%      -0.3        0.09 ± 10%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.37 ±  4%      -0.3        0.06 ± 11%  perf-profile.self.cycles-pp.do_idle
      0.37 ±  3%      -0.3        0.08 ±  6%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.43 ±  4%      -0.3        0.14 ±  8%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.39 ±  4%      -0.3        0.10        perf-profile.self.cycles-pp.dequeue_task_fair
      0.35 ±  2%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.34 ±  6%      -0.3        0.06 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.34 ±  2%      -0.3        0.07 ±  9%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.32 ±  6%      -0.3        0.06 ± 11%  perf-profile.self.cycles-pp.os_xsave
      0.32 ±  2%      -0.3        0.06        perf-profile.self.cycles-pp.perf_callchain_user
      0.31 ±  6%      -0.3        0.05 ±  7%  perf-profile.self.cycles-pp.vfs_write
      0.33 ±  8%      -0.3        0.07 ±  9%  perf-profile.self.cycles-pp.core_kernel_text
      0.31 ±  4%      -0.3        0.06 ±  6%  perf-profile.self.cycles-pp.set_next_entity
      0.31 ±  6%      -0.3        0.06        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.28 ± 26%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.31 ±  2%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.__might_resched
      0.38 ± 11%      -0.2        0.15 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.29 ±  2%      -0.2        0.06        perf-profile.self.cycles-pp.___perf_sw_event
      0.28 ±  6%      -0.2        0.05 ±  7%  perf-profile.self.cycles-pp.vfs_read
      0.27 ±  2%      -0.2        0.05 ±  7%  perf-profile.self.cycles-pp.__libc_write
      0.26 ±  6%      -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.__libc_read
      0.38 ±  2%      -0.2        0.16 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.24 ±  3%      -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.kvm_guest_state
      0.24 ±  6%      -0.2        0.04 ± 44%  perf-profile.self.cycles-pp.try_to_wake_up
      0.22 ±  4%      -0.2        0.02 ± 99%  perf-profile.self.cycles-pp.do_syscall_64
      0.22 ±  5%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.24 ±  9%      -0.2        0.06 ±  9%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.29 ±  5%      -0.2        0.11 ±  7%  perf-profile.self.cycles-pp.prepare_task_switch
      0.27 ±  5%      -0.2        0.09 ±  9%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.33 ±  6%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__output_copy
      0.18 ±  4%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.14 ±  6%      -0.1        0.05        perf-profile.self.cycles-pp.native_irq_return_iret
      0.23 ±  9%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.perf_output_sample
      0.17 ± 10%      -0.1        0.10 ± 27%  perf-profile.self.cycles-pp.queue_event
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.30            +0.3        0.55 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.09 ± 14%      +0.3        0.40 ± 13%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      0.00            +0.6        0.64 ± 10%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00           +80.0       80.01        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-11/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/2T/lkp-csl-2sp3/shm-xread-seq-mt/vm-scalability

commit: 
  99babd04b2 ("selftests/rseq: Implement rseq numa node id field selftest")
  af7f588d8f ("sched: Introduce per-memory-map concurrency ID")

99babd04b2505471 af7f588d8f7355bc4298dd1962d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    210861            -9.0%     191845        vm-scalability.median
  20242720            -9.0%   18417158        vm-scalability.throughput
  55019520           -10.2%   49390360        vm-scalability.time.maximum_resident_set_size
   1.9e+08           -12.8%  1.657e+08        vm-scalability.time.minor_page_faults
      2259            +7.5%       2428        vm-scalability.time.percent_of_cpu_this_job_got
      4300           +19.2%       5126        vm-scalability.time.system_time
      2642 ±  2%     -11.8%       2329        vm-scalability.time.user_time
 2.705e+08            -4.5%  2.583e+08        vm-scalability.time.voluntary_context_switches
 6.075e+09            -8.9%  5.535e+09        vm-scalability.workload
     14.58            +3.3       17.91        mpstat.cpu.all.sys%
  11802313 ±  2%     -15.5%    9968423 ±  8%  numa-numastat.node1.local_node
  11868695 ±  2%     -15.5%   10031212 ±  7%  numa-numastat.node1.numa_hit
  31341412            -8.8%   28589584        vmstat.memory.cache
   1739822            -4.6%    1659696        vmstat.system.cs
    198273           +12.4%     222847        vmstat.system.in
  29152003            -9.6%   26360019        meminfo.Committed_AS
  10192230 ±  8%     -23.6%    7787187 ± 10%  meminfo.DirectMap2M
  27542178            -9.8%   24843166        meminfo.Inactive
  27541034            -9.8%   24842025        meminfo.Inactive(anon)
  26690232            -9.7%   24102542        meminfo.Mapped
     57049            -8.9%      51976        meminfo.PageTables
  27457190            -9.9%   24751049        meminfo.Shmem
    910.33           +15.6%       1052        turbostat.Avg_MHz
     29.46            +4.6       34.05        turbostat.Busy%
 1.992e+08 ±  2%     -11.3%  1.767e+08        turbostat.C1
     44.78            -5.7       39.12        turbostat.C1%
     56047 ± 92%   +1006.4%     620087 ± 67%  turbostat.C6
      0.24           -20.8%       0.19        turbostat.IPC
  62645660           +12.3%   70378539        turbostat.IRQ
    225.94            +2.1%     230.71        turbostat.PkgWatt
     39.08            +1.0%      39.47        turbostat.RAMWatt
    248641 ± 19%     +35.2%     336049 ± 14%  numa-meminfo.node0.AnonPages.max
  17517837           -19.5%   14100517 ± 16%  numa-meminfo.node0.FilePages
    114473 ±  2%     -35.4%      73942 ± 36%  numa-meminfo.node0.KReclaimable
  18308067           -18.7%   14882836 ± 15%  numa-meminfo.node0.MemUsed
    114473 ±  2%     -35.4%      73942 ± 36%  numa-meminfo.node0.SReclaimable
    224848 ±  2%     -17.6%     185243 ± 16%  numa-meminfo.node0.Slab
   3738197           -66.8%    1241460 ±140%  numa-meminfo.node0.Unevictable
  13816698 ±  3%     -13.3%   11974436 ±  9%  numa-meminfo.node1.Inactive
  13816181 ±  3%     -13.3%   11973743 ±  9%  numa-meminfo.node1.Inactive(anon)
  13327964 ±  3%     -12.8%   11622819 ±  8%  numa-meminfo.node1.Mapped
     28651 ±  2%     -13.3%      24845 ±  9%  numa-meminfo.node1.PageTables
  13689339 ±  2%     -13.2%   11880742 ±  8%  numa-meminfo.node1.Shmem
     26826 ±122%   +9309.0%    2524087 ± 69%  numa-meminfo.node1.Unevictable
   4378477           -19.5%    3524382 ± 16%  numa-vmstat.node0.nr_file_pages
     28614 ±  2%     -35.4%      18480 ± 36%  numa-vmstat.node0.nr_slab_reclaimable
    934549           -66.8%     310364 ±140%  numa-vmstat.node0.nr_unevictable
    934549           -66.8%     310364 ±140%  numa-vmstat.node0.nr_zone_unevictable
   3452954 ±  3%     -13.3%    2992588 ±  9%  numa-vmstat.node1.nr_inactive_anon
   3330866 ±  3%     -12.8%    2904357 ±  8%  numa-vmstat.node1.nr_mapped
      7166 ±  2%     -13.3%       6214 ±  9%  numa-vmstat.node1.nr_page_table_pages
   3421209 ±  2%     -13.2%    2969320 ±  8%  numa-vmstat.node1.nr_shmem
      6706 ±122%   +9309.8%     631021 ± 69%  numa-vmstat.node1.nr_unevictable
   3452953 ±  3%     -13.3%    2992587 ±  9%  numa-vmstat.node1.nr_zone_inactive_anon
      6706 ±122%   +9309.8%     631021 ± 69%  numa-vmstat.node1.nr_zone_unevictable
  11868617 ±  2%     -15.5%   10031142 ±  7%  numa-vmstat.node1.numa_hit
  11802234 ±  2%     -15.5%    9968353 ±  8%  numa-vmstat.node1.numa_local
     61039            -4.3%      58390 ±  2%  proc-vmstat.nr_active_anon
   2454405            +2.8%    2522406        proc-vmstat.nr_dirty_background_threshold
   4914813            +2.8%    5050981        proc-vmstat.nr_dirty_threshold
   7805675            -8.7%    7129014        proc-vmstat.nr_file_pages
  24733767            +2.8%   25414774        proc-vmstat.nr_free_pages
   6885305            -9.8%    6210359        proc-vmstat.nr_inactive_anon
   6672510            -9.7%    6025638        proc-vmstat.nr_mapped
     14262            -8.9%      12994        proc-vmstat.nr_page_table_pages
   6864084            -9.9%    6187292        proc-vmstat.nr_shmem
     44375            -3.4%      42867        proc-vmstat.nr_slab_reclaimable
     61039            -4.3%      58390 ±  2%  proc-vmstat.nr_zone_active_anon
   6885305            -9.8%    6210359        proc-vmstat.nr_zone_inactive_anon
  24681264           -12.8%   21531077        proc-vmstat.numa_hit
  24592528           -12.8%   21443489        proc-vmstat.numa_local
  24808648           -12.6%   21680796        proc-vmstat.pgalloc_normal
 1.912e+08           -12.7%  1.669e+08        proc-vmstat.pgfault
  24814673           -12.6%   21686002        proc-vmstat.pgfree
      6448 ± 45%    +115.5%      13893 ± 22%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    531865 ± 56%     +59.3%     847386 ±  2%  sched_debug.cfs_rq:/.MIN_vruntime.max
     57529 ± 51%     +81.1%     104202 ± 10%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.22 ±  6%     +11.1%       0.25 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
     10123 ±  6%     +15.6%      11702 ±  7%  sched_debug.cfs_rq:/.load.avg
    365.17 ± 36%     -41.9%     212.22        sched_debug.cfs_rq:/.load_avg.max
      6448 ± 45%    +115.5%      13893 ± 22%  sched_debug.cfs_rq:/.max_vruntime.avg
    531865 ± 56%     +59.3%     847386 ±  2%  sched_debug.cfs_rq:/.max_vruntime.max
     57529 ± 51%     +81.1%     104202 ± 10%  sched_debug.cfs_rq:/.max_vruntime.stddev
    782070           +13.6%     888573        sched_debug.cfs_rq:/.min_vruntime.avg
    821150           +13.6%     932625        sched_debug.cfs_rq:/.min_vruntime.max
    753697           +12.3%     846465        sched_debug.cfs_rq:/.min_vruntime.min
      0.22 ±  5%     +11.4%       0.25 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
     -5981          -259.2%       9521 ± 80%  sched_debug.cfs_rq:/.spread0.avg
      1179           +11.2%       1311 ±  3%  sched_debug.cpu.curr->pid.avg
      0.22           +13.5%       0.25 ±  2%  sched_debug.cpu.nr_running.avg
     18886 ± 16%     +41.6%      26735 ± 12%  sched_debug.cpu.nr_switches.stddev
      4.18            +8.6%       4.54        perf-stat.i.MPKI
  2.29e+10            -8.2%  2.101e+10        perf-stat.i.branch-instructions
      0.19            +0.0        0.22 ±  2%  perf-stat.i.branch-miss-rate%
  40178596            +6.8%   42925617        perf-stat.i.branch-misses
     21.94            +1.8       23.76        perf-stat.i.cache-miss-rate%
  66452612            +8.9%   72391872        perf-stat.i.cache-misses
   1760358            -4.6%    1678776        perf-stat.i.context-switches
      1.20           +24.5%       1.49        perf-stat.i.cpi
 8.839e+10           +15.2%  1.018e+11        perf-stat.i.cpu-cycles
      6205            +7.3%       6660        perf-stat.i.cpu-migrations
      1330            +5.9%       1408        perf-stat.i.cycles-between-cache-misses
   4572848           -10.1%    4112764        perf-stat.i.dTLB-load-misses
 2.122e+10            -7.9%  1.954e+10        perf-stat.i.dTLB-loads
      0.02            -0.0        0.02        perf-stat.i.dTLB-store-miss-rate%
    702307           -13.0%     611099        perf-stat.i.dTLB-store-misses
 3.917e+09            -7.5%  3.622e+09        perf-stat.i.dTLB-stores
   4714448            -5.7%    4444422        perf-stat.i.iTLB-load-misses
  10445194            -7.0%    9716326        perf-stat.i.iTLB-loads
 7.353e+10            -7.6%  6.797e+10        perf-stat.i.instructions
      0.84           -19.4%       0.67        perf-stat.i.ipc
      0.92           +15.2%       1.06        perf-stat.i.metric.GHz
    473.64            +4.2%     493.63        perf-stat.i.metric.K/sec
    503.52            -8.0%     463.30        perf-stat.i.metric.M/sec
    620975           -12.9%     541054        perf-stat.i.minor-faults
  19518092            +6.5%   20793294        perf-stat.i.node-load-misses
   1039427            -8.9%     946875 ±  2%  perf-stat.i.node-loads
  10095749           +15.1%   11618998        perf-stat.i.node-store-misses
    620979           -12.9%     541058        perf-stat.i.page-faults
      4.22            +7.5%       4.54        perf-stat.overall.MPKI
      0.18            +0.0        0.20        perf-stat.overall.branch-miss-rate%
     21.43            +2.1       23.49        perf-stat.overall.cache-miss-rate%
      1.20           +24.6%       1.50        perf-stat.overall.cpi
      1330            +5.8%       1406 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.02            -0.0        0.02        perf-stat.overall.dTLB-load-miss-rate%
      0.02            -0.0        0.02        perf-stat.overall.dTLB-store-miss-rate%
     15600            -2.0%      15295        perf-stat.overall.instructions-per-iTLB-miss
      0.83           -19.7%       0.67        perf-stat.overall.ipc
      3724            +1.6%       3783        perf-stat.overall.path-length
 2.282e+10            -8.2%  2.094e+10        perf-stat.ps.branch-instructions
  40052157            +6.9%   42799990        perf-stat.ps.branch-misses
  66240006            +9.0%   72170753        perf-stat.ps.cache-misses
   1754492            -4.6%    1673329        perf-stat.ps.context-switches
  8.81e+10           +15.2%  1.015e+11        perf-stat.ps.cpu-cycles
      6191            +7.3%       6646        perf-stat.ps.cpu-migrations
   4557705           -10.1%    4099312        perf-stat.ps.dTLB-load-misses
 2.115e+10            -7.9%  1.947e+10        perf-stat.ps.dTLB-loads
    699965           -13.0%     609113        perf-stat.ps.dTLB-store-misses
 3.904e+09            -7.5%  3.611e+09        perf-stat.ps.dTLB-stores
   4698565            -5.7%    4429361        perf-stat.ps.iTLB-load-misses
  10410202            -7.0%    9684466        perf-stat.ps.iTLB-loads
 7.329e+10            -7.6%  6.775e+10        perf-stat.ps.instructions
    618900           -12.9%     539304        perf-stat.ps.minor-faults
  19458339            +6.6%   20734296        perf-stat.ps.node-load-misses
   1036377            -8.9%     944375 ±  2%  perf-stat.ps.node-loads
  10063664           +15.1%   11583746        perf-stat.ps.node-store-misses
    618903           -12.9%     539307        perf-stat.ps.page-faults
 2.263e+13            -7.4%  2.094e+13        perf-stat.total.instructions
     23.77            -3.8       19.94 ±  3%  perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     17.03            -3.4       13.62        perf-profile.calltrace.cycles-pp.do_rw_once
     27.40            -2.9       24.55        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     47.87            -2.6       45.25        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     46.90            -2.5       44.43        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     47.06            -2.4       44.67        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     12.10            -1.7       10.37        perf-profile.calltrace.cycles-pp.finish_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
     12.01            -1.7       10.30        perf-profile.calltrace.cycles-pp._raw_spin_lock.finish_fault.do_read_fault.do_fault.__handle_mm_fault
     11.80            -1.6       10.15        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.finish_fault.do_read_fault.do_fault
     10.69            -0.8        9.89        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.94            -0.6        0.35 ± 70%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_wait_bit_common.__filemap_get_folio.shmem_get_folio_gfp.shmem_fault
      8.46            -0.5        7.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      8.37            -0.5        7.89        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.filemap_map_pages.do_read_fault.do_fault
      4.22 ±  5%      -0.4        3.79 ±  2%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.20            -0.3        0.93 ±  3%  perf-profile.calltrace.cycles-pp.folio_wake_bit.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.57            -0.3        1.30        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.97            -0.2        0.77 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.folio_wake_bit.do_read_fault.do_fault.__handle_mm_fault
      0.76            -0.2        0.56 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_page_function.__wake_up_common.folio_wake_bit.do_read_fault
      1.03            -0.2        0.85        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.86            -0.2        0.68 ±  2%  perf-profile.calltrace.cycles-pp.wake_page_function.__wake_up_common.folio_wake_bit.do_read_fault.do_fault
      0.76 ±  2%      -0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.next_uptodate_page.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.80            -0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.61            -0.1        0.55        perf-profile.calltrace.cycles-pp.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.97            -0.0        0.92        perf-profile.calltrace.cycles-pp.folio_wake_bit.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.58 ±  2%      -0.0        0.54        perf-profile.calltrace.cycles-pp._raw_spin_lock.handle_pte_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.57 ±  2%      -0.0        0.53        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.handle_pte_fault.__handle_mm_fault.handle_mm_fault
     14.92            +0.9       15.86        perf-profile.calltrace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     14.92            +0.9       15.86        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     30.86            +1.4       32.30        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     29.74            +1.5       31.20        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     29.59            +1.5       31.05        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     28.77            +1.5       30.23        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     28.76            +1.5       30.23        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     30.41            +1.5       31.93        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     30.42            +1.5       31.94        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
      7.72 ±  4%      +1.9        9.65 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
     50.46            +2.1       52.56        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.47            +2.1       52.57        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     50.45            +2.1       52.55        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.93            +2.2       53.16        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      4.41            +4.3        8.75 ±  2%  perf-profile.calltrace.cycles-pp.__do_fault.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      4.39            +4.4        8.74 ±  2%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.00            +4.4        4.36 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle
      4.28            +4.4        8.68 ±  2%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault.do_fault
      3.86            +4.5        8.34 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.shmem_get_folio_gfp.shmem_fault.__do_fault.do_read_fault
      3.39            +4.6        8.01 ±  3%  perf-profile.calltrace.cycles-pp.folio_wait_bit_common.__filemap_get_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.00            +4.7        4.71 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule_idle.do_idle
      0.00            +4.7        4.73 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.prepare_task_switch.__schedule.schedule
      0.00            +4.9        4.87 ±  5%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +5.1        5.05 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.prepare_task_switch.__schedule.schedule.io_schedule
      0.66            +5.1        5.73 ±  4%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.62            +5.1        5.70 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      1.77            +5.1        6.90 ±  4%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.folio_wait_bit_common.__filemap_get_folio.shmem_get_folio_gfp
      1.78            +5.1        6.91 ±  4%  perf-profile.calltrace.cycles-pp.io_schedule.folio_wait_bit_common.__filemap_get_folio.shmem_get_folio_gfp.shmem_fault
      1.74            +5.1        6.88 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.folio_wait_bit_common.__filemap_get_folio
      0.00            +5.2        5.17 ±  5%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.io_schedule.folio_wait_bit_common
     14.97            -3.1       11.87        perf-profile.children.cycles-pp.do_rw_once
     27.65            -2.8       24.82        perf-profile.children.cycles-pp.intel_idle_irq
     48.31            -2.6       45.76        perf-profile.children.cycles-pp.cpuidle_idle_call
     47.33            -2.4       44.92        perf-profile.children.cycles-pp.cpuidle_enter
     47.32            -2.4       44.92        perf-profile.children.cycles-pp.cpuidle_enter_state
     42.69            -1.8       40.85        perf-profile.children.cycles-pp.mwait_idle_with_hints
     12.10            -1.7       10.37        perf-profile.children.cycles-pp.finish_fault
     10.69            -0.8        9.89        perf-profile.children.cycles-pp.filemap_map_pages
      4.27 ±  4%      -0.4        3.83 ±  2%  perf-profile.children.cycles-pp.poll_idle
      1.02            -0.4        0.58 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.18            -0.3        1.85        perf-profile.children.cycles-pp.folio_wake_bit
      1.59            -0.3        1.32        perf-profile.children.cycles-pp.flush_smp_call_function_queue
     39.78            -0.2       39.54        perf-profile.children.cycles-pp.do_access
      1.73            -0.2        1.52        perf-profile.children.cycles-pp.__wake_up_common
      1.35 ±  2%      -0.2        1.14        perf-profile.children.cycles-pp.try_to_wake_up
      1.53            -0.2        1.35        perf-profile.children.cycles-pp.wake_page_function
      0.76 ±  2%      -0.2        0.59 ±  4%  perf-profile.children.cycles-pp.next_uptodate_page
      1.05            -0.2        0.88        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.70 ±  2%      -0.2        0.55        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.82 ±  2%      -0.1        0.70 ±  3%  perf-profile.children.cycles-pp.menu_select
      0.89 ±  5%      -0.1        0.78        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.56            -0.1        0.47        perf-profile.children.cycles-pp.ttwu_do_activate
      0.64 ±  8%      -0.1        0.55        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.50            -0.1        0.41        perf-profile.children.cycles-pp.enqueue_task_fair
      0.65 ±  8%      -0.1        0.56        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.49            -0.1        0.42        perf-profile.children.cycles-pp.dequeue_task_fair
      0.52            -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.32 ±  2%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.select_task_rq
      0.42 ±  2%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.44            -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.26            -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.27 ±  3%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.27            -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.llist_add_batch
      0.34            -0.1        0.28        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.32 ±  6%      -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.61            -0.1        0.55        perf-profile.children.cycles-pp.handle_pte_fault
      0.21 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.folio_unlock
      0.26 ±  8%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.31 ±  6%      -0.0        0.26 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.34 ±  8%      -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.22 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.xas_load
      0.19 ±  2%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.wake_affine
      0.20 ±  6%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.33 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.update_load_avg
      0.28            -0.0        0.24        perf-profile.children.cycles-pp.update_rq_clock
      0.18            -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      0.19 ±  8%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.13 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.12 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.xas_find
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.21 ±  9%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.35            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.18 ±  2%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.21            -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.08 ± 10%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.22 ±  2%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.10 ±  9%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.07 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__perf_sw_event
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.reweight_entity
      0.15 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.__switch_to
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sync_regs
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.perf_tp_event
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.put_page
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.14 ±  5%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.load_balance
      0.16 ±  5%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.12 ±  8%      +0.0        0.14        perf-profile.children.cycles-pp.find_busiest_group
      0.21 ±  6%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.up_read
      0.15 ±  5%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.55 ±  5%      +0.1        0.61 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp._find_first_zero_bit
      0.09            +0.3        0.38 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      4.61 ±  4%      +0.9        5.48 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     15.05            +1.0       16.04        perf-profile.children.cycles-pp.intel_idle
     30.89            +1.4       32.33        perf-profile.children.cycles-pp.asm_exc_page_fault
     29.75            +1.5       31.21        perf-profile.children.cycles-pp.handle_mm_fault
     29.60            +1.5       31.06        perf-profile.children.cycles-pp.__handle_mm_fault
     28.77            +1.5       30.23        perf-profile.children.cycles-pp.do_read_fault
     28.77            +1.5       30.24        perf-profile.children.cycles-pp.do_fault
     30.42            +1.5       31.94        perf-profile.children.cycles-pp.do_user_addr_fault
     30.43            +1.5       31.95        perf-profile.children.cycles-pp.exc_page_fault
     50.47            +2.1       52.57        perf-profile.children.cycles-pp.start_secondary
     50.93            +2.2       53.16        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     50.93            +2.2       53.16        perf-profile.children.cycles-pp.cpu_startup_entry
     50.91            +2.2       53.14        perf-profile.children.cycles-pp.do_idle
      4.41            +4.3        8.75 ±  2%  perf-profile.children.cycles-pp.__do_fault
      4.39            +4.4        8.74 ±  2%  perf-profile.children.cycles-pp.shmem_fault
      4.29            +4.4        8.69 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      3.86            +4.5        8.34 ±  2%  perf-profile.children.cycles-pp.__filemap_get_folio
      3.40            +4.6        8.01 ±  3%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.67            +5.1        5.79 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      1.78            +5.1        6.91 ±  4%  perf-profile.children.cycles-pp.schedule
      1.78            +5.1        6.91 ±  4%  perf-profile.children.cycles-pp.io_schedule
     21.60            +6.6       28.16        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     21.40            +7.5       28.92        perf-profile.children.cycles-pp._raw_spin_lock
      0.11 ±  4%     +10.0       10.10 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      2.40           +10.3       12.66 ±  4%  perf-profile.children.cycles-pp.__schedule
     10.91            -2.4        8.54        perf-profile.self.cycles-pp.do_rw_once
     42.19            -1.8       40.35        perf-profile.self.cycles-pp.mwait_idle_with_hints
      6.82            -1.2        5.58        perf-profile.self.cycles-pp.do_access
      4.18 ±  4%      -0.4        3.76 ±  2%  perf-profile.self.cycles-pp.poll_idle
      0.75 ±  2%      -0.2        0.58 ±  5%  perf-profile.self.cycles-pp.next_uptodate_page
      0.32 ±  4%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.57 ±  3%      -0.1        0.46        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.57            -0.1        0.49        perf-profile.self.cycles-pp.folio_wait_bit_common
      0.29            -0.1        0.22 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.44            -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.09 ±  5%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.shmem_fault
      0.26 ±  3%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.llist_add_batch
      0.21            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      0.34 ±  2%      -0.0        0.30 ±  4%  perf-profile.self.cycles-pp.filemap_map_pages
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.15 ±  5%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.20 ±  4%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__wake_up_common
      0.10 ±  9%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.07 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.13            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.10 ±  4%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.07            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.reweight_entity
      0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sync_regs
      0.12 ±  4%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.20 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
      0.16 ±  3%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.10            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.select_task_rq_fair
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.08 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.update_sg_lb_stats
      0.14 ±  5%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.wake_page_function
      0.21 ±  6%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.up_read
      0.21            +0.1        0.26        perf-profile.self.cycles-pp.__handle_mm_fault
      0.15 ±  5%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.42 ±  2%      +0.1        0.50 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp._find_first_zero_bit
      0.00            +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
      0.09            +0.3        0.38 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.65            +0.6        1.21 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
     21.50            +6.6       28.08        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--znh8I0flPXpWTU/f
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='will-it-scale'
	export testcase='will-it-scale'
	export category='benchmark'
	export job_origin='will-it-scale-fpu-test.yaml'
	export queue='bisect'
	export testbox='lkp-csl-2sp9'
	export commit='af7f588d8f7355bc4298dd1962d7826358fc95f0'
	export branch='linus/master'
	export name='/cephfs/tmp/d20230424-8447-1jrb2t2/will-it-scale-fpu-test.yaml'
	export kernel_cmdline=
	export tbox_group='lkp-csl-2sp9'
	export submit_id='645bc5376f560d86a15a1974'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/will-it-scale-performance-context_switch1-debian-11.1-x86_64-20220510.cgz-af7f588d8f7355bc4298dd1962d7826358fc95f0-20230511-34465-pn9jw1-1.yaml'
	export id='8b52890475f8222c91c7963430fa959e6783865e'
	export queuer_version='/zday/lkp'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2'
	export brand='Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz'
	export ucode='0x5003303'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI
INTEL_TH
INTEL_TH_ACPI'
	export disable_latency_stats=1
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export kconfig='x86_64-rhel-8.3'
	export enqueue_time='2023-05-11 00:24:23 +0800'
	export compiler='gcc-11'
	export _id='645bc54d6f560d86a15a1975'
	export _rt='/result/will-it-scale/performance-context_switch1/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/will-it-scale/performance-context_switch1/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/0'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/will-it-scale/performance-context_switch1/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/vmlinuz-6.2.0-rc1-00009-gaf7f588d8f73
branch=linus/master
job=/lkp/jobs/scheduled/lkp-csl-2sp9/will-it-scale-performance-context_switch1-debian-11.1-x86_64-20220510.cgz-af7f588d8f7355bc4298dd1962d7826358fc95f0-20230511-34465-pn9jw1-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=af7f588d8f7355bc4298dd1962d7826358fc95f0
initcall_debug
nmi_watchdog=0
max_uptime=2100
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/will-it-scale_20220823.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/will-it-scale-x86_64-a34a85c-1_20220601.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.3.0'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export repeat_to=3
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/vmlinuz-6.2.0-rc1-00009-gaf7f588d8f73'
	export dequeue_time='2023-05-11 00:31:59 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/will-it-scale-performance-context_switch1-debian-11.1-x86_64-20220510.cgz-af7f588d8f7355bc4298dd1962d7826358fc95f0-20230511-34465-pn9jw1-1.cgz'

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

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='context_switch1' $LKP_SRC/tests/wrapper will-it-scale
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='context_switch1' $LKP_SRC/stats/wrapper will-it-scale
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time will-it-scale.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--znh8I0flPXpWTU/f
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! /cephfs/tmp/d20230424-8447-1jrb2t2/will-it-scale-fpu-test.yaml
suite: will-it-scale
testcase: will-it-scale
category: benchmark
will-it-scale:
  test: context_switch1
job_origin: will-it-scale-fpu-test.yaml
queue: bisect
testbox: lkp-csl-2sp9
commit: af7f588d8f7355bc4298dd1962d7826358fc95f0
branch: linus/master
name: "/cephfs/tmp/d20230424-8447-1jrb2t2/will-it-scale-fpu-test.yaml"
kernel_cmdline:
tbox_group: lkp-csl-2sp9
submit_id: 645bc5376f560d86a15a1974
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/will-it-scale-performance-context_switch1-debian-11.1-x86_64-20220510.cgz-af7f588d8f7355bc4298dd1962d7826358fc95f0-20230511-34465-pn9jw1-1.yaml"
id: 8b52890475f8222c91c7963430fa959e6783865e
queuer_version: "/zday/lkp"

#! hosts/lkp-csl-2sp9
model: Cascade Lake
nr_node: 2
nr_cpu: 88
memory: 128G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2"
brand: Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz

#! include/category/benchmark
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0

#! include/category/ALL
cpufreq_governor: performance

#! include/testbox/lkp-csl-2sp9
ucode: '0x5003303'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
- INTEL_TH
- INTEL_TH_ACPI
disable_latency_stats: 1
rootfs: debian-11.1-x86_64-20220510.cgz
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-05-11 00:24:23.655011677 +08:00
compiler: gcc-11
_id: 645bc54d6f560d86a15a1975
_rt: "/result/will-it-scale/performance-context_switch1/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0"

#! schedule options
user: lkp
LKP_SERVER: internal-lkp-server
result_root: "/result/will-it-scale/performance-context_switch1/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/will-it-scale/performance-context_switch1/lkp-csl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/vmlinuz-6.2.0-rc1-00009-gaf7f588d8f73
- branch=linus/master
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/will-it-scale-performance-context_switch1-debian-11.1-x86_64-20220510.cgz-af7f588d8f7355bc4298dd1962d7826358fc95f0-20230511-34465-pn9jw1-1.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=af7f588d8f7355bc4298dd1962d7826358fc95f0
- initcall_debug
- nmi_watchdog=0
- max_uptime=2100
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/will-it-scale_20220823.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/will-it-scale-x86_64-a34a85c-1_20220601.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/perf_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01

#! /db/releases/20230424231518/lkp-src/include/site/lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.4.0-rc1-2023-05-09-intel-next-01765-gcc072b5075bd

#! queue options
queue_cmdline_keys:
- branch
- commit
- kbuild_queue_analysis

#! /db/releases/20230506144350/lkp-src/include/site/lkp-wsx01
repeat_to: 3

#! user overrides
kbuild_queue_analysis: 1
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/af7f588d8f7355bc4298dd1962d7826358fc95f0/vmlinuz-6.2.0-rc1-00009-gaf7f588d8f73"
dequeue_time: 2023-05-11 00:31:59.152337560 +08:00

#! /db/releases/20230510204317/lkp-src/include/site/lkp-wsx01
job_state: finished
loadavg: 84.95 41.93 16.63 1/752 14738
start_time: '1683736397'
end_time: '1683736713'
version: "/lkp/lkp/.src-20230508-150358:ad1384b06da5:c6711f306d8a"

--znh8I0flPXpWTU/f
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/lkp/benchmarks/python3/bin/python3" "./runtest.py" "context_switch1" "25" "both" "0" "0" "1" "22" "44" "66" "88"

--znh8I0flPXpWTU/f--
