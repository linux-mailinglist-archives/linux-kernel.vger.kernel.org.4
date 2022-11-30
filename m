Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A363DBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiK3RNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiK3RND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:13:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F48B18A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669828170; x=1701364170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eCwkCgwB5veE6HfNhJHqWvHaXd04DKaw1pnqVyVIopw=;
  b=ZXTMna2JwDiscaU/t6qxoPRdQOJ3ZvsOrsTZ/O2ih/EYlmRYi7UAweLY
   l6vjDaeffizH4577eE7hEqjJUnlgYX8p2+P3UY3p/I1swDxg8Jc4kGftZ
   oo3mqZPLWp8T5Wur5kCzY/Nv1vZS/Ay2Keuhdwi0qdPFNCaipSCK8B9ds
   CcBtClfx1imyu0n/efZS8U9AZybiKYLyMwfZ3hMTWTP2rR9E+bAZcJt0f
   lHBcXbJru7Ij7Q5bmZfXqqvl1N3qe6ufMGMxFy/JC1aPOxWnJb1xiaYUS
   1w8WxgPZvBM9bSZLOm0fxXpuHbjukuZ7GzIXePOcM2fGPD6Xs8TrgR7h/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="315480140"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="xz'?scan'208";a="315480140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 09:08:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="889363363"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="xz'?scan'208";a="889363363"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2022 09:08:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 09:08:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 09:08:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 09:08:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2AS7yKsERZszfdd4/YnxJIFXNoRnPB06/0Gb/v54dbfDjUDBzDbJpaMguwnZB0Roc/z0oQOkyBnpi9VoJFKeBOJSml3jnqLtGtPuEPZy1iq928+OEZQNgSOAoZ2+8lUkHGQLRwkyJoabNYuV8+3h6vAJhnPY01ectaf+a5m9E2zZW2+1C4Ewe6lGMlFb3entApnJ16NMvHc0tfiP932EnuXttkuGklijxwEcXvAj4l9JQ1SQhJRwgkvrLB7VVa/bDfSWRV02D69xpMWxRNdpau9BTYb8JXH1+H8q/TlfOxepWd9psPWMjDJF20v3QhfWkUgUjvXfXxvb4D5w/qGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yohVsYv+7CInLemCBHDK4/LzZDX4oSOOAxqEe69k9GA=;
 b=PfaqXC3B8vG27v0mPa76ZiliNSZvEaQFQHvV2HHBIUqYBjfwdQPqi5KsFkRsqXdAJYxUbJThj7hNR+PIvjTdudyQ5zoTxi4lWm6jsR92wJnoKlHjc0jkepnLqpUeYIN+Ud2X0cnbP/XZK0WRGTMeStoG+QUkZ7HyeLe7KCds1ejSo+F3fZ+Ci5lBxyrWm2jNJI1QUtaeBUESQrMDqh4DvOQ1X8GUVEINyuJxqGCNTwpR4ao7q2VR31/eoGD5TKiHUnH7oNnR/G2i0iWWbGiWcQj/imz7VJAF1To9S1RflFe3wDVDGDqOmoU5ZBhocxOZEace6IeRwCR1uzPbjJ0mSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 17:08:07 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 17:08:07 +0000
Date:   Thu, 1 Dec 2022 01:06:00 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [linux-next:master] [printk] 8bdbdd7f43: BUG:scheduling_while_atomic
Message-ID: <202211302358.ef0db537-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="X2t9x9T/yd9ROp/h"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:820:d::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB5437:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd79c9-1936-498b-2b9d-08dad2f5732b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rfl6PoUeZEXh6bk8wDoNawiWBe+k1coJrZ9PeVf78ZFszVZ9fhSJtZ2KG3c2K12thjxf9ZHqBX4IPseKhk7kZk/SJRQJEQf+SD/QPPv260BdAUgn36731EqOZW8DmK5gtj2do8LjfBEayrhuDzJJLj4o/LLn1z0KV6MSCMsQFs9hin/SoShhK3DFjjXyVa3FSjeqgdDwjgYLhMwxvUYLORagWenHnmHNrPHTBam4R9r1zp3Jy5EylcIr9x7qchVR2TKnJi3HgRg1dx3HU0BPsOvizuerTty060Hv3fXxdWPt0mQmwnGVntOi1m5EbWmKhn6zeuTriDC2kGHSvrzw8f4vBxxk/6ff8Pm4/qAcvH35FOLNydx05MnJh6WFdBUKBJuGYc04WfCrl+SQu8zK3HQVDBnKJwlP1BFWKUbtmmr/iRILoiUrT1YQV7FBoTq6s/zi3AiyR/1E1XNzQpUaez/Q8PySPBvYkue6p0W8endz50NfER8iSrJJbV4yeB4naRACfCo+sxayzT/DtvbrJC5fO6OAzZzhooBMRZGVK3JwCke0wj/7RcIgauiBT2RuD9J2UEJEF0qk1IuExcq6uZqzcfUg1wNFMXNY9hW3gZqMM3i/arY1tr9XgflMUXIruKhLVjHGNINItBet53UAVrgQh5WUS8Ja5FKK06kEPKNr+oOB4pGaMM/0HjesR1nCEJjkvDsFDDIA3QQfprIxmak8H2uqLLYBiQ3wIUyUFHjMXn0ktEQXqUb1T79edMhG3Kjcq5b3CMIJEQEKjqwgGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(36756003)(41300700001)(66946007)(2906002)(83380400001)(86362001)(966005)(54906003)(6486002)(8676002)(6916009)(66476007)(2616005)(316002)(82960400001)(478600001)(45080400002)(38100700002)(4326008)(8936002)(5660300002)(235185007)(44144004)(6512007)(1076003)(6666004)(26005)(186003)(6506007)(66556008)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DxidXeb8MZyrFYBMW7JgsGs+MHiUNuKlFP/qxQnb3vPdV5zSO0IDMSZuqrVP?=
 =?us-ascii?Q?w6Ze0zNwJkZC9Y/Ec/epg1gmzv9IrsNWF2v5EkU5pWS8c1YTauG9m2ZDDp3E?=
 =?us-ascii?Q?G74V25cV2p2RtQ9+6DGb+pxVkFWEV3MXnRvzRYS5Wzvi7BUAnf33ny7Ekt00?=
 =?us-ascii?Q?3bZWPAdG32uvga/59kYK8xVDJzqB5Mv4h7Ti29EryXLz9L2oeCMDEiLMN4MK?=
 =?us-ascii?Q?Yd2rdFuspsEGYO3gRUyxUhiL5ckwPx/wPRFbBDkysjjGslzQY4ZVhVAXK5Sr?=
 =?us-ascii?Q?hXVOcdYLhcsG58l9du6HM6907C7gJjBuLq/MEQwUaEI2dkYYCJukuO5vCrXi?=
 =?us-ascii?Q?hlnx3m3G2Fq5ksJhU70bnrqI3FRoQFLYSB8exsnTLwzxI8BwzS5jIcSvuiOI?=
 =?us-ascii?Q?35gGXbUJGM0VhrPXiBdf0Mn3h1H3uxblZnC+4Ii4k3r7L+zKkukmG+HQ5xSf?=
 =?us-ascii?Q?72KRgEhRWZG4aNZFE9Q7dEO+s06mQiSM83CEqaZqYs/usQ4sZBZaLlsmmMTC?=
 =?us-ascii?Q?Yb/UiKDe1xASeKmWhSjOQxz0CWUkgyzYsD1MoQ0inJRHsbeQlxWJxe7yUleh?=
 =?us-ascii?Q?5KwnVs+UokHZFuclaeiuPcn47RcT64cp4D08ZD8hOdCzXJZEjNwheshfLzq7?=
 =?us-ascii?Q?3sI6Rg3q1U2mSvCpXzis26s4VOUE/WsULKJJO11+mEHp/l8UkvJRAUxE5eO8?=
 =?us-ascii?Q?L90xQw3cI2z+sLJFrxjbteApNEczrZ/Q0/YPh1aPLN28TypsI/wjS2FyElMG?=
 =?us-ascii?Q?vMutmlW/x0CXgYI/8YPfz8kdiCVkJ7DnJx4CUCXwzep2/T1/gPOA9DUvn1Aa?=
 =?us-ascii?Q?zsOS/r5ZGb1xhz+peKcNU6ljvrrOokbp3l6jA+XNog6HoUkYxOVSwtqd6abP?=
 =?us-ascii?Q?Xsp6+YNz0xDnk+EW24Tj/qEdqw3iQncKUKhtu3k2KsdE53YXtsgvpJ1a65JE?=
 =?us-ascii?Q?ws9JYNdF37p0QN6RC0ZZXbc8OLLA/74rVD8ZoBHjBmZEava15tf7f68nYXQ9?=
 =?us-ascii?Q?9jqTGPbg6oo37oGXw5lVf0GOuw4Nlx2dd7VMP4hZJoplr3HD32Xzn7nAyWBF?=
 =?us-ascii?Q?jclj/1FU7+WbirJPAhzt68X9w3hw1ZQ4q8KEWfsHuZ177dDBrorh8o2LLCRD?=
 =?us-ascii?Q?xI6+gl519b2l6MQ87jfZ8Coe6Fc8st84obOBPmUh6MaoPR9NFtnWhkCMnSeq?=
 =?us-ascii?Q?I6LNHHLSjTZ71Y4Y5neSrpMHFSW/oiK5iiXEY6CfKaJta8l8VWGaeVP8Q2eR?=
 =?us-ascii?Q?ILCO4Di1+RnXLCkXEAzloeTp2jh4SZihv9Mdi29qFwX7OcZw2SjaFG/8YNuj?=
 =?us-ascii?Q?gxKE7quAa0uzGs73NtcHMkoAAq8oqN+YGpbX2a2eGumUN95u2pWueKS0hfv1?=
 =?us-ascii?Q?44IYTbnEr5ZRNhaIwE8rEpM9z/JVwY67FSKmE2k897H2u14A3eG+a6SbFE31?=
 =?us-ascii?Q?tZeV5keqjITng72mCGo9UGKhKQGq8/t4mF0JJhp0NzrerZEN9KH5PRqXFzbz?=
 =?us-ascii?Q?FIqFSFUBmwIdZr3fSy8imj0GeJybTLgIVoBcoG2xud01kIwgygqE8o1zTpiO?=
 =?us-ascii?Q?Q920lMxa02rdLUTgkgPzKS/Il7WzRBQQDxXW6/ts?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd79c9-1936-498b-2b9d-08dad2f5732b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 17:08:07.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vO6JFu5E3E+qNY+vwY7BxCxTuaCXSiijE9Ywxbs53Jtmv5q5N2GZdCb89cfJ9btM9lfCooznjmmA0rDHw2vAng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X2t9x9T/yd9ROp/h
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed BUG:scheduling_while_atomic due to commit (built with clang-14):

commit: 8bdbdd7f43cd74c7faca6add8a62d541503ae21d ("printk: Prepare for SRCU console list protection")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[    8.561823][    T0] BUG: scheduling while atomic: swapper/0/0x00000002
[    8.569154][    T0] no locks held by swapper/0.
[    8.571934][    T0] Modules linked in:
[    8.573001][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
[    8.576740][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[    8.579942][    T0] Call Trace:
[    8.581143][    T0]  <TASK>
[ 8.582054][ T0] dump_stack_lvl (??:?) 
[ 8.583312][ T0] ? netdev_notice (??:?) 
[ 8.584753][ T0] ? lockdep_print_held_locks (lockdep.c:?) 
[ 8.586563][ T0] __schedule_bug (core.c:?) 
[ 8.588171][ T0] ? trace_sched_switch (core.c:?) 
[ 8.589753][ T0] ? save_trace (lockdep.c:?) 
[ 8.591135][ T0] schedule_debug (core.c:?) 
[ 8.592582][ T0] __schedule (core.c:?) 
[ 8.593902][ T0] ? __sched_text_start (core.c:?) 
[ 8.595356][ T0] ? add_chain_block (lockdep.c:?) 
[ 8.596847][ T0] ? find_held_lock (lockdep.c:?) 
[ 8.598368][ T0] schedule (??:?) 
[ 8.599564][ T0] schedule_timeout (??:?) 
[ 8.600937][ T0] ? console_conditional_schedule (??:?) 
[ 8.602773][ T0] do_wait_for_common (build_utility.c:?) 
[ 8.604522][ T0] ? console_conditional_schedule (??:?) 
[ 8.606462][ T0] ? bit_wait_io_timeout (build_utility.c:?) 
[ 8.608196][ T0] ? _raw_spin_lock_irq (??:?) 
[ 8.609935][ T0] ? lockdep_hardirqs_on (??:?) 
[ 8.611646][ T0] wait_for_completion (??:?) 
[ 8.613253][ T0] synchronize_srcu (??:?) 
[ 8.614825][ T0] ? srcu_gp_start_if_needed (??:?) 
[ 8.616664][ T0] ? rcu_read_lock_any_held (??:?) 
[ 8.618281][ T0] ? console_trylock_spinning (??:?) 
[ 8.620181][ T0] unregister_console (??:?) 
[ 8.621875][ T0] register_console (??:?) 
[ 8.623401][ T0] ? serial8250_isa_init_ports (8250_core.c:?) 
[ 8.625281][ T0] ? parse_options (super.c:?) 
[ 8.626887][ T0] univ8250_console_init (8250_core.c:?) 
[ 8.628583][ T0] console_init (??:?) 
[ 8.630025][ T0] start_kernel (??:?) 
[ 8.631558][ T0] secondary_startup_64_no_verify (??:?) 
[    8.633502][    T0]  </TASK>
[    8.634624][    T0] ------------[ cut here ]------------
[    8.636289][    T0] releasing a pinned lock
[ 8.638693][ T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5352 lock_release (??:?) 
[    8.641591][    T0] Modules linked in:
[    8.642864][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
[    8.646469][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 8.649578][ T0] RIP: 0010:lock_release (??:?) 
[ 8.651243][ T0] Code: 00 00 e9 0f fe ff ff 48 83 05 06 f6 ff 06 01 e8 91 4e 2d 03 e9 67 fe ff ff 48 c7 c7 20 8c cf 84 e8 90 3f ec ff 48 8b 54 24 08 <0f> 0b 48 83 05 a9 f6 ff 06 01 e9 66 fc ff ff e8 67 c9 99 01 85 c0
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	e9 0f fe ff ff       	jmpq   0xfffffffffffffe16
   7:	48 83 05 06 f6 ff 06 	addq   $0x1,0x6fff606(%rip)        # 0x6fff615
   e:	01 
   f:	e8 91 4e 2d 03       	callq  0x32d4ea5
  14:	e9 67 fe ff ff       	jmpq   0xfffffffffffffe80
  19:	48 c7 c7 20 8c cf 84 	mov    $0xffffffff84cf8c20,%rdi
  20:	e8 90 3f ec ff       	callq  0xffffffffffec3fb5
  25:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 83 05 a9 f6 ff 06 	addq   $0x1,0x6fff6a9(%rip)        # 0x6fff6dd
  33:	01 
  34:	e9 66 fc ff ff       	jmpq   0xfffffffffffffc9f
  39:	e8 67 c9 99 01       	callq  0x199c9a5
  3e:	85 c0                	test   %eax,%eax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 83 05 a9 f6 ff 06 	addq   $0x1,0x6fff6a9(%rip)        # 0x6fff6b3
   9:	01 
   a:	e9 66 fc ff ff       	jmpq   0xfffffffffffffc75
   f:	e8 67 c9 99 01       	callq  0x199c97b
  14:	85 c0                	test   %eax,%eax
[    8.656638][    T0] RSP: 0000:ffffffff862077c0 EFLAGS: 00010086
[    8.658249][    T0] RAX: 0000000000000017 RBX: ffffffff86244244 RCX: ffffffff8631a420
[    8.660383][    T0] RDX: ffffffff86244218 RSI: 0000000000000008 RDI: 0000000000000001
[    8.662798][    T0] RBP: ffffffff862078e0 R08: dffffc0000000000 R09: 00000000035545d9
[    8.665205][    T0] R10: dffff7fff0c40e7a R11: 0000000000000001 R12: ffffffff862fcf58
[    8.667420][    T0] R13: 1ffffffff0c40f06 R14: ffffffff86244220 R15: dffffc0000000000
[    8.669824][    T0] FS:  0000000000000000(0000) GS:ffffffff862ab000(0000) knlGS:0000000000000000
[    8.672552][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.674557][    T0] CR2: ffff88843ffff000 CR3: 0000000006235000 CR4: 00000000000406b0
[    8.677082][    T0] Call Trace:
[    8.678220][    T0]  <TASK>
[ 8.679230][ T0] ? __lock_acquire (??:?) 
[ 8.680709][ T0] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 8.682309][ T0] ? sched_clock_cpu (??:?) 
[ 8.683854][ T0] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 8.685268][ T0] _raw_spin_unlock (??:?) 
[ 8.686730][ T0] dequeue_task_idle (build_policy.c:?) 
[ 8.688259][ T0] ? set_next_task_idle (build_policy.c:?) 
[ 8.689822][ T0] ? update_rq_clock (??:?) 
[ 8.691387][ T0] __schedule (core.c:?) 
[ 8.692782][ T0] ? __sched_text_start (core.c:?) 
[ 8.694287][ T0] ? add_chain_block (lockdep.c:?) 
[ 8.695869][ T0] ? find_held_lock (lockdep.c:?) 
[ 8.697314][ T0] schedule (??:?) 
[ 8.698529][ T0] schedule_timeout (??:?) 
[ 8.701929][ T0] ? console_conditional_schedule (??:?) 
[ 8.703826][ T0] do_wait_for_common (build_utility.c:?) 
[ 8.705395][ T0] ? console_conditional_schedule (??:?) 
[ 8.707189][ T0] ? bit_wait_io_timeout (build_utility.c:?) 
[ 8.708779][ T0] ? _raw_spin_lock_irq (??:?) 
[ 8.710371][ T0] ? lockdep_hardirqs_on (??:?) 
[ 8.711982][ T0] wait_for_completion (??:?) 
[ 8.713487][ T0] synchronize_srcu (??:?) 
[ 8.715020][ T0] ? srcu_gp_start_if_needed (??:?) 
[ 8.716772][ T0] ? rcu_read_lock_any_held (??:?) 
[ 8.718477][ T0] ? console_trylock_spinning (??:?) 
[ 8.720179][ T0] unregister_console (??:?) 
[ 8.721644][ T0] register_console (??:?) 
[ 8.728846][ T0] ? serial8250_isa_init_ports (8250_core.c:?) 
[ 8.730692][ T0] ? parse_options (super.c:?) 
[ 8.732180][ T0] univ8250_console_init (8250_core.c:?) 
[ 8.733762][ T0] console_init (??:?) 
[ 8.735096][ T0] start_kernel (??:?) 
[ 8.736425][ T0] secondary_startup_64_no_verify (??:?) 
[    8.738088][    T0]  </TASK>
[    8.739057][    T0] irq event stamp: 494
[ 8.740376][ T0] hardirqs last enabled at (493): dump_stack_lvl (??:?) 
[ 8.743081][ T0] hardirqs last disabled at (494): __schedule (core.c:?) 
[ 8.745797][ T0] softirqs last enabled at (0): 0x0 
[ 8.747882][ T0] softirqs last disabled at (0): 0x0 
[    8.749889][    T0] ---[ end trace 0000000000000000 ]---
[    8.751520][    T0] bad: scheduling from the idle thread!
[    8.753351][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
[    8.757566][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[    8.760783][    T0] Call Trace:
[    8.761970][    T0]  <TASK>
[ 8.763067][ T0] dump_stack_lvl (??:?) 
[ 8.764611][ T0] ? netdev_notice (??:?) 
[ 8.766213][ T0] ? lockdep_hardirqs_on_prepare (??:?) 
[ 8.768214][ T0] ? print_irqtrace_events (??:?) 
[ 8.769911][ T0] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 8.771550][ T0] dequeue_task_idle (build_policy.c:?) 
[ 8.773087][ T0] ? set_next_task_idle (build_policy.c:?) 
[ 8.774647][ T0] ? update_rq_clock (??:?) 
[ 8.776280][ T0] __schedule (core.c:?) 
[ 8.777729][ T0] ? __sched_text_start (core.c:?) 
[ 8.779238][ T0] ? add_chain_block (lockdep.c:?) 
[ 8.780922][ T0] ? find_held_lock (lockdep.c:?) 
[ 8.782560][ T0] schedule (??:?) 
[ 8.783988][ T0] schedule_timeout (??:?) 
[ 8.785515][ T0] ? console_conditional_schedule (??:?) 
[ 8.787500][ T0] do_wait_for_common (build_utility.c:?) 
[ 8.789162][ T0] ? console_conditional_schedule (??:?) 
[ 8.790997][ T0] ? bit_wait_io_timeout (build_utility.c:?) 
[ 8.792567][ T0] ? _raw_spin_lock_irq (??:?) 
[ 8.794292][ T0] ? lockdep_hardirqs_on (??:?) 
[ 8.796008][ T0] wait_for_completion (??:?) 
[ 8.797520][ T0] synchronize_srcu (??:?) 
[ 8.799001][ T0] ? srcu_gp_start_if_needed (??:?) 
[ 8.800696][ T0] ? rcu_read_lock_any_held (??:?) 
[ 8.802508][ T0] ? console_trylock_spinning (??:?) 
[ 8.804316][ T0] unregister_console (??:?) 
[ 8.805810][ T0] register_console (??:?) 
[ 8.807364][ T0] ? serial8250_isa_init_ports (8250_core.c:?) 
[ 8.811167][ T0] ? parse_options (super.c:?) 
[ 8.812693][ T0] univ8250_console_init (8250_core.c:?) 
[ 8.814269][ T0] console_init (??:?) 
[ 8.815765][ T0] start_kernel (??:?) 
[ 8.817296][ T0] secondary_startup_64_no_verify (??:?) 
[    8.819246][    T0]  </TASK>


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211302358.ef0db537-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc1-00015-g8bdbdd7f43cd .config
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-14 CC=clang-14 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
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

--X2t9x9T/yd9ROp/h
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc1-00015-g8bdbdd7f43cd"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 14.0.6 (git://gitmirror/llvm_project f28c006a5895fc0e329fe15fead81e37457cb1d1)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=140006
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=140006
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=140006
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
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
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
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
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
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
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

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

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
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
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
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
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

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
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
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
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
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
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_RETPOLINE=y
CONFIG_CPU_IBPB_ENTRY=y
# CONFIG_CPU_IBRS_ENTRY is not set
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
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=m
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
CONFIG_DPTF_PCH_FIVR=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_ACPI_PFRUT=y
# CONFIG_ACPI_PCC is not set
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
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
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_ISA_BUS_API=y
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
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
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
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
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
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
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
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4hc"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
# CONFIG_PTE_MARKER_UFFD_WP is not set
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_LRU_GEN_STATS=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
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
CONFIG_NET_PTP_CLASSIFY=y
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
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

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
CONFIG_EISA_VLB_PRIMING=y
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
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

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
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
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
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
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
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

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
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_USB=m
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=m
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_OTP is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SBC_GXX=m
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_MCHP48L640=y
# CONFIG_MTD_SST25L is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
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
# CONFIG_PARIDE is not set
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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HI6421V600_IRQ=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
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
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=m
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_DWC=m
CONFIG_AHCI_CEVA=m
CONFIG_AHCI_QORIQ=m
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
# CONFIG_ATA_PIIX is not set
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
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_OF_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
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
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
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
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
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
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
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
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
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
# CONFIG_QCA7000_SPI is not set
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
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
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
# CONFIG_PCMCIA_RAYCS is not set
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
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=m
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=m
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=m
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_QWIIC=m
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=m
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
# CONFIG_TABLET_USB_AIPTEK is not set
CONFIG_TABLET_USB_HANWANG=y
# CONFIG_TABLET_USB_KBTAB is not set
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_ILITEK=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_STMPE=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=m
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
CONFIG_INPUT_ATMEL_CAPTOUCH=m
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=m
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=m
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA7280_HAPTICS=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IBM_PANEL=m
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_IQS7222=m
CONFIG_INPUT_CMA3000=m
# CONFIG_INPUT_CMA3000_I2C is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RT5120_PWRKEY=m
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
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
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=m
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=m
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
CONFIG_GOLDFISH_TTY=m
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=m
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=m
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
# CONFIG_TCG_TIS_SPI_CR50 is not set
CONFIG_TCG_TIS_I2C=m
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
CONFIG_XILLYUSB=m
# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
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
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_CP2615=m
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_FSI=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
CONFIG_MIPI_I3C_HCI=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CADENCE_QUADSPI=m
CONFIG_SPI_CADENCE_XSPI=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_FSI=m
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
CONFIG_SPI_INTEL=y
# CONFIG_SPI_INTEL_PCI is not set
CONFIG_SPI_INTEL_PLATFORM=y
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_FSL_LIB=m
CONFIG_SPI_FSL_SPI=m
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MICROCHIP_CORE_QSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_SIFIVE=m
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
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
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
CONFIG_SPMI_HISI3670=m
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_MICROCHIP_SGPIO=m
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_RK805=m
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=m

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=m
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=m
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=m
CONFIG_PINCTRL_SUNRISEPOINT=y
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_GW_PLD=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_WM8994=m
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
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
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
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_IP5XXX_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=m
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=m
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=m
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_RK817=m
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_CORSAIR_CPRO=m
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DRIVETEMP=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=m
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX31760=m
CONFIG_SENSORS_MAX6620=m
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT6775_I2C=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_PECI_CPUTEMP is not set
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_BPA_RS600=m
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=m
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=m
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LM25066_REGULATOR=y
CONFIG_SENSORS_LT7182S=m
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=m
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=m
# CONFIG_SENSORS_PIM4328 is not set
CONFIG_SENSORS_PLI1209BC=m
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=m
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_TPS546D24=m
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=m
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_SY7636A=m
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA238=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_XGENE=m
# CONFIG_SENSORS_INTEL_M10_BMC_HWMON is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

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
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_MLX_WDT=m
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_MAX77620_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=m
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=m
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_NI903X_WDT is not set
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
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=m
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=m
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6370=m
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_OCELOT=m
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
CONFIG_MFD_SY7636A=m
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RT5120=m
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_TI_LMU is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS65912=m
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_QCOM_PM8008=m
CONFIG_MFD_INTEL_M10_BMC=y
CONFIG_MFD_RSMU_I2C=m
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9121=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=m
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6370=m
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PF8X00=m
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_RT5120 is not set
CONFIG_REGULATOR_RT5190A=m
CONFIG_REGULATOR_RT5759=m
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY7636A=m
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS6286X=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM8994=m
CONFIG_REGULATOR_QCOM_LABIBB=m
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
CONFIG_USB_RAINSHADOW_CEC=m
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

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
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_MT6370=m
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_AUREAL=m
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_VRC2=m
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PLAYSTATION=m
# CONFIG_PLAYSTATION_FF is not set
CONFIG_HID_PXRC=m
CONFIG_HID_RAZER=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_TOPRE=m
CONFIG_HID_THINGM=m
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
CONFIG_I2C_HID_OF=m
CONFIG_I2C_HID_OF_ELAN=m
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
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
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=m
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=m
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_UDC=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_IMX=m
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_CHIPIDEA_TEGRA=m
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
# CONFIG_USB_SERIAL_CH341 is not set
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
CONFIG_USB_SERIAL_CP210X=m
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=y
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=y
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=m
# CONFIG_USB_SERIAL_SPCP8X5 is not set
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
CONFIG_USB_SERIAL_OPTICON=m
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_XR=m
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ONBOARD_HUB=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_MAX3420_UDC=m
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=m
CONFIG_USB_CONFIGFS_SERIAL=y
# CONFIG_USB_CONFIGFS_ACM is not set
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=m
CONFIG_USB_FUNCTIONFS=m
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
CONFIG_USB_G_SERIAL=m
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
CONFIG_USB_G_DBGP=m
CONFIG_USB_G_DBGP_PRINTK=y
# CONFIG_USB_G_DBGP_SERIAL is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
CONFIG_UCSI_STM32G0=m
# CONFIG_TYPEC_TPS6598X is not set
CONFIG_TYPEC_ANX7411=m
CONFIG_TYPEC_RT1719=m
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_STUSB160X=m
CONFIG_TYPEC_WUSB3801=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=m
CONFIG_TYPEC_MUX_PI3USB30532=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=m
CONFIG_MMC_SDHCI_OF_DWCMSHC=m
CONFIG_MMC_SDHCI_CADENCE=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_SDHCI_MILBEAUT=m
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MMC_SDHCI_OMAP=m
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
CONFIG_LEDS_SPI_BYTE=m
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_RT4505=m
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=m
# CONFIG_SPEAKUP_SYNTH_APOLLO is not set
# CONFIG_SPEAKUP_SYNTH_AUDPTR is not set
# CONFIG_SPEAKUP_SYNTH_BNS is not set
CONFIG_SPEAKUP_SYNTH_DECTLK=y
CONFIG_SPEAKUP_SYNTH_DECEXT=m
# CONFIG_SPEAKUP_SYNTH_LTLK is not set
# CONFIG_SPEAKUP_SYNTH_SOFT is not set
# CONFIG_SPEAKUP_SYNTH_SPKOUT is not set
CONFIG_SPEAKUP_SYNTH_TXPRT=y
CONFIG_SPEAKUP_SYNTH_DUMMY=m
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=m
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
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
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
# CONFIG_VFIO_MDEV is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=m
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
CONFIG_MOST_COMPONENTS=m
# CONFIG_MOST_NET is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
# CONFIG_GREYBUS_GPIO is not set
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_SDIO=m
# CONFIG_GREYBUS_SPI is not set
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m
# CONFIG_PI433 is not set
# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_FIELDBUS_DEV=m
CONFIG_HMS_ANYBUSS_BUS=m
CONFIG_ARCX_ANYBUS_CONTROLLER=m
CONFIG_HMS_PROFINET=m
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH_PIPE=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_ACPI=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
# CONFIG_CROS_EC is not set
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
# CONFIG_SURFACE_PLATFORMS is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
CONFIG_COMMON_CLK_MAX77686=m
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=m
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_AXI_CLKGEN=m
CONFIG_COMMON_CLK_RS9_PCIE=m
CONFIG_COMMON_CLK_VC5=m
CONFIG_COMMON_CLK_VC7=m
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=m
CONFIG_COMMON_CLK_XLNX_CLKWZRD=m
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_VIRTIO_IOMMU=m

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
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
# CONFIG_LITEX_SOC_CONTROLLER is not set
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

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=m
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
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_PTN5150=m
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_TUSB320=m
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=m
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=m
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=m
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_TUSB1210 is not set
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
CONFIG_DTPM=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

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

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_SPMI_SDAM=m
# CONFIG_NVMEM_U_BOOT_ENV is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=m
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FPGA_M10_BMC_SEC_UPDATE=m
CONFIG_FPGA_MGR_MICROCHIP_SPI=y
CONFIG_FSI=m
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
# CONFIG_FSI_SBEFIFO is not set
CONFIG_TEE=m
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=m
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
CONFIG_MOST=m
# CONFIG_MOST_USB_HDM is not set
CONFIG_MOST_CDEV=m
CONFIG_PECI=m
CONFIG_PECI_CPU=m
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=m
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_DEBUG=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
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
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_PATH=y
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
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
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
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ARIA=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=m
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XCTR=m
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_NHPOLY1305=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
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
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=m
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
# CONFIG_PRIME_NUMBERS is not set
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
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
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
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
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
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
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
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HEADERS_INSTALL=y
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
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
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
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_TABLE_CHECK=y
# CONFIG_PAGE_TABLE_CHECK_ENFORCED is not set
CONFIG_PAGE_POISONING=y
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
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
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
CONFIG_HAVE_KMSAN_COMPILER=y
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
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
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
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
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
CONFIG_RCU_REF_SCALE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
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
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

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
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--X2t9x9T/yd9ROp/h
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
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='8bdbdd7f43cd74c7faca6add8a62d541503ae21d'
	export kconfig='x86_64-randconfig-a012-20221128'
	export repeat_to=6
	export nr_vm=300
	export submit_id='6386efdb0af0bb6331b0eb98'
	export job_file='/lkp/jobs/scheduled/vm-meta-27/boot-1-debian-11.1-i386-20220923.cgz-8bdbdd7f43cd74c7faca6add8a62d541503ae21d-20221130-25393-eqwubs-2.yaml'
	export id='c34a20a9672e5ed7b88d9d0fe194b45aafeff127'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='clang-14'
	export enqueue_time='2022-11-30 13:53:31 +0800'
	export _id='6386efdb0af0bb6331b0eb98'
	export _rt='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20221128/clang-14/8bdbdd7f43cd74c7faca6add8a62d541503ae21d'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20221128/clang-14/8bdbdd7f43cd74c7faca6add8a62d541503ae21d/3'
	export scheduler_version='/lkp/lkp/.src-20221129-142914'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20221128/clang-14/8bdbdd7f43cd74c7faca6add8a62d541503ae21d/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20221128/clang-14/8bdbdd7f43cd74c7faca6add8a62d541503ae21d/vmlinuz-6.1.0-rc1-00015-g8bdbdd7f43cd
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-27/boot-1-debian-11.1-i386-20220923.cgz-8bdbdd7f43cd74c7faca6add8a62d541503ae21d-20221130-25393-eqwubs-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20221128
commit=8bdbdd7f43cd74c7faca6add8a62d541503ae21d
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a012-20221128/clang-14/8bdbdd7f43cd74c7faca6add8a62d541503ae21d/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.WARNING:at_kernel/locking/lockdep.c:#lock_release'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-27'
	export kernel='/pkg/linux/x86_64-randconfig-a012-20221128/clang-14/8bdbdd7f43cd74c7faca6add8a62d541503ae21d/vmlinuz-6.1.0-rc1-00015-g8bdbdd7f43cd'
	export dequeue_time='2022-11-30 13:53:50 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-27/boot-1-debian-11.1-i386-20220923.cgz-8bdbdd7f43cd74c7faca6add8a62d541503ae21d-20221130-25393-eqwubs-2.cgz'

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

--X2t9x9T/yd9ROp/h
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--X2t9x9T/yd9ROp/h--
