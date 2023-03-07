Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4836AEA51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCGRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjCGRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:32:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B01FC3;
        Tue,  7 Mar 2023 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678210074; x=1709746074;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F+kiXoJHzeZlyS9gPh17uX+iIoefCajEc+1hrOBIyhI=;
  b=I+zsOoh/Yt8J2uIaydXrcuYs5/WG1VxEXgZVmCkEPsni1RTh9JM/ysEE
   mbhbL+Nunnlbuqs2U0FzWy6t4xag56icit73nCTbZkW1A7b2E663fcPi+
   n8Ly6sg9bWWqGwugfFp1edvwMP/CwBR0nluLInyUGRW5o7krPCKZfEVlk
   o1B6ZTgUH3QhWQnQ/ze8+HwHPxq1rR5zd6bWIy/Upij8vRf2BMHD5nvMC
   USBEZr7HqhJMNrfGWDPfoHvQUonkz8bIv+BRgDziyzb15MdaF0UxanQAS
   Sr5tb2YULqYfEgcoqkwtgxlyP3qLjFuH4KEWsH+JifQCD7XgpXnxk2LOI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="315573020"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="315573020"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="654046230"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="654046230"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 09:27:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 09:27:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 09:27:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 09:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3V9M6QHTSqqtF1Eo3PVGcBO8nzpEgJzToMPrLdhG98NUE7wRHxmvxrthWc4NfHA184gBgD0Eay/TwAoZRnSxVMO8v7PTjYFjk18lOcnI3k1b1cf+eOYZuGI9Rr4Oxc5njlNQpbw3pA+ARAwmpFKBV5VLovPtusSfL/FVVyLUx5t6MVSb2PMbjU0l+z/WmilvxaLIdmG21ym6TveCZbTBJpm0ZxFI5x3HSg9C+eGhmIxa2L4GbTrd9BDUDDmG5mSYiRI9mTqp2oqGYDkbEUGKQx1J3kyq7AfmwEIopaHoAfoU0nMM6MQWbW/XGzEsteJa7I9Fj4JRVx1P4+h1JN+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ+mnmXNrrZaVF8HX86BlOFmJTHvUjAp9LXDx+Mkrmc=;
 b=g4GzLtJn/wRKH9jbkHUP6rBirFmdhtKzoFFmr5r8kkCLIo44FF2vqblqvzxmbHIeK6Lf0vQR3DFXp9kuSiqXps15867/7SlgKhpvndn6/DoCzEgPp2gHGCyXgylDSgd2tO57KnDxh4Ou+VkR01gO/+eDtXp4vj/Kalgmu+goDNE4iflX25vHzYiumcrvHHRIFulcJxgRB6cwBXZJBOnGGtk4nLlKHz8S3UDNIDbM+KLZ+KmyknnycYmocnXHIgOI0VuevK5DAXM49HzgMCCZxC1sMXVejKFlSEwWovQi5uEvb1KcbJ4n2oEPlL64bE0YMnSmdmNI5KTvqQ1n7t+85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 17:27:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 17:27:47 +0000
Date:   Tue, 7 Mar 2023 09:27:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <6407740ff0ce_a37b8294a3@iweiny-mobl.notmuch>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
 <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
 <20230302062305.GA1444578@bgt-140510-bm03>
 <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
 <20230303143605.0000159a@Huawei.com>
 <20230303172054.GA1478149@bgt-140510-bm03>
 <20230306160422.00003633@Huawei.com>
 <20230307111200.0000419c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230307111200.0000419c@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: ec935d9f-8c2f-431c-23cf-08db1f3144b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQdfZt+15QNj30AxFYQVWi4ovTRI57is0Q4DuN1xCDd8XcnGkk71qNvwgD74mPYD1LbimabNAaKfSIqvtfYrHuBy1P3jYry0PmQGwZSvsi4hNveiC1kGGBzmhoyUXUyWfETepofEqcNGScPYMIq6TIakKcajSX8gjoYzEoJKJ4CUWMF0lPeaop+Tg9ETYhIYwXG3vtgUJmQzS9sXykSaW+v3ukf54SyPZOu204dkrEmgSe8W1HiItDPLNAWKgjKkRMFZAZhAzDU1GW+GYkyPWTh4MCPYUVi1fQ86Z8DxO937+q5NUFx3dPGMDo/Szx5efMss1vO9dyCo6w34TmrYIG4IyA/pqZRn36ELR+eb1tGLjRdoEUqyxJHUOPHn2u+jZTyp6FD0YkGde10z5pBxhV321476Bo5v5XDwzhaOp38pjtWCsrbO0foXt1/3/3d62euscGuqW6jMIvv9JytzJB1LO7bHBASTM37oWkqmVoAjgBhmoUSQ6D7/P/+fnHgTz7ygLODr+nGQlClOQr8ZUtv4AGzRYFun68YiqqoqZ5qkl7HhViUuyx7fN93dYNWkz28OXB5Nt5+2bAHc7Rv0knm3FGpI6qxqd2tSaJq1jRMnwqRSg4XAx2NlfeFRccqA5T1Dhz8Lqrm7Bp3Y60m7ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(44832011)(5660300002)(2906002)(8936002)(41300700001)(8676002)(66946007)(83380400001)(66556008)(54906003)(316002)(53546011)(6666004)(110136005)(478600001)(6486002)(4326008)(66476007)(6506007)(9686003)(86362001)(186003)(6512007)(38100700002)(26005)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lR0iFzHnYjHk9BcZX0U83tX9QFMTBUq9JKrdEEWNzEHjVeomzog13eaXTi/8?=
 =?us-ascii?Q?pvvKXrhMbq4IVJiSRBWR2kY/29fb82CyPi0+JrPQIERoreWBn2xR8ojoBPVW?=
 =?us-ascii?Q?qXsbkSWLFxDnGaPo4SJKVx2cXh+Z4gSIKkinGZZwfqOQBh/O6LtLqyCFlCVK?=
 =?us-ascii?Q?wQHRemOMmsdsPMYwKuy2KlsoIRu9nyCULk7sMa48aVuNckvlsDpqnQhNGMX7?=
 =?us-ascii?Q?dXwI0tRPbv+E7N+3eRwDp5nnw0/Fm3mCW6WtFLigYuIO8yos3ZOhUTr0PMJy?=
 =?us-ascii?Q?cWYqag+4EjbPrSryHkHp5eAaaPj4rOg4Q3DSz94vCB67ncRDrETm74n4EuoR?=
 =?us-ascii?Q?YCdkJcwbZ9ozOI/w2lzZONEs2Do3PTEnH0hJT/N2S+jWE+kdihgSS5hIhrvE?=
 =?us-ascii?Q?uwDfIcxgrui4myKENDHeSbSdXrFwBGdkFvukkJaVlcJpprGuHKibOykGtYJq?=
 =?us-ascii?Q?BXaRRZgQzQqWQBOMwF/de7TyW+rGkXQqp3NKUBy6frenvR00LlMEQU+SfONv?=
 =?us-ascii?Q?3N6WjDl2zgEd1yaCEqYLQ664Byy9YJxlGIgAhWnzJlZ9D5ssvFrVCuaD0hI1?=
 =?us-ascii?Q?3Hh5IL51+4anbrYALEW58zF1goW7JMeMnwQb1dr4VD0oDBrmzZ15JQKkxe0P?=
 =?us-ascii?Q?lxD5KJlaaEwCA8ZRx6i8HRz/W9uLHtERMDe220Wv2Nz9VaIin5KLT7A/nULP?=
 =?us-ascii?Q?t3u3o0/S98XzfZLMerjrZvU5D/eaiuPCG7Rftq4+yhdQ1HTvCT/fN3KJohNq?=
 =?us-ascii?Q?fwpSwP1UQqzaybj243YFmN0IdBd+imlWHFCdFmnC8uwVV01tKXlZqRSzz+HZ?=
 =?us-ascii?Q?bE6UfAvyorK5t5F/3VReltbI8wo8vE0PbmsEGfU1FXxBoCditZ0W1osvtWdM?=
 =?us-ascii?Q?xfyK0Tga4zhqpYVfHTQFnzYBc/WUambBFRtWRpCYBB/vRLao4Jryg6U7ULVB?=
 =?us-ascii?Q?7IAQlNPb7K+XBuYVepL8Orkz+SVDDbANesg/ORYIhDaqAZNq3B/EO+mOLitk?=
 =?us-ascii?Q?Z1VcZ8kkXWdYHEDJgM+NXLfbPZMGbQJfTIdX5ht335rkwR8knkrXeD6Wft6W?=
 =?us-ascii?Q?PM5HXManyQiNHe2ZwJF2mxF9N/09D+Rbto/cLmjBr3KTzu78Qp5nCmT3itm9?=
 =?us-ascii?Q?P2r/XxkQ6tn8hE3Yjs18RmO/gKRaQEDISVNRsL4oab4EJk8OzjZncL/WteoL?=
 =?us-ascii?Q?QpeQuEIVltMyioOzOjo6MFm/mR2X44NH9NaSXvvah/s5vhHbBYeH/MUxXN+1?=
 =?us-ascii?Q?YET44n+WmRJTMozdyYPeGjub+f+KSC6+jAWDVNeCRPvdadEqbL8ITiHvRGT0?=
 =?us-ascii?Q?4Vgo0mPJp1LiqY9eeKFdHeX8vWoUMjWpUaNdrUiPvLHob4KZBF3aIxSkeL9X?=
 =?us-ascii?Q?+bm432VWqneu/HpKyhywI7zpCosIhSW7RsToLh2RkLCbD9KE8GIc+KwcZbl2?=
 =?us-ascii?Q?mWm1JaQqZHns7vWIJRTeR/2rhEAqx00TCfs9cjTlwd1K6+H7cvcw0SFLLMK4?=
 =?us-ascii?Q?8mMgR+DScrxb//IfJ2LLS8vy3GMeZs8MPyVsnBhKoprcfoVJe0w/kTaArfPr?=
 =?us-ascii?Q?dQqFXXesjgDPtesWjWSLaaJV0sJwS6asZgZuSDnC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec935d9f-8c2f-431c-23cf-08db1f3144b4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 17:27:47.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO5f8sSUPoO31dLk8K9DKvNN4Bg6fZGLDQMqKKPlueb3A0FuPnghto0GbaNGgzgjcLXtZapFls4N5BoppsyEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 6 Mar 2023 16:04:22 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Fri, 3 Mar 2023 17:21:13 +0000
> > Fan Ni <fan.ni@samsung.com> wrote:
> > 
> > > On Fri, Mar 03, 2023 at 02:36:05PM +0000, Jonathan Cameron wrote:
> > >   
> > > > On Thu, 2 Mar 2023 08:36:59 -0700
> > > > Dave Jiang <dave.jiang@intel.com> wrote:
> > > >     
> > > > > On 3/1/23 11:23 PM, Fan Ni wrote:    
> > > > > > On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote:      
> > > > > >>      
> > > > > > Hi Dave,
> > > > > > Thanks for looking into this.      
> > > > > >>
> > > > > >> On 2/28/23 3:40 PM, Fan Ni wrote:      
> > > > > >>> Add COMMIT field check aside with existing COMMITTED field check during
> > > > > >>> hdm decoder initialization to avoid a system crash during module removal
> > > > > >>> after destroying a region which leaves the COMMIT field being reset while
> > > > > >>> the COMMITTED field still being set.      
> > > > > >>
> > > > > >> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The      
> > > > > > I run into the issue with qemu emulation.      
> > > > > >> situation does not make sense to me. If we clear the COMMIT bit, then the
> > > > > >> COMMITTED bit should be cleared by the hardware shortly after right?      
> > > > > > 
> > > > > >  From the spec, I cannot find any statement saying clearing the COMMIT bit
> > > > > > will automatically clear the COMMITTED. If I have not missed the statement in
> > > > > > the spec, I assume we should not make the assumption that it will be
> > > > > > cleared automatically for real hardware. But you may be right, leaving the
> > > > > > COMMITTED bit set can potentially cause some issue? Need to check more.      
> > > > > 
> > > > > I have not been able to find direct verbiage that indicates this either. 
> > > > > However, logically it would make sense. Otherwise, the COMMITTED field 
> > > > > never clears and prevents reprogramming of the HDM decoders. The current 
> > > > > QEMU implementation is creating a situation where the HDM decoder is 
> > > > > always active after COMMIT bit is set the first time, regardless whether 
> > > > > COMMIT field has been cleared later on during a teardown. It does sound 
> > > > > like a bug with QEMU emulation currently.    
> > > > 
> > > > I agree that one sane interpretation is that unsetting commit should result in
> > > > the decoder being deactivated and hence the commit bit dropping.  However
> > > > I'm not sure that's the only sane interpretation.
> > > > 
> > > > There is no verbage that I'm aware of that says the committed bit being
> > > > set means that the current register values are in use.  It simply says that
> > > > when the commit bit was set, the HDM decoder was successfully committed
> > > > (using registers as set at that time).  There is a specific statement about
> > > > not changing the registers whilst checks are in progress, but those checks
> > > > are only required if lock on commit is set, so it doesn't cover this case.
> > > > 
> > > > Wonderfully there isn't actually anything says what a commit transition to 0
> > > > means.  Does that result in the decoder become uncommitted, or does that only
> > > > happen when the next 0 to 1 transition happens?
> > > > 
> > > > The only stuff we have is what happens when lock on commit = 1, which isn't
> > > > the case here.
> > > > 
> > > > So is there another valid implementation? I think yes.
> > > > In some implementations, there will be a complex state machine that is
> > > > triggered when commit is set.  That will then write some entirely invisible
> > > > internal state for decode logic based on the contents of the registers.
> > > > As such, once it's set committed, it typically won't look at the registers
> > > > again until another commit 0->1 transition happens.  At that point the
> > > > committed bit drops and raised again once the commit state machine finishes
> > > > (given QEMU doesn't emulate that delay the upshot is if you set commit then
> > > > check committed it will be set ;)
> > > > 
> > > > In that implementation the commit 1->0 transition is an irrelevance and
> > > > it won't change the committed bit state.
> > > > 
> > > > So whilst the QEMU code is doing the less obvious implementation, I think
> > > > the spec still allows it.  I don't mind QEMU changing to the more obvious
> > > > one though if someone wants to send a patch.
> > > > 
> > > > Jonathan
> > > >     
> > > 
> > > In current qemu emulation, when COMMITTED bit is set when the decoder is
> > > committed and at the same time the COMMIT field will be cleared. Does
> > > the following fix make sense?
> > > 1. At qemu side, when the commit completes, just set the COMMITTED bit,
> > > but leave the COMMIT bit as set, also check LOCK ON COMMIT bit,
> > > if it is set, clear it, which will allow further reset of COMMIT bit.  
> > 
> > QEMU definitely can't do anything to the Commit bit, other than prevent it being
> > cleared if lock on commit is set.
> > Right now the QEMU emulation doesn't handle LOCK ON COMMIT at all.
> > It would be sensible to add this support, but we don't have an
> > open software stack that ever sets that yet so any testing is likely to be
> > one time only via some hacks.
> > 
> > > 2. for the kernel side, if it needs to reprogram the decoder, it needs to
> > > check the COMMITTED bit, if it is set, then OS need to reset COMMIT bit
> > > first, which will also clear COMMITTED bit automatically at qemu side.  
> > 
> > Could do it that way, or simplify it by always clearing commit before setting
> > it to make sure the transition happens.
> > 
> > Looks like commit is cleared in cxl_decoder_reset() already so this may
> > already happen - I haven't checked the flow.
> > 
> > > 3. when the OS needs to reset the decoder, it does similar thing as 2 to
> > > reset COMMIT bit and qemu will clear COMMITTED bit.  
> > 
> > No the point of the above argument is that the spec doesn't say anything
> > about when committed is cleared. 2 options.
> > 1) Hardware clears it when commit 1->0.
> > 2) Hardware clears it when commit 0->1
> > 
> > Given that spec only talks about after a commit 0->1 transition whilst commit
> > remains 1, the state after a commit 0->1 transition is implementation defined.
> > 
> > I think that closing that corner case requires a clarification to the spec.
> > 
> > Which leaves us with a sticky question of what to do...
> 
> Thinking a little more on this and another close look at spec.
> The committed bit definition calls out "Indicates a decoder is active"
> so if it is not cleared when commit 1->0 then we may have a problem with
> multiple decoders and the clear only on commit 0->1 option
> 
> Let us first setup decoders as.
> decoder 0 -> HPA X to X + N1 (then commit)
> decoder 1 -> HPA X + N1 to X + N1 + M1 (then commit)
> 
> Now we want to change them without passing through a situation where we have
> overlap so that we have N2 > N1. There is a route to doing this but it's
> not very intuitive.

I'm a bit unclear on the variables here.

We have 2 ranges A and B and we want to add C?

Size of A is N1
Size of B is M1?

Then Size of C is N2?

Or is N2 a new size of N1?  So the size of A is changing?

> 
> 1. Unset commit on both decoders
> 2. Update decoder 1 first and commit.  Have to do it in this order as
>    decoder 0 is still committed (in use) so we can't overlap with it.
> 3. Update decoder 0 second and commit. 
> 
> If N1 < N2 need to reverse the order.
> 
> 1. Unset commit on both decoders
> 2. Update decoder 0 first and commit. Avoids overlap with still committed decoder 1.
> 3. Update decoder 1 and commit.

If the size of A is changing then yes I think this is required.  But I
don't think it has anything to do with the commit bit.  I think we have to
program decoders in order anyway so this was required all along.  Wasn't
it?

> 
> So I think there is a path to make it work but it's nasty.

Not nice no...  :-(

> 
> I'll raise a query with CXL SSWG chair (off list but referring to this thread)

Not a bad idea.  I'm no expert on this I'm just going off of what I have
heard/remember/read on the fly...

Ira
