Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D161A737C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFUHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFUHQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:16:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BE12E;
        Wed, 21 Jun 2023 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687331811; x=1718867811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t8i2c+yFreV3pVaaIoAwS6m/LkU+phjeuLaTKAWN3n8=;
  b=J2Y64XBJshYbKMXp09Lw0Ev2HvtrdWAp/4VNI3HInm9iEQz6CEJ5q52+
   PNRkNMH+iTs7Pqe5Tjuwa2igKv2HIz/JcDIYTpZUbUh7zsir+QJkLl3HY
   +xWAHdylt3BUKcF50Ph0jxV6MTI91VIyb3KGmD0kBnPgik/GhmJ1b/SGg
   HQdDhcumsaLsMlBMTLH7w4COZIfiiRkxEMQsJN1tjuA9WZiWhLfYS4v9C
   2XZ0LCEo3WoBVPXZ4Ns912w96q6XNSIlqcwnPyRSUnPBNGuPsHfm/dSfS
   0ztveoytnpnhI3hDhuNfAA3JbBL4UQIxkhfYHLDIPSJ2UiiRE3pROrcZ2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="423758354"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="423758354"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714344684"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="714344684"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2023 00:16:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 00:16:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 00:16:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 00:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBea+jdr6JaEtCBBq8BtUKx3jz5xDhY99Hzqfwdw5fIdYy+F66nVLpJHAvKd46w2mDvfxNUHPwBDHju2I+ABXnE8mMqSt7Hc1XSDQhdiQ2AAfyCiBrvPu7xnq9jVw6L7bQyE/YL+MCdUVAYtkTLRLbqZbft35ipee7+JlU6zAvlzFPFXSYNpt/86k15GEIOsUs69jxj59JEWfnpV4cMBKawgSoR/Mc/9YgpIDi6QdahIGmoj4dJ56iVnJsmVE4i1PDAf/PzKGLWzfhqU9rk0dphZ60+8WOUTuTIfrfVMz4F4lGHc9D72M9qyF+MpEdG3bfSkNm3b21vcRe5WndWE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9KnCZiAphkpKT4cjTrTNulqBP2MVjdYBd1/LAuhbVE=;
 b=K5G8ESEF7c4QqGyf1II5D3tOFz3E+S+r0Bcl5j8vg4tSkseGtyTgUYBOrrn3W7Q2dPMinXmaT7ZvKbQ2psqx7twcRy62k4fpLPu2KgBKW9da05vXMvDaaGvv3GvEg++iClBc+NNkPPA+BWqfvbVJFSlZNanFCMESpi6HYNmijPXYe1ZfnzBFdpOnMfYwWYRUYbUlQBS04R3AE9RmJkbazCgSqh02ku5cIZ4egBeEyIinWcJNeVDowU7ItDQMLCUYnKX7z3WK3UH3mkcB2W964B3ABGCIqUnhIIpO/8pHv41kq9PfspUwPakp6Xi2o4wmv7bMHOzRnNEEj4EbLkDHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 07:16:32 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 07:16:32 +0000
Date:   Wed, 21 Jun 2023 15:16:15 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-tip-commits@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        <x86@kernel.org>, Gautham Shenoy <gautham.shenoy@amd.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <ZJKjvx/NxooM5z1Y@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com>
 <20230614081757.GA1639749@hirez.programming.kicks-ass.net>
 <ZInVjPRLsyaKksfZ@chenyu5-mobl2.ccr.corp.intel.com>
 <20230614151348.GM1639749@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230614151348.GM1639749@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d0e1cd-7977-4082-53ae-08db72277025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIUvPeFcqEtz2XRPSQdK6ya7buSR3x97DkeQHPhY7TmJsmg+GroxphCqL7Jhe5QE8vsPEeHQ4530J7xi3Uu/pbp02ly8otIFUwjJtWozWFhUBKNdcVGgI7dmYf8f2hu1RXbT9nSJucV1E+5J/XLv4sxwy4yjpF5uGnGXgt42I++QBc3Apz1Nj9VSPl7D2DjnaJeRbe2mtP0C39fQQ1uk2/dFCP1GUW3eurQq5ykI7r6OR3ZbwTLqSfOMkiZ0uZ6zHBDmIie2vkpm8fnBbv+lsfG1sI9oz37KruM5aAz0Hk+4zp7ssMzPPhCbvP60+jtuc9uf6ZWWN6aAZJgzXqu0YkAQt7xSsEjLTrXjgZguD/8lB8WFYdaTYXaGnJHTC0FM7UR63JKWyikc3TXbhvKHpDTzXWJHzgHxkkIWCAF+aOK3VN0ypaACbhAX/2hNYTeoi6HHKP4VjdaoSpthO+cixT4HoFJ52JGNMBLTXLjM0Lz2Nbna7j3NyakgOn/95C7PFgcP/NEyLbNaMIfJ/zDDTNNPsOk/pFflVSh2CjDsbcfUZQOoEOE0C82vsnC1rMbZSu9Al53Irm5UaW8za6ZxzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(107886003)(82960400001)(86362001)(83380400001)(2906002)(5660300002)(4326008)(54906003)(66946007)(66556008)(8936002)(186003)(8676002)(66476007)(966005)(38100700002)(478600001)(6512007)(53546011)(6916009)(6506007)(41300700001)(26005)(6486002)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+VAuP+E1EVE/WPL63z2PEQa3f7v/hjfnS1PlkA57RjkDN4CnVVeaM2sSlao?=
 =?us-ascii?Q?cjsb/O4QSSIyUAa6ZPF6xfOPP2dJRJKCVcsb06GE04+bgoc6+yrZPRY6B6KX?=
 =?us-ascii?Q?NaS5KoVTvHD3TbF7tMOLYNfTaOVlnYbROG2YFQix22wJ+xjKGTeXLkQgj2qv?=
 =?us-ascii?Q?hlbNg7HbT1YUz1PyMvTKhQx/lbaArGNl2f2TMCDDA5/CdIeo0K2hXxhX1cLX?=
 =?us-ascii?Q?UpEY1qfYwF8oUp9wh/MAjPxTbxdFgkKSfcZPhBtJon+0d7sssjCQE4HdyH0G?=
 =?us-ascii?Q?wEnWoVAICHCQDxZAosXEdalPlFM1W8PCeidtFb6bbYEdrPZpKjfwyZVFpJpM?=
 =?us-ascii?Q?DPoDLbLFYcZN2XabT+xlmeBnBOWqhFRisctTVZ4T7h4ZCutCk6GsjAEiMdeA?=
 =?us-ascii?Q?DopJPvDK8IVLw3XHs7QZSPtF1GJWpQPErjH+uXvlHu2E57W4dz0EGmqus8T7?=
 =?us-ascii?Q?m9+iB1IrtDebygu8RbAhAvVdaK67uJ7gGvOOcGM39HxrBZAn0Usyv/iXN9h1?=
 =?us-ascii?Q?aay0++R12bczjKXEWlUVcAUdri8oCTOeSVJY5m2TBe+jyR37qwSDTC9pgaIh?=
 =?us-ascii?Q?JAjkn2z+Z6QVsnZkQwaP765CxDDYbLWP2mjX+1wUcIspGK3teCO7jKLl+DpO?=
 =?us-ascii?Q?hdlB0k30pKXU5RUjGV5G/ku94NC88BUKpUJVez5MQJnuA6jUXaveKjlcO0CY?=
 =?us-ascii?Q?Y/rfxDB+h0cRvwkWmCttbVIpNh7QM4BBeJrj0VH8P84FCbafk43G8jV7fw3N?=
 =?us-ascii?Q?N9LQxGiL1HDrH6tk0ZVuwxpKuplx5KvBRwgA1P8xAxwl2EWX82hNieQxpdTG?=
 =?us-ascii?Q?U0ta3GvS8tyr/EoLPgtvoG3ITNMKIZMQsUf+P6t/U+qyzsqfk2kALxDXocKW?=
 =?us-ascii?Q?t37FzWUBj+l2C0TyLwT/1dp2VuPhP7ud6Gmi1uM57a9hROnqGFA0L3r3Byaw?=
 =?us-ascii?Q?nE8/Rmt1wzGyN0NlhZZ+WGE6Rl95zOuXLDwo7+bOXDPiKqLgPNgmNjyKwuZF?=
 =?us-ascii?Q?x3bGrfXtbnRRy+14CoPTISUG6vDbV41JfGthTgKFkcKoSOfb1NcjBD1Zo1IA?=
 =?us-ascii?Q?Vg+aBuTguveRgPPIkCraWtBHljXqiIp2qMyrWyb/5sMgbZp58QDiUsVGyhJZ?=
 =?us-ascii?Q?C60ONIajOc+nfy+v7GwLdPU1fcVjUHk9jFrS0FwZK9uiZJaalZqCDYZmJC71?=
 =?us-ascii?Q?z5AqRkjvCTk9xe+xqjFlL2rhmZQ13rMj/JSm6p2Jm1xnK7JuZARkTyivMEC/?=
 =?us-ascii?Q?/umZKw8y0f2WOYZiDQ9Ak8U5tYyNBTcKOJc5dqkGjUa2zHb+08MJs1/BKUzY?=
 =?us-ascii?Q?vbNfcbtwdnSLyuafp57EFFvC+D1TZN287yN2J+yfsC6Gio+BGY4gJ8lgOT2X?=
 =?us-ascii?Q?KPpchDdyYBmOwppylbYdavzMcuZNgos9u9d0YM9XLkPnNKsr1+VzzicRU4Re?=
 =?us-ascii?Q?jTNuv3AW+Ytf1DrKn6DiGFvum1b5obMd71DdtBkoJaR9mgVPaAN6D904JpZH?=
 =?us-ascii?Q?Fh3umLdEjmVFvy9saBHuVB4NKfeYgmRBSxil3avwjry/p9oYVH9y9J+nN1N2?=
 =?us-ascii?Q?l3mDHrOl27cuxDcTSKFR7zkNgUjai3QxkI/wu+2i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d0e1cd-7977-4082-53ae-08db72277025
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 07:16:31.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YCHmLRTS4v1PKDMK4RNE/7b2FNXN1Na6HmlfjYhDMPJmhda/HdrlYyMfI2FKO5MTnMEgzQEW+dQvvDG4hni6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 at 17:13:48 +0200, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 10:58:20PM +0800, Chen Yu wrote:
> > On 2023-06-14 at 10:17:57 +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 13, 2023 at 04:00:39PM +0530, K Prateek Nayak wrote:
> > > 
> > > > >> - SIS_NODE_TOPOEXT - tip:sched/core + this patch
> > > > >>                      + new sched domain (Multi-Multi-Core or MMC)
> > > > >> 		     (https://lore.kernel.org/all/20230601153522.GB559993@hirez.programming.kicks-ass.net/)
> > > > >> 		     MMC domain groups 2 nearby CCX.
> > > > > 
> > > > > OK, so you managed to get the NPS4 topology in NPS1 mode?
> > > > 
> > > > Yup! But it is a hack. I'll leave the patch at the end.
> > > 
> > > Chen Yu, could we do the reverse? Instead of building a bigger LLC
> > > domain, can we split our LLC based on SNC (sub-numa-cluster) topologies?
> > >
> > Hi Peter,
> > Do you mean with SNC enabled, if the LLC domain gets smaller? 
> > According to the test, the answer seems to be yes.
> 
> No, I mean to build smaller LLC domains even with SNC disabled, as-if
> SNC were active.
> 
>
The topology on Sapphire Rapids is that there are 4 memory controllers within
1 package per lstopo result, and the LLCs could have slightly difference distance
to the 4 mc with SNC disabled. Unfortunately there is no interface for the OS
to query this partition. I used a hack to split the LLC into 4 smaller ones
with SNC disabled, according to the topology in SNC4. Then I had a test on this
platform with/withouth this LLC split, both with SIS_NODE enabled and with
this issue fixed[1]. Something like this when iterating the groups in select_idle_node():

if (cpumask_test_cpu(target, sched_group_span(sg)))
	continue;

The SIS_NODE should have no impact on non-LLC-split version on
Sapphire Rapids, so the baseline is vanilla+SIS_NODE.

In summary, huge improvement from netperf was observed, but also regression from
hackbench/schbench was observed when the system is under load. I'll collect some
schedstats to check the scan depth in the problematic cases.


With SNC disabled and with the hack llc-split patch applied, there is a new
Die domain generated, the LLC is divided into 4 sub-llc groups:

 grep  . domain*/{name,flags}
domain0/name:SMT
domain1/name:MC
domain2/name:DIE
domain3/name:NUMA
domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING
domain3/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA

cat /proc/schedstat | grep cpu0 -A 4
cpu0 0 0 0 0 0 0 15968391465 3630455022 18084
domain0 00000000,00000000,00000000,00010000,00000000,00000000,00000001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 00000000,00000000,00000000,3fff0000,00000000,00000000,00003fff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain2 00000000,000000ff,ffffffff,ffff0000,00000000,00ffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain3 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0


hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  3.81)  -100.18 (  0.19)
process-pipe            2-groups         1.00 ( 10.74)  -59.21 (  0.91)
process-pipe            4-groups         1.00 (  5.37)  -56.37 (  0.56)
process-pipe            8-groups         1.00 (  0.36)  +17.11 (  0.82)
process-sockets         1-groups         1.00 (  0.09)  -26.53 (  1.45)
process-sockets         2-groups         1.00 (  0.82)  -26.45 (  0.40)
process-sockets         4-groups         1.00 (  0.21)   -4.09 (  0.19)
process-sockets         8-groups         1.00 (  0.13)   -5.31 (  0.36)
threads-pipe            1-groups         1.00 (  2.14)  -62.87 (  1.11)
threads-pipe            2-groups         1.00 (  3.18)  -55.82 (  1.14)
threads-pipe            4-groups         1.00 (  4.68)  -54.92 (  0.34)
threads-pipe            8-groups         1.00 (  5.08)  +15.81 (  3.08)
threads-sockets         1-groups         1.00 (  2.60)  -18.28 (  6.03)
threads-sockets         2-groups         1.00 (  0.83)  -30.17 (  0.60)
threads-sockets         4-groups         1.00 (  0.16)   -4.15 (  0.27)
threads-sockets         8-groups         1.00 (  0.36)   -5.92 (  0.94)

The 1 group, 2 groups, 4 groups suffered.

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  56-threads       1.00 (  2.75)  +10.49 ( 10.88)
TCP_RR                  112-threads      1.00 (  2.39)   -1.88 (  2.82)
TCP_RR                  168-threads      1.00 (  2.05)   +8.31 (  9.73)
TCP_RR                  224-threads      1.00 (  2.32)  +788.25 (  1.94)
TCP_RR                  280-threads      1.00 ( 59.77)  +83.07 ( 12.38)
TCP_RR                  336-threads      1.00 ( 21.61)   -0.22 ( 28.72)
TCP_RR                  392-threads      1.00 ( 31.26)   -0.13 ( 36.11)
TCP_RR                  448-threads      1.00 ( 39.93)   -0.14 ( 45.71)
UDP_RR                  56-threads       1.00 (  5.57)   +2.38 (  7.41)
UDP_RR                  112-threads      1.00 ( 24.53)   +1.51 (  8.43)
UDP_RR                  168-threads      1.00 ( 11.83)   +7.34 ( 20.20)
UDP_RR                  224-threads      1.00 ( 10.55)  +163.81 ( 20.64)
UDP_RR                  280-threads      1.00 ( 11.32)  +176.04 ( 21.83)
UDP_RR                  336-threads      1.00 ( 31.79)  +12.87 ( 37.23)
UDP_RR                  392-threads      1.00 ( 34.06)  +15.64 ( 44.62)
UDP_RR                  448-threads      1.00 ( 59.09)  +14.00 ( 52.93)

The 224-thread/280-threads show good improvement.

tbench
======
case                    load            baseline(std%)  compare%( std%)
loopback                56-threads       1.00 (  0.83)   +1.38 (  1.56)
loopback                112-threads      1.00 (  0.19)   -4.25 (  0.90)
loopback                168-threads      1.00 ( 56.43)  -31.12 (  0.37)
loopback                224-threads      1.00 (  0.28)   -2.50 (  0.44)
loopback                280-threads      1.00 (  0.10)   -1.64 (  0.81)
loopback                336-threads      1.00 (  0.19)   -2.10 (  0.10)
loopback                392-threads      1.00 (  0.13)   -2.15 (  0.39)
loopback                448-threads      1.00 (  0.45)   -2.14 (  0.43)

Might have no impact to tbench(the 168 threads result is unstable and could
be ignored)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  0.42)   -0.59 (  0.72)
normal                  2-mthreads       1.00 (  2.72)   +1.76 (  0.42)
normal                  4-mthreads       1.00 (  0.75)   -1.22 (  1.86)
normal                  8-mthreads       1.00 (  6.44)  -14.56 (  5.64)

8 message case is not good for schbench.


diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..ffc44639447e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -511,6 +511,30 @@ static const struct x86_cpu_id intel_cod_cpu[] = {
 	{}
 };
 
+static unsigned int sub_llc_nr;
+
+static int __init parse_sub_llc(char *str)
+{
+	get_option(&str, &sub_llc_nr);
+
+	return 0;
+}
+early_param("sub_llc_nr", parse_sub_llc);
+
+static bool
+topology_same_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	int idx1, idx2;
+
+	if (!sub_llc_nr)
+		return true;
+
+	idx1 = c->apicid / sub_llc_nr;
+	idx2 = o->apicid / sub_llc_nr;
+
+	return idx1 == idx2;
+}
+
 static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(intel_cod_cpu);
@@ -530,7 +554,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	 * means 'c' does not share the LLC of 'o'. This will be
 	 * reflected to userspace.
 	 */
-	if (match_pkg(c, o) && !topology_same_node(c, o) && intel_snc)
+	if (match_pkg(c, o) && (!topology_same_node(c, o) || !topology_same_llc(c, o)) && intel_snc)
 		return false;
 
 	return topology_sane(c, o, "llc");
-- 
2.25.1



[1] https://lore.kernel.org/lkml/5903fc0a-787e-9471-0256-77ff66f0bdef@bytedance.com/


