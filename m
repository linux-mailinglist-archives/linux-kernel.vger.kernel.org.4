Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B525A635B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiKWLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiKWLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:25:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793AED5FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669202697; x=1700738697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fEELzdA7mN4QXjQZtIiClEdwrk66ULhJvL4D//tqyLA=;
  b=IBF3WEKn+4f+9lvRrAFNwILeCMjD2bruxsn0zGw94fz9L2cj3d0YaPs5
   W3j3fOmPB0KLy9emk2IvrGkMOjhU8RDzpxVClMsoGcxCxoY1nqrET7lEk
   KSfFnK8PbuM+GGqyBOSM1I6EvOvqD5KEy8F7ZeWlxmDQgyg7qVdcxLBFQ
   qi8S2n/XRm4I09BEfnpx8qnDdjndq+Z6iCTEJTobd+OFzOyVEM6DHCs9B
   6htuqPKxSnCJ+mZ3CzU/+BEHakYpz6d1BdvBk+9yzBfWqwfbi5R7Pa/27
   eckNZBahTtq76u4t64VGks0wq3vyyxZs2T8V4eE0QQCSJ1Y8xiNmHppnB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400337498"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="400337498"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 03:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="710557339"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="710557339"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2022 03:24:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 03:24:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 03:24:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 03:24:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgiPqsGMeJqSKgOeHBIFlUF60/eeEY4A/NWX/XaZCpioE888WtR57NGK3j0C0ObvTdsBnyMoPwYqHSLSTHZdjIlni/XQCdq7wh0nsPB0XcqlNHTg6cEAz9PYxT6/+tH5b/0Il+bUPzphGMLbpWb2IVKnY9hnzUdRAlgVgQS5bzOAtriRZmHxi110pMDr3mVrNffD2tjogayGBbYMYVFhskQTXrgOSeuO9DSnp62yhinYUg/jFqe4u5KuP45+6CM/J5cCch3DKinspbekd19KeAtdU0QGSprh60oSfoE7Mz6v4z6VKpxHitYgbm5aEuIBo9lZ9MmsgVDmF1Q21dD1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch72XZ6vPcM0gBVNoIBGyjPGZg0/b0siSRPAGE+p5Lk=;
 b=XVteWYYyq6XfAUemGAE8t8itkGgFyj4ZOkohpVJaviIvbsZcnGqxUQ8ud61NidG5Eti/4YfbI5hEkD7dmyKqS2alfBBzo3l0yNpA08eCCknwXzBbPP3JTvFWejKNarx8l7xdnQwUZvqzoJqKUaqaRtcdM0vw1P9yOuPP6w/L9YlwA9WCwhwZw0LceLvgkA2UleE6nQWx7m3Cktm7dWk6kq5kHUmFm3emt77D+QnTxs9Hn0EvhzXmFGWxoPaO7HnCjku8ccx+SAIpfuOqujA6a5UOrd15HmkPM/Sm+8EAkVqjCWrS+wxvMJwHnK4cQ/Eoaksyaj7RS9djDY2anhw2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA0PR11MB7306.namprd11.prod.outlook.com (2603:10b6:208:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 11:24:53 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%6]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 11:24:53 +0000
Date:   Wed, 23 Nov 2022 19:25:21 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "notify_change" WARNING in
 v6.1-rc5 kernel
Message-ID: <Y34DIbVyih2rWYRF@xpf.sh.intel.com>
References: <Y3Ybpuy67I0xlwLa@xpf.sh.intel.com>
 <CAOssrKdNRew=5OMsmc+F01NEzyz1cd6ctJKV=FBVrHardpEZSg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOssrKdNRew=5OMsmc+F01NEzyz1cd6ctJKV=FBVrHardpEZSg@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA0PR11MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef1c640-1e5c-4fb4-62f9-08dacd4557c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxUVSnV7tFqDrfXlkZaRnslxGop2smuJXx3MojIxba8vOsTtrHc/zpLnZL/ujK1Xc7gaPqEQBZlrF2S8ItCM+OsaIAKaA7DuVE7RQSNSA0ji1sLQ1+mLPnoJe1bArdtOjzqI6WfrjJIF14DefTdJ9m4LLuZkDlZ8gWP1+8rgXyajAYkKz0w5DYEjnRAyX5jJmrChIgDDCkLp3by7TEmnKje6mpW3sruU9d58Ra02BxATPS+DZfkExrkCwIY2/L1Wf4hhkoE9EY5UizY95AvIY3a5qRcf4yTyjP0vHX7vjNfTkxhYKoz2TgB+QaxwGIJfckSxXZKayqhbiy86L4r5eTjIVgRu3E2+dLkMnBg1JeinzCx/JhMKjgkoSOgdccFI5h3Nr6ZTkgAegZu02RpXIA0uhTf+eO605mRFlY9mikLvLBa/aSvLT4kXnNEl+fu9/5ymrUHn6XWlkKI4YR71JsNxAPce46W2Cq/QdwMdtnyu0wFkeJ6EP8xziej6WA4H+RyZE1BDmmy+X5AawaKFsseb74ICgGY+Oc5tbz9biMgJtHioznwnU8B0/qEVQfPCUt2v9kep74R1GSUiuMj9s07JVjBU9R0TtyqI8wtuzh7hiJZ8E/K9Hs1+sdxiRzISQu+r36VN2WFkltynwnQ9Asa+u9wky/7CjDdVb/5GYFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(8676002)(38100700002)(186003)(86362001)(83380400001)(4326008)(44832011)(66556008)(6486002)(45080400002)(478600001)(5660300002)(41300700001)(966005)(66946007)(66476007)(82960400001)(8936002)(4001150100001)(6916009)(26005)(6512007)(107886003)(6666004)(316002)(2906002)(53546011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FK3GlBrqZHwzcMovFquSYnmcOaaO7nIsRSmxClwhYDmXikOyMPSWaSwbiMVy?=
 =?us-ascii?Q?LiekzleVNo6ty7JsPEU+H4Kex3kbSH64Fpsdtnvy3jUwEB9jdHlbfCn7cpZ5?=
 =?us-ascii?Q?53RkQ33svjvvui2h0TV8YxunweXkZQ6o0jm3FF+sKET/jy9HknRY0gBPgx13?=
 =?us-ascii?Q?rnxlAnBYSWKzDymKf0PN/E1JpsS2YfXC3eUOR2FOcmd4+puxRTkezfteUvti?=
 =?us-ascii?Q?E+VqwLMNhT9Yzu1ljawLf+p61wGkF9IZtFSN7T3gJXqjWM58TabjJ8GcbV3j?=
 =?us-ascii?Q?IcM+jvjO8qhqicPl3pRJTVpsRjeXILZpp3RalUjiE1/ZIiKcwftIt65W3b1y?=
 =?us-ascii?Q?tfrcwGQiXLsH0ROJTcr0EYaepUFHW38yq2eWP54IFgxlfj2VBaFGA0mCRwFU?=
 =?us-ascii?Q?4PXaeGT+XfzCsP6YNTWADrH9FwXvjF4JFYnuPKClTcUiL5AvNEtFUvVaGb6l?=
 =?us-ascii?Q?kXtBxdksRddZRvsv+QhSYGXu08Ez3ryu6xLcBZhcDx/5V/758a6XlGjGtrrH?=
 =?us-ascii?Q?imwR6boYHUNeitjbMO9C7EFW9jGdxdpQosly07ZA73J9HGIZMHVrxmAf26+1?=
 =?us-ascii?Q?BETiyFylXvNh5uiHuHa+y1DMQ8fNytr2/AVoSQfRFh8wOTUCLPMH/7vNfw+w?=
 =?us-ascii?Q?iUH99d6f/ovzsb2aqmZL8ph+qmZgoXmLBxLo+PFGZsutfylW2nSMMKHLDHLv?=
 =?us-ascii?Q?9foRYIju7wJ5n2EUkfADRUS6tyDsoqMaeZ8+lN+YjZ3kNQDC1cQtWoIQwPbU?=
 =?us-ascii?Q?Kl1nVbdqtiIPnNyUVXcZeAZ9BueXUUCey0rygfu/4rH8Uf+WxP3VMQuh1grm?=
 =?us-ascii?Q?OkqRMGvRUFbBd97XD2IKQxeMSi5A0FUl88QDNpcXN/pHqlBz+j7rGN1D11OT?=
 =?us-ascii?Q?Q+U6pU1czD+9+I/U+yYgNWgrQOzW2uGQRSRhSXfWa54Rgy3QuGZQ+62i2S8E?=
 =?us-ascii?Q?4WeHCPeIBWMMEzYzNyCH5rwAqTfu3Nv+Etgj564cMo4gFznVTAvIjFrHVo4j?=
 =?us-ascii?Q?/Ij7E1zde9PAcaj4ymwRXJ9l5VQeJavtxGOlzzWtt+XLcirzhEujz2vdWWRh?=
 =?us-ascii?Q?QA/X3B90lIgaQVA4wpkDO7PjWhSGO880LTngvAATI9N1Ja8/q+BsaxIUtr4z?=
 =?us-ascii?Q?bg5FySNvXwvnyA32/OtnR+s6iBFk7HHZ/1G/tC5d/kEDkyZiOSUYXD5GQUAp?=
 =?us-ascii?Q?zTqgHy4GY6j6KdgCDo5dE10sj9F/QBaji3nAtARcAbKfa3n5Eg4PqydyOJis?=
 =?us-ascii?Q?76Sznabf2R01UYGSHqMJQZhy+9iyUdZbnhk/8PFJvG7lzHOWxjvXknA9lunh?=
 =?us-ascii?Q?5aMjmGM+6L4X9H2kII+cT0FGri1uo2tDSLQ/FjFqGEsvmhd2yt8MTTvAx04J?=
 =?us-ascii?Q?ZqWyiCqAO/qdlNvYLz4rgeD4rFp+n01vWdaxchHPVdl64xEkQLvCgi4iiFYw?=
 =?us-ascii?Q?YiFr+YZziSh7rYXRlNPQZvfLAjaZzP0ZdAh/7lTu0t6mus+rWvCn+boCWTrp?=
 =?us-ascii?Q?fcbRNh1M0Hfc3H9nUsOci+GOdGmlS4qlHlw8/hG3dnZgoJ2BcJg9o9jT8Pdk?=
 =?us-ascii?Q?l8hFAd5EkBmrpPjCUDlOrCz2oo70sHtIufvu+YTw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef1c640-1e5c-4fb4-62f9-08dacd4557c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 11:24:53.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71KUh8cZPbjBqH2Ct7UiB13oFRJSyZXV9iOKAlYOYpbHXueO3EeHqwyO+fcFcinEnnBzNs2gq1Ga7gkrNNDOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On 2022-11-23 at 11:54:59 +0100, Miklos Szeredi wrote:
> On Thu, Nov 17, 2022 at 12:32 PM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Miklos Szeredi and developer,
> >
> > Greeting!
> >
> > There is "notify_change" WARNING in v6.1-rc5:
> > [   45.378232] ------------[ cut here ]------------
> > [   45.378741] WARNING: CPU: 0 PID: 463 at fs/attr.c:327 notify_change+0x9a1/0xb50
> > [   45.379511] Modules linked in:
> > [   45.379868] CPU: 0 PID: 463 Comm: repro Not tainted 6.1.0-rc5-094226ad94f4 #1
> > [   45.380617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   45.381752] RIP: 0010:notify_change+0x9a1/0xb50
> > [   45.382234] Code: 44 89 f6 e8 81 2d cf ff 41 83 fe ff 74 0c c7 45 c4 00 00 00 00 e9 e1 fd ff ff 41 be b5 ff ff ff e9 ea fb ff ff e8 ef 2b cf ff <0f> 0b e9 c2 4
> > [   45.384114] RSP: 0018:ffffc90000ef3b30 EFLAGS: 00010246
> > [   45.384661] RAX: 0000000000000000 RBX: 0000000000004200 RCX: ffffffff8155b451
> > [   45.385389] RDX: 0000000000000000 RSI: ffff88800cd40000 RDI: 0000000000000002
> > [   45.386112] RBP: ffffc90000ef3b90 R08: ffff888009ed2f50 R09: 0101010101010101
> > [   45.386840] R10: ffffc90000ef3bb0 R11: 0000000000005c67 R12: ffffc90000ef3bb8
> > [   45.387568] R13: ffff88800af5ed80 R14: 0000000000000000 R15: ffffffff8385ff40
> > [   45.388312] FS:  00007f914d059700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > [   45.389142] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   45.389727] CR2: 0000000020006000 CR3: 000000000bfc0006 CR4: 0000000000770ef0
> > [   45.390458] PKRU: 55555554
> > [   45.390752] Call Trace:
> > [   45.391015]  <TASK>
> > [   45.391253]  ? write_comp_data+0x2f/0x90
> > [   45.391697]  __file_remove_privs+0x1de/0x240
> > [   45.392181]  ? __file_remove_privs+0x1de/0x240
> > [   45.392671]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   45.393181]  ? current_time+0x64/0xb0
> > [   45.393592]  file_modified_flags+0x51/0x160
> > [   45.394055]  file_modified+0x20/0x30
> > [   45.394462]  fuse_file_fallocate+0x53a/0x620
> > [   45.394928]  ? __schedule+0x2e6/0x8f0
> > [   45.395347]  ? fuse_copy_file_range+0xc0/0xc0
> > [   45.395835]  vfs_fallocate+0x336/0x690
> > [   45.396243]  ioctl_preallocate+0xdf/0x110
> > [   45.396677]  do_vfs_ioctl+0xaf9/0xc20
> > [   45.397080]  ? __fget_light+0xb0/0x220
> > [   45.397488]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   45.397993]  ? write_comp_data+0x2f/0x90
> > [   45.398419]  __x64_sys_ioctl+0xca/0x160
> > [   45.398836]  do_syscall_64+0x3b/0x90
> > [   45.399235]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [   45.399788] RIP: 0033:0x7f914d17f59d
> > [   45.400182] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> > [   45.402039] RSP: 002b:00007f914d058b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > [   45.402815] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f914d17f59d
> > [   45.403543] RDX: 00000000200001c0 RSI: 0000000040305828 RDI: 0000000000000004
> > [   45.404286] RBP: 00007f914d058e00 R08: 0000000100000001 R09: 0000000000000000
> > [   45.405023] R10: 0000000100000001 R11: 0000000000000246 R12: 00007fff22e7ec4e
> > [   45.405758] R13: 00007fff22e7ec4f R14: 00007fff22e7ece0 R15: 00007f914d059700
> > [   45.406496]  </TASK>
> > [   45.406736] ---[ end trace 0000000000000000 ]---
> >
> > Bisected and found the first bad commit:
> > 4a6f278d4827b59ba26ceae0ff4529ee826aa258
> > "fuse: add file_modified() to fallocate"
> >
> > After only revert this commit, this issue was gone.
> >
> > Kconfig, reproduced code from syzkaller, bisect info is in attached.
> >
> > All detailed info is in link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/221117_083125_notify_change
> >
> > If you find this info is useful, please add the "Reviewed-by" tag from me.
> 
> Thanks for the report, fix now sent out.
  Great, I'm so glad that it's helpful and there is fixed patch for this
  issue! :)

  Thanks!
  BR.

> 
> Miklos
> 
