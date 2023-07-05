Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32D7482FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGELgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGELgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:36:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8DCE3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688557009; x=1720093009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TlYNJLbl8oTUwI/+Z8iLM0mexVn0nWr8Hw7vwCnIpiQ=;
  b=RBs0IqxY+/Y0gsyiS/ilk1uCH7L1gALRPrjj7jWcLmNxaxRh500nOXpN
   8Bw8pBHpcJjMhxp6S/N2XeczkSD/p6r76pSSjUNZoL0pfSgQgUzka70Ap
   X097nKDTt/PJnBE54rrUl0+uAgHukJOuBG6I5jRR/dTZHu+Bd0Zxa5CgG
   Pajpl63F6uCGkGlVxRCAEk+b0s57Y13v+cUBFSHiMiZcGQiTWOTgkGGVU
   CymIE30tNzm1aN0KRTFJ8T1t+9C6NIT7tQ/5SRRPCd6p84WANwyhGIHVv
   2lIdSITV6zF2nH3xK+/UceBj1guA2A9bWxN8DcNwJ8mI+knsITAv4jPr9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="429352366"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="429352366"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 04:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="748697260"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="748697260"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2023 04:36:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 04:36:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 04:36:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 04:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9uC8zBSEkCYgzJ4ZgU7oiTcJUxzGorhSAg7B42exwhHaq/uPJvakeP3lAgM867F0WESGn4dy+LOF13bi1Saqlfu4Dy3Km6AgfSo+5PjKZKCtAbAqofywDcfHWa8tTLKPa51CRYo1rtgTOustkAqABWFbvhgjq32FZ/jWjVYJcmDVCF1ldB+D3ghXPGKXZt1aCwNp27D10OJfilOvj8HGRxoSwJpuZjnqvPoAdauAyztfz5KWfyQa8RBUfk8IMSXwGPthWbeikawRXf+wavJTDYPea/Vl3v0D9hsim4ooPpjDuHkpN1vJBvmsD0MVwiHid+4COhKGZo06TRvx1OEMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/g8oRqK1cSaNWeXjZV7LL4yo9t5TbQnUQLG+4RJ4Gg=;
 b=gA2QwjEIOdiO7F0kpr4xUHf2bRg/+08FONxEa0DmTy7vJ43hlEUsy4/pwYwoQRjsSfYHjZclj6YYQGZctimryYFnyeJLRkM6bIhkDjhvv52zmA37s3tltei94sf7vezskabIN78Nc2iroLtrR3YO/UEoIAt9hD0rUZNw56VPv+CGimgAhkGjDS39lIcvA4eFg2Z2IaBibPou8P8USDSA8KswSmrkELYjQlS1qM36iisVzrOAOzBVQalDIPJr746bxpcczyErAJrLie9AoWaAuMe4bOfiy5x+rLZHc06nU8R0qMLZRTVF82afhH8i7m5BFViOzPrTjTum93xctjQvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 11:36:46 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34ea:3910:8a1a:6a8e]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34ea:3910:8a1a:6a8e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:36:46 +0000
Date:   Wed, 5 Jul 2023 19:38:52 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     <nogikh@google.com>, <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>, <syzkaller@googlegroups.com>,
        <keescook@google.com>, Mehta Sohil <sohil.mehta@intel.com>,
        <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] x86/kernel: Increase kcov coverage under
 arch/x86/kernel folder
Message-ID: <ZKVWTL9fMQ++oQJ0@xpf.sh.intel.com>
References: <cover.1688460800.git.pengfei.xu@intel.com>
 <582ab7050597df7a996c11df048f168995b30747.1688460800.git.pengfei.xu@intel.com>
 <CACT4Y+aBNX9U7yeH8jz5y82tV46iChCFXufg92gSXrdRubqJsw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+aBNX9U7yeH8jz5y82tV46iChCFXufg92gSXrdRubqJsw@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea26ade-ab71-442e-fa54-08db7d4c1d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLprcMi5IJjYPKmrfKbE7SxChgo9TBa640tJfNtJJt5q7C91OBCjvKhEn10lxMb8EgY9LwmuLCH/+vb/IrU56vypIhXh/Doytea9Vk57somX37TRcSF+fI/4ttDOOKJO7FFZIsRdBZ7BkGMzDIasFKIWiPE9bOkw2QGFZ1s7Oa3UpGutFyyWc9DKS3AJLjtsWTFFyyF994J6VNlS2TX75fjB4Lxd9GdGVWE3rQRK1kysLkzMp23OdMdtj4GoVOs/NVbW8DQymYxWMT5KYrOTZjONe7OERCTcD11BZDDYuskmVRrdGnC1Gv5SJGqxbP9Qsub+nMmp3QJbs9o/S5YUWLG0z5tPVjpaHDVHYxZRhu1scW3bUvlIMqbJnbkaCj8RXbsd9ejFks+kkhZqwumT+JhZdxydGIt0Hq44fhvabMGBCp5Mi9wfjq4R7KbhCS7TIcTAjS7Kfyu3tUJ9X+3b897KOKM8+/8T0Ez6MZyovmT7qvBPXZsLpfj2ydyiewwPqMYnbwBDeTZhmHy5MUzW8VJgd60MvmcG5EcAoWZ47nE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(4326008)(316002)(86362001)(6916009)(186003)(66556008)(66946007)(26005)(66476007)(6512007)(6506007)(53546011)(82960400001)(83380400001)(966005)(2906002)(6486002)(38100700002)(6666004)(5660300002)(44832011)(478600001)(8676002)(54906003)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ReIYkEBc4jHp6Ch6wBLsqkO3qz8u/LL2lqOZaN1uJ1vV9ez95hvTNTPpEdFp?=
 =?us-ascii?Q?8cV6eL1Nb9enItLQMLAD5R0xTCQtw7G/vv1XJgFjcpmeWZYVVt+biE47+ooR?=
 =?us-ascii?Q?HncPDjQlxVZDjojtPDXV1CXnD+7XTjQKUa/+PVjS4kQzrxriCl5Pw3/s5rWl?=
 =?us-ascii?Q?8+0BnGUJT4H0LoJqTaAHXNGognPy9V9wVCUb3gRsPHzhNJkKYDwBkfU3QoJa?=
 =?us-ascii?Q?9BtFRkY5w9b8fFSVoFfWUKF6tXMpDAPnIIHs05OsB1PDYDY7me280/orffFi?=
 =?us-ascii?Q?6Yz8ZbfmdIdFdjhSUVRr+1cFl9v4w09TF8+Ho59yp2cGwCKfTaxhLuGxYmPs?=
 =?us-ascii?Q?0DmyLJjRrzLPCaRXy+n0ocWfsQVENo8EwmI7EIZpVkgo3oeBAK4fzLlslesZ?=
 =?us-ascii?Q?c9eFhrCRNCiEPuEmblZgwvQ0LXUjvESJBV6PSjXw988DBhkb/6VBtLiy8f0s?=
 =?us-ascii?Q?6L4Pofe5U9qszcrko3OG+Cbdqb/jd2xSAY6RhsfUJlx0VBS1LRXubki1MC1K?=
 =?us-ascii?Q?rsi5xCeeX/XORZeLY4grZsAxvzFb0h1/GLuUO10oM4eAWm0cTRX6UAMPHDbK?=
 =?us-ascii?Q?k8J1ZamzRT5Ri15ffH+Zfv9dhNQSmHjzXWt8ymmgfjOD2kvCtqevJB8z9oNK?=
 =?us-ascii?Q?A1vhzDEDAOcaHjhI3On9W8BgBO73Nq+a55z+boBZFSPMP6PpUaih823CmPwl?=
 =?us-ascii?Q?Cdoz+dwmLcu6oF7r+Jg85IGNcpr43bBFxabwmqg/C7LHrMTwam6TR/AsV4eu?=
 =?us-ascii?Q?7AfSaSkoVa68GllMvRkIzp6Uea+gviRe+ePrUHuH//VH6anjeq3viI9PxTrD?=
 =?us-ascii?Q?WRLGrsm0w50ZvN4qYWG38M8YlJjkk9c+GQEN1gYF4RgDaTBDvNEZuJad5gcE?=
 =?us-ascii?Q?jAC9IjJ9e4oQ4g6EOHtA9nLiWT2uHXgnSNq4OBCziGK+1omsBBGBf02QCcur?=
 =?us-ascii?Q?87kDDFQ5gnncxZPqfuOHJS3CChAdq9GwUV5c+3KWFOh+ffuywAyREHcT4fuD?=
 =?us-ascii?Q?DUgaq3mSEdJQV7FwuqtDRwHcQ+czSrTMdAxGlM02eiLebetzNycoQtkwL3Jt?=
 =?us-ascii?Q?OVENazX9OIueL3uZavizT9NsM8F/zCiVss7qHKaX/jNcS1387g7pYhEYfaES?=
 =?us-ascii?Q?XFqbqt9gu6JU2Kgwg0RFDm1oDsA6LqpUZQOhQ5Vh+9nDqiYPW369BNJ07c+8?=
 =?us-ascii?Q?guDbgvfX7sIufvUcJycwJu4sKsCL6RdjNqDaYX0zTshjoy3VGzbyxtbsH5cm?=
 =?us-ascii?Q?cNR3Tau9XsWMFO/fTXyuHdcrQV8a3w+Z9oNIGEsvEiYXfrg7jd6Q+IeIIAEl?=
 =?us-ascii?Q?NbacSz+QpM80Su6QBVKwt0thFx8MUsEmO/rljPq7qiXSiQMbFY89VEFDnt6l?=
 =?us-ascii?Q?pilsVTv9pK5LFMaVhPCAlKTSqNObgMBWL3CLG0CW9IbOxWP/DaMvxg16E9st?=
 =?us-ascii?Q?Uu1Vh0jlTR2cQf4DVWkJHM1ZwHbaHIw2/5e+rj0+2n7odoL5ZsMOepgs4Ub2?=
 =?us-ascii?Q?GbF5Ux8dZ/dQicixnUff8TfiTmRTf9SCR3VxuqvR5BuFPPYW7RLKVHdSoQJw?=
 =?us-ascii?Q?XZOgR9P3GPSWyMdLiEh8hW9ThSjRcaPeZ52SIyN/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea26ade-ab71-442e-fa54-08db7d4c1d17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 11:36:46.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvE0xVeVy+9bICLlT6xL7ZH3DhUiE8JKEDSABDWgpUrhLU2sB+5ednUkUyVDUc3L1S3Y+QZFhi5GHC9Abeghtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
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

Hi Dmitry,

On 2023-07-05 at 06:28:10 +0200, Dmitry Vyukov wrote:
> On Tue, 4 Jul 2023 at 10:58, Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Currently kcov instrument is disabled for object files under arch/x86/kernel
> > folder.
> > For object files under arch/x86/kernel, actually just disabling the kcov
> > instrument of files:"head32.o or head64.o and sev.o" could achieve
> > successful booting and provide kcov coverage for object files that do not
> > disable kcov instrument.
> > The additional kcov coverage collected from arch/x86/kernel folder helps
> > kernel fuzzing efforts to find bugs.
> >
> > Link to related improvement discussion is below:
> > https://groups.google.com/g/syzkaller/c/Dsl-RYGCqs8/m/x-tfpTyFBAAJ
> > Related ticket is as follow:
> > https://bugzilla.kernel.org/show_bug.cgi?id=198443
> >
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> 
> Reviewed-and-tested-by: Dmitry Vyukov <dvyukov@google.com>
> 
> I've run a local syzkaller instance with this and I don't see any
> additional kernel bugs caused by this and I see coverage in
> arch/x86/kernel/* now, in particular, dumpstack.c, perf_regs.c,
> signal.c.

Thanks for your tag! Yes, it can cover more code in arch/x86/kernel/.

Best Regards,
Thanks!

> 
> 
> > ---
> >  arch/x86/kernel/Makefile | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 4070a01c11b7..00df34c263cc 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -33,11 +33,10 @@ KCSAN_SANITIZE := n
> >  KMSAN_SANITIZE_head$(BITS).o                           := n
> >  KMSAN_SANITIZE_nmi.o                                   := n
> >
> > -# If instrumentation of this dir is enabled, boot hangs during first second.
> > -# Probably could be more selective here, but note that files related to irqs,
> > -# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
> > -# non-deterministic coverage.
> > -KCOV_INSTRUMENT                := n
> > +# If instrumentation of the following files is enabled, boot hangs during
> > +# first second.
> > +KCOV_INSTRUMENT_head$(BITS).o                          := n
> > +KCOV_INSTRUMENT_sev.o                                  := n
> >
> >  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
> >
> > --
> > 2.31.1
> >
