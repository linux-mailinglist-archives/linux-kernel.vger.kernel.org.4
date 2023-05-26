Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6E7121CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbjEZIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjEZIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:03:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6FD3;
        Fri, 26 May 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685088202; x=1716624202;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZZ40E80zYqGJfH+ufw/nxkeGw2+iALVewg5K0X6DwE4=;
  b=C7/sJQasHAFPGb17Xj/OI3cYIyw/K3gOd3gb1ewwpA/5PBQIBucr8fJE
   Kxq9Bc1kxUhrTuiPCImSn5i/aPOM1qmKoniEHJuvF1mVx/KK3jur7auRS
   WWGo2xW1XjHVefk2/H9b9x5DZUsoSdRXpuzn6Ya6hcyaGWxivRChSxKJo
   mi7eik0kOD5p8hGgPzffq7273hvbnCq30PQ3oYk/4cvKqHmM0aPUT7Ij3
   qYKEk4HOiBaybxhkUWnejzM9kFA1ghHWwUkJ6xkYHE9OHGE3NjoMDdLwi
   2IGQL+xGrTBOrvaLJPf1PcXWBVbw93Si3S7DYLj8VkYLYPVrBcYHnveko
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="417630115"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="417630115"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 01:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="795017448"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="795017448"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2023 01:03:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 01:03:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 01:03:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 01:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxvrkIxKU5AU6tSkJfl3lWmTUgF9q6bFTcX7Mc9HUj3pgT/+tu5nLnOscZd/B9EyHMPelolP3jhWk0DfBH0PRz5rw0V1Vk0UXMq49GtcxO6eXFfCrpmJpXTTrb7kyt60rc0e9QU6++vUtROaPXEiB/Ug63ymG2/X37Pf+a+PoRl27JVUzaAIHU+NpQRryB8gzSjN5d6+I9J1D+MCwuU/DFcf+IXJIcTXvRHGjlj+qoIOQ+lqWU7WL9nAqDT1UZOyO3mDlO3JGNfC5RtAW+X4ED4R4oEIcPZQjS7lAeetIxn2js2CoRb9V9dTsC1hHA75tF42uRwleGRsLtBc6ZmtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCUQSeVF/GymAKWwyxW89aztsu2LrDJYCxP/PyVeyHQ=;
 b=VGYQf6uZK6OlNvnyE60VeL21DCrFpI1KD4rhOXHDQxH15Ypzv4PMWkRvDjoUS6bLKVu1DjdcakJs/WpCifXNlzzVQm2OdC4/gVxsKrYLrgPccvzigE8ppYbyOS7x6WC0lPl1T+phHZuk2mwiTOW009iXd3kVal3va0bbIujJm2c2UBETWG3xqM5St8lJY6XQVjd+XUGSGRsh27BumzSW3OWOGG7zwT8UnzkDxDoS45oGAD6IRa8Sk4V3Hh35XQE8z3VyQDE9bwECKrewpv/BRGOScfrzf2tSMCy1Wd4uIvMHbXqKrKzCR5HRRAiGnNZpqw9rozALONeT0OZtWfpP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 08:03:02 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b14b:5c9c:fa0e:8e7c%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 08:03:02 +0000
Date:   Fri, 26 May 2023 15:59:48 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
Subject: Re: [paulmck-rcu:dev.2023.05.20a] [rcuscale] 812195e4f7:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZHBm9IfDk1QGj8SY@yujie-X299>
References: <202305241757.57c30887-yujie.liu@intel.com>
 <e4328f8b-6ec5-46eb-bc43-1217feba7ca2@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4328f8b-6ec5-46eb-bc43-1217feba7ca2@paulmck-laptop>
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS7PR11MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c4f6bc-f7c2-4e77-44dd-08db5dbfa0d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUDae4L3fxpn1S0E6YUh1I/Cay9uIj63yIWTq1r5OY2BIfyI3jf99Q2kLBkg8mwyamgYPtffdhV/9BwxsoodH2fsidkYN9DjGEeBe0zRUNW7gsEKUHT2zeWNiXTSOCCgQSdzcUaZg+s8PRTbhtLhZ7kGLnBImcqVfhs7g2T1VWTIqtlmug2ObCDUw73E8lz6XtJmShZLiYlYnTW5EPVkQvS4mZKtBDZFRuYdtoUzVX/kRNiJkQG32nQb9iyhpB6KFDxCkf4Cni8y6+sWSHnIyfdpNIrQJYkftvtMpsNIkLYMK/vPwdauqegTnJZ3dUmczCtiM3PcU//Qrfk2oxKClLDpkTioI5Y1+ESPg4cbixRa4vCvA9eSaPLtLPJ/26+bTZ0BvLRAFgoztDqpyKFM0EDnshiu6xBFrbLIwWvhpXa5DpzA1pwwfhzrI0VKNanG0abhyXjmp8G7Xo9cWVh/4Wkb2DLFwdVzCcM56ZUJLxhcohSF9wsvLf1oaeNcbNesy6S8ztJ0U6qRMZVxQLB0t5ZwxQGZrD2OOGykgn26R+p6zsj2fcVSY1U23xfNwtLFcDsbw0ICl040OJ2Gwhbz5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(83380400001)(186003)(4326008)(6916009)(41300700001)(2906002)(66946007)(66556008)(66476007)(82960400001)(6506007)(6512007)(9686003)(26005)(86362001)(44832011)(5660300002)(8936002)(8676002)(966005)(38100700002)(6486002)(316002)(6666004)(478600001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/y9A30CvB+cKAqDgLkdRBTWoXAx+AfESNkcXKH9BGSjQ7yc1Jic8VX+wxFs?=
 =?us-ascii?Q?y+La8BkFyl8kMRIZjamIurB9Gl4IRN0YqiqUdkZ8EE3WuoSlHjfeK4+OE4de?=
 =?us-ascii?Q?2MkNaYEjwStc2cAEr7zZfcP66si+b9VUZrmpccI7aIfy4m7peAx7wtK0isxN?=
 =?us-ascii?Q?sDYgGbFMWQqpOqOhp2liOj4llmBEXkumM4KUygpITm+PrLFTmfbPHYq4gvM5?=
 =?us-ascii?Q?2zTO6/pnnXJKjpfrl/WgKYFKuvy4YsSVum++lj9SzVmcooX1YHBDimuDqubR?=
 =?us-ascii?Q?V+mizerIlc6Z2DJjpoATbbEsqE6h3CCFc2FTCzlHib47+ww6FGP2zramaMo1?=
 =?us-ascii?Q?PBWwxPicOlqRIzTbzJY7e2LyeBLgAPceml6Mh4nRXDJ1npXEWbBCwX4XnbiM?=
 =?us-ascii?Q?GbWaJQxu4mtPNQpN1lmmUC9MyvjMji+74BJTGJHpkRSYsz1ho0A5HoYbuuRX?=
 =?us-ascii?Q?3kkDIn1ZwKkDA2ja9Hi6NY3ew8gcV+SQjpUmSdGKo5ZhUSeDQu0oEjw584wz?=
 =?us-ascii?Q?u6b7qq6brlLSNSWjpq8RG/ZDRxM7HV26IgLMoB0ykoFQFz4GmuxvdqqHMv45?=
 =?us-ascii?Q?22gy6888QWpmcaVxbO0VfAi99OkGUd4lP1m7WNLMZ1YqEZxbDwMGzsQQDANZ?=
 =?us-ascii?Q?c1YSKbwp20ZtGz1iSr/bpOcj8R7YZz7rDRxkFzc+Muvrek/9grTtAHhx4hQc?=
 =?us-ascii?Q?1FGYfoLWx+IWyYinXSrnBMDFjjksZouYikAwlekfaGzcB7NROrOR0ErX5gfL?=
 =?us-ascii?Q?6MViBMbRLQpY5MfIFaeOsoBaGqz+j/t0udXh5fRX3zkBRmu0iJsYyu/XTV09?=
 =?us-ascii?Q?1ufgXCIBXmGU64y+5gaSF7FiGOKS+x+aM3ZL/PlB3WnkjRGXqJYvvmvgXvWA?=
 =?us-ascii?Q?SeXM3o9pdnFOEIokvsLvGdsB13P5cJwSOTSH+c0lG8eE0lYCx42n3GNqS0oA?=
 =?us-ascii?Q?B/crQjzjNUQdCBdVrbnloy0xJY5rA7a3bXldTPuHu3qMxxMjQnaTRBQOJJbV?=
 =?us-ascii?Q?ZQvXNtMys+Kh2wxW7WCe2LZcH0HCkytVOYCKfCCpju78s4fdhCst1QvoBxOT?=
 =?us-ascii?Q?jS/FJZoTOP4cb3NIBAk9ttkc7COXzmp4OGwCDcKoIAWZ4Z/cEsvbDbwB9Pux?=
 =?us-ascii?Q?/xvSo6F4J1DuU/dyTRGsMAebGOLOJW+RnUO9088XYlDxZtlirnFpaoAiHf5o?=
 =?us-ascii?Q?IJc5Y5DswrRJEM3u0zGvX8yysmN3Ee89oA7TXyzbg80C5fxh9JzJHZ7Sl+w9?=
 =?us-ascii?Q?3pPTl2UktALTWvLwFbESYVEoV860eFzfTmajyYlyzIAtShIyWgC5Rcf00V7D?=
 =?us-ascii?Q?3u5t2Pd8EaBaaHdGOU2GOtxBrJDL9s4sijeax2vT/H04pcnJ16PLK1/EhTzt?=
 =?us-ascii?Q?kAlKcgthxJYGcOi5xdagkMAcLyRHYD1F73/CdPaikQjbPuJaVxaxLh2o3Er1?=
 =?us-ascii?Q?qtM/3dJ0Zerx36bedRklZ1flSjJTA2opPlujYyYJ8Fm35J6w8Z/JiuaDcPuS?=
 =?us-ascii?Q?hs/GaY8N6VRV9Zv625DWzWXXx8YnF4c+rO+IWWp33IRKDGnbRaoTG7vkwF8t?=
 =?us-ascii?Q?oCiXoLe5dIpcRkx13LslbJPF+L1t8E5E+pK+33gm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c4f6bc-f7c2-4e77-44dd-08db5dbfa0d1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 08:03:02.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6KHJTTQHSx8E4LM2s+whVxMIsIHpcGPLRGOjY3Sc35KmfgSKH6Cu3Wa1SZEQB8hTafoAEWWab/K3LVW8CpXow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
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

Hi Paul,

On Thu, May 25, 2023 at 09:45:11AM -0700, Paul E. McKenney wrote:
> On Thu, May 25, 2023 at 01:37:13AM +0800, kernel test robot wrote:
> > Hello,
> > 
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > 
> > commit: 812195e4f70ef0e9fc68127355c553c537749546 ("rcuscale: Measure grace-period kthread CPU time")
> > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.20a
> > 
> > in testcase: boot
> > 
> > compiler: clang-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > +---------------------------------------------+------------+------------+
> > |                                             | 2393139b67 | 812195e4f7 |
> > +---------------------------------------------+------------+------------+
> > | boot_successes                              | 8          | 0          |
> > | boot_failures                               | 0          | 8          |
> > | BUG:kernel_NULL_pointer_dereference,address | 0          | 8          |
> > | Oops:#[##]                                  | 0          | 8          |
> > | Kernel_panic-not_syncing:Fatal_exception    | 0          | 8          |
> > +---------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202305241757.57c30887-yujie.liu@intel.com
> 
> This commmit has since been replaced by this one, which should fix this
> problem:
> 
> 60901dadfadc ("rcuscale: Measure grace-period kthread CPU time")
> 
> Please let me know if the problem still exists with that commit.

The problem is gone on commit 60901dadfadc. Thanks.

Tested-by: Yujie Liu <yujie.liu@intel.com>

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  clang-14/x86_64-randconfig-a015-20230522/debian-11.1-i386-20220923.cgz/300/vm-snb/boot

commit:
  812195e4f70e ("rcuscale: Measure grace-period kthread CPU time")  <-- old commit from dev.2023.05.20a branch
  60901dadfadc ("rcuscale: Measure grace-period kthread CPU time")  <-- new commit from rcu/next branch

812195e4f70ef0e9 60901dadfadcc152ae5cad7ebae
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6         -100%            :7     dmesg.BUG:kernel_NULL_pointer_dereference,address
          6:6         -100%            :7     dmesg.Kernel_panic-not_syncing:Fatal_exception
          6:6         -100%            :7     dmesg.Oops:#[##]
          6:6         -100%            :7     dmesg.boot_failures

--
Best Regards,
Yujie

