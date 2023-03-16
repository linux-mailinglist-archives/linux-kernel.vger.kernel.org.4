Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74456BC63D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCPGoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCPGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:44:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3136A78
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678949045; x=1710485045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K3pCFfevSjmU/uRx66sC/6RXFK3vZ6t+fP9eDPonQBU=;
  b=eBJePdfJjgK5+Q79me/RnSN91B+UFvN9ukMVSuVQgKBiQ4aKbuzw13GW
   16HGt/qxn6p1cLeHRWMJxFJdg5yeLsdYkZb1c+gz9n65WjXhkIjB5w8ye
   uFJ6w89CU3Zxmjf/cggU9gZORll1SavFtPc93QJ210Q/zEFXoXlmktmXY
   tlD9GP5mYC8YR95uJbDBLNvrePZpa8Cf3KXQlKDIR6PuexT44xoM5ptJf
   f7c9crsVIf5y/sKh99CmoJR5ma0HtR+4CoxmqOFXWiAolEK5HXhDW3MKI
   VSPIT/GESdPhcxSwdjCb+YexamUFUCTUZh3NQdrKkIRK7kvalLiDrPadw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="337922408"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="337922408"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 23:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="712209929"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="712209929"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 15 Mar 2023 23:44:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 23:44:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 23:44:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 23:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwG9EHG1fkP/lp9+TW9QDwU93hvHt59QoOCBkMag2ghfQCgbZkOsDTD15GS0fzQVarNZl0DgkILt1HMzh7jOCaAH9mqMejd9UEQfK5UzRxaQO3VwkkqIrLDKp6sY6OTHz92L8F6STOqLlCqLITQ7OQuwyTf+Rpy2dEbSTE60VIC0ok53L4TSOEWs1moqHyRgqx0rUg0uNlpfIQwvKuLshHSdzendiYhfi/TsSHdwstCG9ioRt3UbQXwdtvMAmR5FDnjLbqrekgM7Q198lNnhhDYaZVATAPX/QkK+++4esLF4LV6JiF9/TFpKFV8KLhRVnJsHvj6+9fLg4QQHaOUDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDRxtnNWWXpe+/hRQLbjjJiIuvUXtENUbXU9GW2g270=;
 b=LJg2FDWS1xQ/9FweEPa66wIGB0mZFBfjtlNDmps5OyKk00NqnmJ7HeFtCztdcvDcUPtzaJsLB/qw/zV2jqtustUgMzgVUSZroZ56MuFZLMBq5pAydzJqW5J5DuJxEYjpnmnuga17SMJwDlfYI6WlUiySROMB5QOyBiES3NUTLSbAqO6p2KhRbC8A/0XCKze/nNXtpTdbP+00Df3cB2d4ewKSoVJG799gQd+w2n9/Yz+eBfnvh2MHZ7Zw9KU6bcBDRKMoXaMmbOyBgoLUHlrMreK0n7IKavujw69D/rGUVrwQkgZ9ihcN+C7iJzQ7GXNKr6TpiHXhjH3CIbUSZoqa5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5919.namprd11.prod.outlook.com (2603:10b6:a03:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 06:44:01 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 06:44:01 +0000
Date:   Thu, 16 Mar 2023 14:43:43 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, <wangjie125@huawei.com>
Subject: Re: [PATCH] sched/fair: Don't balance migration disabled tasks
Message-ID: <ZBK6n4jhBxfJ1Lug@chenyu5-mobl1>
References: <20230313065759.39698-1-yangyicong@huawei.com>
 <ZA/lIjaNY7PhjcXh@chenyu5-mobl1>
 <c102b64f-de98-6815-8f63-206d34f87e08@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c102b64f-de98-6815-8f63-206d34f87e08@huawei.com>
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: e262a2c0-2e64-4c18-5fbd-08db25e9d3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZKqe6AG+0EySRoc2FtGZKyHmZPyTIOuvP5SUqFtNcMt9hRGKr54p9cj+hWwz9iUwB0MEnnyy6CzBHhn0lrdsvEGA4WNY8B5YTYjHle66gphBl0CdlMniZYXDE8JY7bLj57nnvsBHVyudRRYdVXv73MkWL8g4KjPA8XqmVAV6r8H2oyCI3ts7fwoGA0Z6zBrw14rqbq+vxj3qX0gAt1rVkkTslAjCMhueAo0s6QQ0BzWyucVyMgEw4M+1Cemo7YHfewmPWjBapM7/g4gguMX+XPXkTUAfhYtpwCl9gieSElaCK+5+gg90qnnkZpkBzOklXLsOQrEHL50jBOp8UAIC+LPeItRjuf2zReiuBFMPNOhKQZggPl8z+8t1RD757JIXDzV6DxRJlazSIPNi6Og2rEkxg1mfLFhokbCxkD+A+px1zWtbML1Ht0oR52Ezsh/o5GzwK73h0TrlwKu2YRKwFeHfoAlknS96MYyv0ge9/Buv4LlykMEi/0LX5Zun+24OfNA2PhqELLVNAPnDkBaTDBU73+ggM+LsHR8+j9EX0Y2ZH9o46oAv6AAKFPRV0F9GIkco6FOjjHyU1XRLp4ttZpq4rvwSJ0RRv29NY2Igh6snePkMLqEciPCiFGXjiFLylXfOrsAhCmMfhRAdejzLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(7416002)(41300700001)(8936002)(5660300002)(86362001)(2906002)(38100700002)(82960400001)(478600001)(66946007)(6666004)(6486002)(66476007)(6916009)(66556008)(8676002)(33716001)(45080400002)(4326008)(316002)(186003)(6512007)(83380400001)(6506007)(26005)(53546011)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1YWDMOj2LrRwKIfHxKBvnY4s6n+P8Jzf+cpNOVpyC0VE2f7FkbQKa3hm1+2v?=
 =?us-ascii?Q?MZ5K/RfmmAY5wvPHciLpLwSORzws/ybOkMJ15rATisuJA0BO01su5IT8Qyzt?=
 =?us-ascii?Q?oEQ0YZxOqOoBqjCNKCBg/CiFrQQqAOcl+fc6HQLV7Y/j9uXRiRw5Elringet?=
 =?us-ascii?Q?SKc3VKr4vdrqBZ1LzUV//KzZ2CPGTwEBIM6YpteTMIW47H3Q4eZYKaeF2OAN?=
 =?us-ascii?Q?no/88ZR1M3FtH04axELJ3laXwDi8ggBxgrD5J0FuFGcZvHbWGHTfA5nFY4Vq?=
 =?us-ascii?Q?NzK9/cTesz2kPlCmMAai5q961RVA7knXvPMaD4eL4sKPP2dB19NKyRCaWc6V?=
 =?us-ascii?Q?PmvS4ys27sAibJJbXZ7SrnkGHr9AwmQSNukco7yxEMOSpE/r8VCdE2vzfz2R?=
 =?us-ascii?Q?/fTqauVV37w+OLP7oJd2HYJQ8vHsaQH5tObSXYCleQkkNf+RWzb15V/wEEbq?=
 =?us-ascii?Q?tJYjIzoFYeIR96lH0pfb9u2ZFVqTSsK4NoG1ihTtvTpEqPc+DHy+e7h04gtF?=
 =?us-ascii?Q?Ru3FNxke9A2OauvIJYiw+5m+176dHYIxf2NtWURUmqbE/gRob7JmzQvO7tAP?=
 =?us-ascii?Q?kO44QrK9CuYS7hu0PuYdiK2VYKNLfKaDQJLfskBXjtLhDqSc6qztg9ZgyZnB?=
 =?us-ascii?Q?XCXgzKOFKnOdDZzF3U2IclBGh0IqwXvJByU6iGuQG+Bpoui2cc4wZfQwjP01?=
 =?us-ascii?Q?VoyzPth0ouoUmOnRlgcMw7r6fiYH1iHAuA7ZUp4nPwALGHHxc4feJlpXgRzD?=
 =?us-ascii?Q?FqMUsNIngjgdsiuo1WptYtjVn8GoPbgp1eDo3uBC1dzJNOZBB3Zj7i6O21P0?=
 =?us-ascii?Q?yJwx2dg+8h0Zcf6mteHVs4hHipjyxkg7XsfsOzIhH/H/BwSXraFeSmFIgH5d?=
 =?us-ascii?Q?FVVWPcZxFHaFtsxGnUhp7ZfV0bJpyf2FysKrwG2nX+k2wRRFM4VNPsvhfJEh?=
 =?us-ascii?Q?9yjABhHoJOHZp6F+d1y0cUna+r9iI0XxD9PctRMOjm1E56nmsWHVzDWjDvcS?=
 =?us-ascii?Q?d9hyaBOKeZ8ISFIQOGBP5pU0jnJw5h2V2NagYTYcpuZj1152NsmidBjxTcDX?=
 =?us-ascii?Q?thjNWWePxLECiiS3TysZE66ohL5OrhSyk9SjvJAHlpY04yMteUaoBTsE8Gka?=
 =?us-ascii?Q?NjPcDx7njOHKbN2bGUz1Vti1jw4kiFDGAWJDykvMEpDY0rNCtXYsjFyInJy5?=
 =?us-ascii?Q?AHtD7cEdAwj31cA3ddeO3fKvAL6Zuj6ojv6XTOSBE0G4Ro/640E29a2XsJws?=
 =?us-ascii?Q?LZwXajj2AG//yJRGSmkxJC1tKa1Ka1HUGoVWHwNRQgpVW1mrsfomxCV1PhkQ?=
 =?us-ascii?Q?C0uSF9N8+IJHWwN9Pjo0RdGE1Df+epeNLSk3XBNVyqnQ8E2O0ycelaTmr1BK?=
 =?us-ascii?Q?6x31oGErjXgBk4PGsM2XBAHW4elfncLjwhFK4xC30dz8oaATYbgjMMdbQzjp?=
 =?us-ascii?Q?0F3/s2Fjm4dfCHts1hMUDiZkwANSUWc9Kmixwhq0k/nQsk9JwslT9bewqj1D?=
 =?us-ascii?Q?Tk2euTBe8G8893zeS7kZ6A2hHv1svm2+/ra0NrIzQ7vdPBC8sJzuVcZ91Nsl?=
 =?us-ascii?Q?7W5tli2Tuj7RVIRFl1uzgEOkR1QSVJ2pHCIA0+BR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e262a2c0-2e64-4c18-5fbd-08db25e9d3c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 06:44:01.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJjZXtKnuqSxjNcDH0n3yOhGbBuAqZsMa753FnEBZHgSGjangRilVg7IgArkEvpJV95iGRKLn8jXn4RfMP925w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5919
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-15 at 17:55:13 +0800, Yicong Yang wrote:
> On 2023/3/14 11:08, Chen Yu wrote:
> > On 2023-03-13 at 14:57:59 +0800, Yicong Yang wrote:
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> On load balance we didn't check whether the candidate task is migration
> >> disabled or not, this may hit the WARN_ON in set_task_cpu() since the
> >> migration disabled tasks are expected to run on their current CPU.
> >> We've run into this case several times on our server:
> >>
> >>  ------------[ cut here ]------------
> >>  WARNING: CPU: 7 PID: 0 at kernel/sched/core.c:3115 set_task_cpu+0x188/0x240
> >>  Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT nf_reject_ipv4 <...snip>
> >>  CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G           O       6.1.0-rc4+ #1
> >>  Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
> >>  pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >>  pc : set_task_cpu+0x188/0x240
> >>  lr : load_balance+0x5d0/0xc60
> >>  sp : ffff80000803bc70
> >>  x29: ffff80000803bc70 x28: ffff004089e190e8 x27: ffff004089e19040
> >>  x26: ffff007effcabc38 x25: 0000000000000000 x24: 0000000000000001
> >>  x23: ffff80000803be84 x22: 000000000000000c x21: ffffb093e79e2a78
> >>  x20: 000000000000000c x19: ffff004089e19040 x18: 0000000000000000
> >>  x17: 0000000000001fad x16: 0000000000000030 x15: 0000000000000000
> >>  x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
> >>  x11: 0000000000000001 x10: 0000000000000400 x9 : ffffb093e4cee530
> >>  x8 : 00000000fffffffe x7 : 0000000000ce168a x6 : 000000000000013e
> >>  x5 : 00000000ffffffe1 x4 : 0000000000000001 x3 : 0000000000000b2a
> >>  x2 : 0000000000000b2a x1 : ffffb093e6d6c510 x0 : 0000000000000001
> >>  Call trace:
> >>   set_task_cpu+0x188/0x240
> >>   load_balance+0x5d0/0xc60
> >>   rebalance_domains+0x26c/0x380
> >>   _nohz_idle_balance.isra.0+0x1e0/0x370
> >>   run_rebalance_domains+0x6c/0x80
> >>   __do_softirq+0x128/0x3d8
> >>   ____do_softirq+0x18/0x24
> >>   call_on_irq_stack+0x2c/0x38
> >>   do_softirq_own_stack+0x24/0x3c
> >>   __irq_exit_rcu+0xcc/0xf4
> >>   irq_exit_rcu+0x18/0x24
> >>   el1_interrupt+0x4c/0xe4
> >>   el1h_64_irq_handler+0x18/0x2c
> >>   el1h_64_irq+0x74/0x78
> >>   arch_cpu_idle+0x18/0x4c
> >>   default_idle_call+0x58/0x194
> >>   do_idle+0x244/0x2b0
> >>   cpu_startup_entry+0x30/0x3c
> >>   secondary_start_kernel+0x14c/0x190
> >>   __secondary_switched+0xb0/0xb4
> >>  ---[ end trace 0000000000000000 ]---
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  kernel/sched/fair.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 7a1b1f855b96..8fe767362d22 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8433,6 +8433,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >>  	if (kthread_is_per_cpu(p))
> >>  		return 0;
> >>  
> >> +	/* Migration disabled tasks need to be kept on their running CPU. */
> >> +	if (is_migration_disabled(p))
> >> +		return 0;
> >> +
> >>  	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
> >>  		int cpu;
> >>  
> >> -- 
> >> 2.24.0
> >>
> > Looks reasonable to me. Would it be possible to also update the comments at the beginning of
> > can_migrate_task() starts with: "We do not migrate tasks that are:"
> > 
> 
> Thanks for the suggestion! It seems only uncommented conditions are summarized in that graph,
> otherwise they're mentioned close to there branch like kthread_is_per_cpu(p) case. I can add
> it in v2 if you think it'll be useful.
>
It seems that I overlooked migrate_disable(). It can only set current task rather than arbitrary task.
As Valentin described in his reply, I'm also thinking of what type of race condition can trigger this.
Are you refering to something like this:
cpu1                                    cpu2
load_balance
  rq_lock(cpu2);
  detach_task(cpu2, p)
    can_migrate_task(p) returns true
					migrate_disable(current=p)
    set_task_cpu(p, cpu1);
      WARN(p can not migrate)
But can_migrate_task(p) should return 0 because p is always the current one as
long as the rq_lock been taken by cpu1.

Thanks,
Chenyu

> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> 
> Thanks,
> Yicong
> 
> > 
> > thanks,
> > Chenyu 
> > 
> > .
> > 
