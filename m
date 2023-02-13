Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51536695023
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBMTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjBMS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:59:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE961E281
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676314775; x=1707850775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sKAyNVK6dL8WqXoso/s3QTCbGBbutMsF9KQN1J3Tq9Q=;
  b=bw+94RiuIED4FWuWNOcIpzrUUKGVXlLIeXH26hgsjtbIuYVdLe/Kac1P
   RAHye4+UJel0GjFWW3t7P+va8lJwUWt9C6uieYANlwf0VXJwMLznvV0/s
   eelZ+FkRcQcARy2PYM3MHe5AYhI8YQ0h+xJiojTJO78OrUwwsn77Hnk4S
   7C+0RxHJozr0lvLTHyYAPDUaVsh3GrsXXFq6TpT8QFcMrdQor9QRnZKDw
   9dwgaWS8IKW9YW81kARgfstjjh8pfbR7/xC8J5TZGo5j/y+VdzdFuD415
   HXXW8l6T9wSioYmRQhwITvoyYaupTPGAepPKQGT6euFoGDh2UFcqhmIAe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328677916"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328677916"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="997790114"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="997790114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 13 Feb 2023 10:54:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 10:53:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 10:53:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 10:53:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBHGg9msNotxPkOZz20BEhrMIX9vjLqFMBavjIStUxCGAr/Wgp0AFzjdCUfMzVCNmTpZBwiiaEFh1C/5pi8ale9SgPm0Tf0CbyW9TEqz9ja0gaWtS68HhyenZPgeawP26RGKHzMnFz0AbKkcDrFW0TKwCNK+flhwcwt3qOsdjYvRusYhahcTlJPn8K9tIZMWURKnPu09UeA5qbmwUkVvXoSksPPZsmC+rBX8yNIZnprg9tKjPsbQxQF1Wveq/ZkIJ3ojIddXj3xr7zIuzYuQe0Rz6K+hFsTSrtNyMmWmA0S0eFckVrOH9FiYfrgd9M6VNWeNGwsWJaqFnD+j4mKgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5niY5EKSIS/0p1afa3XRhoYFKcIsQYnv9O6pfGzOmA=;
 b=mj7S8frpCwRWWcZyxoZkq8WqQgXIt3OIAaVcuSCoPm9W9ASc+6tuSdjGCf8pXU78FNEaw/ZSCuHI0debo5UQgVHXQD4+ryRmbExFRG92nbVehfUg0awBSx0SMIuF+AjtNQEukZAZP/f+/6nkN1BuxaiOegbPGLbKEk39GKpits6fkxKNxmrnbdo/Z6M6rX8wbsm3oVtvDFnt3WiUbfd1e4o8oM8IX/wfeaveeB+DPenKhdzkxFhOjKiNJhjxkmGyGOxDHDKnGk7WBDwvqNWxp8No9UykD2iM9Qz55tT6alaDI5RUHNOsBqc0WKlZaHvo7RF2wiBhm4pNmzlPD4dvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5692.namprd11.prod.outlook.com (2603:10b6:610:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 18:53:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 18:53:55 +0000
Date:   Mon, 13 Feb 2023 10:53:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-mm@kvack.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Message-ID: <63ea873eafd82_14e70a2944c@iweiny-mobl.notmuch>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
 <63e279f730612_104ce22946f@iweiny-mobl.notmuch>
 <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
 <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: c852655a-66a8-44e7-4922-08db0df3a7d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruNJVEGc/2aAW06MDb7qg8haUJElIxc13V2kxSeaSmzY43tDNUGllEqPjE2olzJZkff+i/EdaJN5pkP2Eu+CB3OHTXJwNX4FtBJTfTpTb02QrdbvGCxzJsGSkhlGc1gVrZKxG/PDprgpaH8V4wO8N1oMPly1k10fLKqJVIt6joBxUvylO+FGKFspMC5TBxA4uvlMq9zOzTxzmJTm+Twy95//5NDyCo4qcEZi642xdJKQiZ1crR6ljgGfFAxJBaNL+3warRQQIrRQY38rie8HGZOF2TYiXEcT3JZjR7GQfmXs8dnhaMMPAPUCtn5PG1gy14lgHx2DAxDMicTdmjDIsHHKQWCadV74Q+7gpq3krSQG9Ga2Ftw4rgIBMWYHZzXma6U7vXMjEW8g8Dqaq9yODcYPykPFTDkhmjEST1A1zmAv5jy6CiyNBIE/HvYYqD0P07leH68wJDl1JgLkfGXJ7Uh0KC1FtBgiaGJhJJI7Kgnob6xHPm5rJxy0G5mOPhu7KuL+SETW0MwAX8TwXjnrEBs7L4FN9VyTtRnmBflY5E3v3xW7Y0/mao/BDM4LxoBE8yC6AK2yps9rD4N1Sq0sZtjCTyasJ/JJ1ZBHjhmKc2mi8RkQTQYfhJnAKNEgH8MLe0YTrdE4EBsS1vI66ySfIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199018)(8936002)(6506007)(4326008)(41300700001)(5660300002)(82960400001)(38100700002)(66946007)(8676002)(86362001)(66556008)(66476007)(7416002)(6486002)(478600001)(53546011)(2906002)(6512007)(110136005)(316002)(6666004)(26005)(9686003)(54906003)(44832011)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxzENPbteKzAZ8Q4NaGU0gQY1bVyAi9S5Ihpc4vafAE+Eji1i+aeOkyMFBDK?=
 =?us-ascii?Q?7Us164eQqP9739/lTTvuyfuLeP0R+u9tfjQFCxkbnH6Ed/RQr0eG3SEU7fBK?=
 =?us-ascii?Q?z7kO4c1tsW3clR7ixebyN1yzAfcS/AIK9QRSfCNLG2Ca5M+1gte3HYxbXgOj?=
 =?us-ascii?Q?D2l37mePg1WQ9dXJBPPdS1WRNaOeS/bZA4xPbuTHQnYybUKKGktGYjpW/xuH?=
 =?us-ascii?Q?XfnA3Htv01AOrc46wKGfuNruGivsxHIkn9WksIU/oTKwO8Z7T+IzHEmV4Eld?=
 =?us-ascii?Q?0g0PDsrNillJMCSpgQ7BOIElXtu5Z1vAt1d0h79zYhQ4VTXx0hbLoORN6jLU?=
 =?us-ascii?Q?3xX6jvcCBvmuvpurwmXH2NtKjtPNm1fLGv3cDxqtWezXs60GLTMsaNRiOES0?=
 =?us-ascii?Q?NxlxPFLWYFRqeCGTzTm+F2wS+eXoYm3kxHEg3LFIqCd9cHdz7rMvg2uRAzuF?=
 =?us-ascii?Q?L/CVASasg+2yz35Ilhj9Am4KDLNecjLBgWz0eNL3HTff65XxZooyGvZO8ABG?=
 =?us-ascii?Q?oA6I0lEg7CJWEHB2vKgnHPilvX0Fxju5j4vDkHsjc2xcLh/oqL7cNdUKhiTS?=
 =?us-ascii?Q?VWA3vn/y5eQU3BvXXseA+0cUiBAVtamr58EBJ2eZ7igL4dK7h4cMfJhYhx1b?=
 =?us-ascii?Q?Ysb9XW5WJNzfsI57UsJ2IWgWvkikwT9Z49JTnSRrvFwfDT6mgx13YTRE2Nzi?=
 =?us-ascii?Q?s+UMU7KYzXgiHUzJBZPKHTPenOnWK0RAji/45vk8nPxEGZs0FxWZIiJlo7Hf?=
 =?us-ascii?Q?eZuiCa3VDv79A0j7QGoesRMOJIIxeU52ZmQ+rgQDa2uuChYAHOdc2kByEnUp?=
 =?us-ascii?Q?W7qtdSJrQuBSFZHebENOctkj6YDUWoYEBYE4HiQjX2iVihwhqHqcGzWxNRQc?=
 =?us-ascii?Q?+IHPkebvs9nv5BOZiYkbkrSWFhHzlSeBINJ4P984+VJrXA3Y5El0QeuVF1g/?=
 =?us-ascii?Q?VWK6K//tXWC9WVGDyQCxxZb1BwAsugFYjDsBebrFNDc34XiS2idKMkG4T5FE?=
 =?us-ascii?Q?X5ykkb8HDoUjRdQHKyXdeHlpp4ikw6I8x9u7ebMk56hg8fw5IAUOzCj21brp?=
 =?us-ascii?Q?EDKh4+SkIe0Sh5RI/ZqyzEE60RY/Cs+Zrl7LQ56XsHkWjaV3WhKik77/Mn00?=
 =?us-ascii?Q?21hhN1Z5KLkd1dgP6e93CAAncOKfvBYjb/7jOcRQsFoHwMqjprLkgVUmXL+a?=
 =?us-ascii?Q?w1uLkAVkQGM5z+Gq1+VxqHIlrK4e1u6N33MTO6AYchbWPbb8XiT12XHFttis?=
 =?us-ascii?Q?tSjF8ZmGZeZdROBca1mO5I/pMsq3Wxox8Ug46+QYYnJrVJzPMrEOrcJ8XfCk?=
 =?us-ascii?Q?6KCYKKfBWRG1/9BRjtbM0sf/7DNc7Mv6C/qtQI4OWOOlZVPncg2cfCU8ZdTl?=
 =?us-ascii?Q?0uZjw5xHE6Fnskb0JBE+Y6MfsoICdBCEhASQX7AekBr/3FENtL+ZUr7cQTx+?=
 =?us-ascii?Q?Fxh4fKGSp8l2D1nXrnDjlVHdi+NCCpvQI1v10z1Y6bwCYDClEDoTWeQJqsp0?=
 =?us-ascii?Q?roe3dcJZjRRH4Ct2j15W+EUfGKhsbz0t1j+nzcc5UoEDa/JoE2sLYSu0ooxS?=
 =?us-ascii?Q?jalji9Noivp+6KnGbMHMMtdnCfRpxgm4ORIuMEkt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c852655a-66a8-44e7-4922-08db0df3a7d2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 18:53:54.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgNAMpNAyDWMWD3SWKEKVhfBySnu7/ab8TeCuRBfeXohX/rkekbVGvUF6X9OWKqYov52KabOd6uLo0m9vS6WAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5692
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Wiklander wrote:
> Hi Ira,
> 
> On Fri, Feb 10, 2023 at 9:28 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > Ira Weiny wrote:
> > > Sumit Garg wrote:
> > > > On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> > > > >
> > > > > Sumit,
> > > > >
> > > > > I did not see a follow up on this series per your last email.[1]  I'd like to
> > > > > move forward with getting rid of kmap_to_page().  So Hopefully this can land
> > > > > and you can build on this rather than the other way around?
> > > >
> > > > Apologies Ira for keeping you waiting. Actually I was fully involved
> > > > with other high priority work with my upstream review backlog
> > > > increasing. So I wasn't able to devote time to this work. Sure I will
> > > > rebase my work on top of your changes.
> > >
> > > No problem on my end.  I just wanted to ensure that I did not miss
> > > something.
> >
> > Andrew, can I get an ack on patches 1 and 4 for this series?  I realized
> > that perhaps I was not clear on my expectations of this series.  I was
> > thinking this would be easiest to go through the tee subsystem tree.
> >
> > Sumit or Jens, is that ok with you all?
> 
> Sure, I'll take it. The timing is a bit unfortunate, it's likely too
> close to the merge window to be included there. However, I'll pick it
> up and add it to linux-next so it's ready for the 6.4 merge window.

6.4 is fine with me.

Thanks everyone!
Ira
