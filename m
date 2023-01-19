Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EFF672EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjASCWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASCWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:22:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5767952
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674094925; x=1705630925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kwKBokdAkN7ZRIOpVrwW9mhVt4oesfOSTT9T1Fv+hBo=;
  b=JmLiIRuhi2FNRSbLbVEW9gRLraF9FTKzHZeGPZmhacTQlfWqNgEvSFNA
   iGLR+fxk/5kv+Ijusud/nQIZnevPtNAUjRGQxtV3LTObY1KDy0eF0CGyB
   sroej9ccUxeEzV8xDuzlZis35qP5iOpBi37sfqHQi0clLnjS1/3JWyHtJ
   82ft1vecJaQesEksY3g72GWbjF9wkIQRWx1XsWdBiCs6aCzYV1XeBggBY
   4F7/i2Lw4itp5tutBh9S8qA4YX+/mpN0iqc1Y6yXutED3rXnK+78GBjIV
   pcEjrGfF2lSXweP7y9q7bd+eTb9m9drzmxNoAZAeIwIarKv0WAkT0XgD5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="305544960"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="305544960"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 18:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="637509536"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="637509536"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2023 18:22:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 18:22:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 18:22:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 18:22:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3AEHjLyQA+hlVUA/G6Yz/HFYTHhQDWy+qRalRQ3yMVANzGJCB9GZaDMkl+rcM7EVCJFFBISVuqFzX0+hmBevDLYe5CrsEb35HGYUTIsjIfU0zd+Q3qSa4fGHzbmXOdrHOc4McjiHDBmmTHIRB+nLt6oL9dilrHdhfnrHmUtkHvkTZTrzDQkDM3HbU5RSAbmcpd8fPTj1K7DJk9HNGfKWbYhBxZTxINt8PRUAc4o/A4aUhGk6H+OEy2K7gE1RyDkgUADFYr/Usi7ah39vmhIIcrrfd2hiaBrrHA1I9J/ttTzlezlK7ObVqk5o5jFCCOkC4XppCpQ2lro8bh3pMqDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1b3LBZuvO4eoe4mXveo+WFacaCysQsonbnAdilblAk=;
 b=J6mn9y7DwUEJd8FkwqsJ7QTnNdYISjuUc+XwaxjnH0eFA3m/KOlY1EHx5jcAY5WGP37alzdA1LoKw2IUl6amHxcfjMCHqlSvpfd0ObMNMr7vDDiAPsCs0gsS7Mspbapy7jPWB9v+KhaFH/FPMDBMCXlexLV9FPWUlZNedxFKTjiwPanjrManoNLX+Vnl3MAnsRuET3rnta0FD1OjlX02z3Q7PJayfJyMVZpqFBl+yQDazEB/SyXe8C2JIQeVm7hxNLdoIksY3YuJrF1AQ7wYNBKfxKdS7K/YAr+5m9F3HfrXSDmhDQYdi+ML9Q9sUy1PeoPcPEcQ/8wen1Edwa1omQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 02:21:58 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 02:21:58 +0000
Date:   Thu, 19 Jan 2023 10:19:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, <hongjiu.lu@intel.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8ioo5EWrMCDkoU5@feng-clx>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx>
 <Y8aSc5xGO+rW2pyo@feng-clx>
 <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
 <Y8f0miUc//BQXN3A@feng-clx>
 <CAHk-=wh0pdJm6tS4-ywR3Zi70PnBjMXeCkuQKnu8utcSKjxNEw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0pdJm6tS4-ywR3Zi70PnBjMXeCkuQKnu8utcSKjxNEw@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA0PR11MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0eb40a-30f9-46ff-4d85-08daf9c3f106
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xyp9s4Ia6TFybfun6pNmlj3lp+7Effn5z/OZmuZqWiY+bM0eiF5yyemQAF4T5udCC1Lc3tuuNuBpL64ktU+jiIH0jfZVca23Odaa4X7ZFWoSrZ6YWXdh55AzJIISw7Vd8ybmsO2AUnKtieULokFv4POSmu38K6pJLxe6pMWPIfvghA+1F1otL6v7X9zN1pXStSc7/7SM1dYJsHeBHrSp+y10we20a/00SxcZ59fVgyCVXMkC9GUbf+Fkr4A9azWjeyKFJqc5yTERfk5AZD4HKjRu6b61XENjKvqRtXUtHklpmwICJuWNKEU3JZ1joDlsiooxD9YI2jLYZp7jDItPgc5S13TGcHE74Fdj1VIvG0nFuXvXAeV6wnvegzjHU7zu6PcMxd9YF6/DyGQYrmaXttv3hKQFUfctalqlXJziKG4aqq5BZNntph84kmj3gJXPyXBxpVin9BmvfXAm8UhY8prYYzvJasaHALOPbphH9qBpJufB95dfIGzj6q7Y+cktk9BPIYmi2DwAaqlwCJ6/Iko5l7+0f6PM3dJZMsO8cDEZVvsrmgo6J0TAUnN/O4bPN2x98QKIjrt8zc3bid2BOEw/6hMm4dU1nEdLV0CC0sN4JPsSM30aqjUmeBVL4/NkqYD26X4rj27afSqzuhVa4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(66899015)(86362001)(66476007)(44832011)(2906002)(7416002)(66946007)(66556008)(8936002)(5660300002)(82960400001)(38100700002)(6666004)(316002)(107886003)(54906003)(53546011)(6486002)(6506007)(478600001)(33716001)(6916009)(8676002)(4326008)(41300700001)(186003)(83380400001)(9686003)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D1H6IYSev9MY8PZf21Wh+5mxcpEti1DIaACEbRsjKjSVOkEQgvTldR7sP9Ez?=
 =?us-ascii?Q?fI1N+8VMQOjkuOa3cJ38d2x4Sw/H17t/AK2Ry/mCU+NcsXSlE/gLiGbGU5Vg?=
 =?us-ascii?Q?jhr4M6J01JRX+crKLQM3f2J375b2NubTSWpYJa3jsNC7PJStt5/o4NL7TNO7?=
 =?us-ascii?Q?ZRGqH6rTzIcDUMVqVv2r2g5X1X2VZ/DKeML2baRibqXeifGTjWCrcfL2YYIs?=
 =?us-ascii?Q?rMw8Ltuq+/qsaNZCLAtKaoD/SkwgvrIdmehNwINiJGyeFLXspuVQzTlROg29?=
 =?us-ascii?Q?H8afUNbeMX5auu0gGWFBUWiK+Ua2Ege5BlFxI2Vp0g+wDVow4RGpKdl6WG7+?=
 =?us-ascii?Q?V9MGXwfRXU0uItJudcxMTMTYFXx3CfLbawKKrHhDRUi68ypcRQ7ZzlNrzXmT?=
 =?us-ascii?Q?pxkjTnAksalkag2/JEznFBZPXor45fupBkDJ7Y0lHA/TOwZlrRptAGTFLXff?=
 =?us-ascii?Q?xiA7WQmje7e4JHKn45uROLMSstqUeaw8VJLaI1ijXGKx+ecjQMw1Y9riGokw?=
 =?us-ascii?Q?DCBKMOkElRF+Iayr9ZTMOkNOQppbJ6xPwixAL+J+Pt5gxJX43qGMxOcx99jF?=
 =?us-ascii?Q?nL9EbMwgBu8m2qgTznZLSvveJh+cKASRCPW4NrArZxz7gSpoLqm3J39MnA4C?=
 =?us-ascii?Q?s2LFMPQakjawYcVbFU3o8Q4svR+RD/dIv5SVrRJNGzHjK6aZPj4yDHEluN9q?=
 =?us-ascii?Q?swEZV9MqdwIit6GIfGU5GTi30aYipFecPEWU4hvHHm2P3Nq1ap6UZCEtP3nz?=
 =?us-ascii?Q?WHBa6QorVg6zmYNhLhP2b+mEvgNbNBsn+o7BDbeXkXN1VsnfNXBx0PBnebuf?=
 =?us-ascii?Q?hxB/DluzQ9XuaT4zJVu1kKmscNdkkF0au7uJWxL7TDZUjTV4Ewsmd/0xD55K?=
 =?us-ascii?Q?gw7KuyPNuKPTO9BhxYuEp7z1n5FkX71Y5GZ2MEttJt1+ZjvQwVdcX0xNEmdT?=
 =?us-ascii?Q?7vRUSRGxzn39MpSa7m2eSfsCqf2cDEKBb2wmmYIQnrDPlqwoRlK+bZMEoYZj?=
 =?us-ascii?Q?MeZGQGvhOEVx+2ubmiSMdaaMk6GJWguBHYrUSdrXXzgk4X+iePthVkefmibb?=
 =?us-ascii?Q?F7e3cw1SdFKmpKFqfhHidfYWYAkdCFzAXjsGupxB2EkG4uCONu5c2U9d4bcc?=
 =?us-ascii?Q?pu6s6pBInNNA8STdrm5JBXQHdpiTU/QP2ngcaDR1LZdrTN4mL/tkG7bgTn56?=
 =?us-ascii?Q?6FB8dPxJqP7/kNRvBU6ZNgIjYLALjWzPidAd2AyudV+B7ajIQw0ajNW1YoQG?=
 =?us-ascii?Q?AW1YdjspXje8Aw+ZbKUqMUlEiIJn5zeLz9r/XoKCI5vShdxjmV6gEaFO2I/E?=
 =?us-ascii?Q?qWCKiI6ml31pPcyYkO+/usQ/NpD4RuCNpS6XQAQ82KFQ4hbeDvVh7Tt+esMd?=
 =?us-ascii?Q?b4N7NxE69Q5JiApaQauz9FpfHumCBP6iatxTC7eaw0ompwwI+D4lopEM7QqG?=
 =?us-ascii?Q?Ymen0J4muWEk2WJqqv3wn99t3PULjcmlt8GIYzaxiqhjxNTOQKmEPoqTbPJq?=
 =?us-ascii?Q?fyXeQ3vrKmnZVXygxg+Kee9i5wMxsgxITI1BejrUQOP8B5yr/8EWPbuEnUwd?=
 =?us-ascii?Q?OrNlDTnAgsEgM3u9z27HusSpC4NzEWNLA81ehFiF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0eb40a-30f9-46ff-4d85-08daf9c3f106
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 02:21:58.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90WrXsoCMLfFlkH2/dy/vjNaP+12ukIU/0A1857dbnLPX3aUZPwpGBHHulSi8+xy+7+ZtI8r39ybrgiIfsFsYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:10:45AM -0800, Linus Torvalds wrote:
> On Wed, Jan 18, 2023 at 5:33 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > > Finally, your objdump version also does some horrendous decoding, like
> > >
> > >   c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
> >
> > I know little about these tools, and I tried objdump tool from
> > Cent OS 9 (objdump version 2.35.2) and Ubuntu 22.04 (objdump version
> > 2.38), they both dumped similar assembly. Please let me know if you
> > want us to try other version of objdump.
> 
> It's fine - it just makes things even less legible than they already were.
> 
> I personally very seldom try to look at objdump output - I tend to do
> things like
> 
>      make mm/page_alloc.s
> 
> and look at the compiler-generated assembly instead. That ends up
> generally being a lot more legible for various reasons, not the least
> of which is the variable name commentary that the compiler also
> outputs.
 
Just tried this, the generated assembly is much more readable, thanks
for the tip!

> So objdump is kind of a last resort, and then you just have to deal
> with the fact that its output format is very nasty.
> 
> > We modify the kconfig to disable GCOV and UBSAN, and the issue can't
> > be reproudced in 1000 runs.
> 
> Ok, it does seem like this is a compiler bug, as per Vlastimil's decoding.

Yes.

> And the reason it happens on 32-bit is probably that we just have much
> fewer registers available there, and the 64-bit GCOV counts then
> complicate things even more, and then some interaction between that
> and UBSAN just generates crazy code.

I guess the O1/O2 difference is also the 'fewer registers' case, that
O1 make many functions not inlined into prep_compound_page() and
needs less registers.

> And it probably has very little compiler test coverage in real life anyway.
> 
> From Vlastimil's decode, it does look like gcc has mixed up the
> "update GCOV counts" with actual real values for "nr_pages", and is
> using %eax for both things because of some register allocation
> mistake.
> 
> So I think we can dismiss this one as a compiler bug. It might be good
> to see if it happens with a newer version of gcc too, and even perhaps
> post a gcc bugzilla entry, but since this probably isn't really a very
> interesting config for real life, I'm not sure how interested people
> are going to be.

I tried to file a gcc bug, but was stuck in creating account phase,
will follow up.

I don't know if it makes sense to make GCOV_KERNEL option depend on
!X86_32 for now, till the problem is solved. Or we can ask 0Day to
disable GCOV for i386 build, assuming GCOV+i386 is not a common
usage model.

Thanks,
Feng

>                 Linus
> 
