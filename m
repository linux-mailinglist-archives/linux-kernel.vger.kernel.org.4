Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03970445D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjEPElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEPElH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:41:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4451132
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 21:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684212066; x=1715748066;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/61pRzYejQejgCKH/EpsaIMS282DSTjk3uQd6SPxrGs=;
  b=A/JgAeXn35cxNt+NHvOOWR/ZYqa8xKU2AsQ3xAQXssnBFcwKNZtLqKm7
   xVfYrMlHpvoHm+WuLS5YgsVdUz3oNuH6zfaDjDFoPVBqhOEsCSOz6yDtL
   IjKSVIYLTGImUibXIzk4JSLp5nliX78itTU1D1EtO8VMkbnxscaoTVXR6
   rh3OXaYYPeFmRmrKVgrBMvLufghshFTFqEwNzwnJsXZeXoVc59bR3R5m/
   6DJPOLHiTymE56c6EUF3tk9DmocV4WVvDHuuQoL+aauxrMDUa2xtygI/H
   Z8wZAQLcz9s8bcykClVs1FXYO4l8u8AXbT3dX+Zn+BlDRbEkBbeoxbSAP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437720195"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="437720195"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 21:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="734133427"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="734133427"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2023 21:41:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 21:41:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 21:41:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 21:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrJWGTHNBbWutlxV57tB/7iIAqUDcqy51PWLaNHTYvM5ZuYomzyomML43j9euv+dzC7MWFcAYmk/7ItI0Eyz3qOd8omhw5TF2sOFiu6wyPflXgsxtzVoSJo3V2CiAURt74xDGk75JngGxNIkKy/u/YF8wMHF3YkEHvnfrH2Sv0LSn+4k9N2spP7VYE0ueIUAdwfFbNDPWvhDrYmzPgnBOjieqfjj68aIdUOXQHfufV/TicfuZyK2fuOC1JM2DdTxXMQiPFAJhtumL/JfqzQeFOtkH1bJ+XGRsUqqTNMR06TlUY8vVuP+WYiyaNw+4QgIWtAWYBlr8BPi8lV1zIZI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OIbTjVsXW4farSO2qNrB85u1SJpZ8of5qRkMqQSYsM=;
 b=kIdaYNLPrTkEup0jtefG2gjmaYbmYPqLe9b1T0niZaN6Y3raXdQ3Go7j42yGb5WGpXg8dcd+/ddxHVRp4jOesxL2JkSia7tcRIUJ4MsNcM8FKbqYjQFXZ7YE4Ikpg5M319slP0FPi5dOHNi900mvQ7bSOxONfaebiAaEK7qOLPyrmbaKQGtW4TfNmZVbkc9c/roe6Q3a8pGPHbReI8wEd8vkvVDCRpPLhsGe2mlyQ7MOgiriygy8Z+m0OadtizhyxLjx3DL9K0ThKHmFdxR58Qq0LsEHScz+GEADofIJuHQnnXzOeaa7rqVF+TsYxnnLYmzL4CvgrS2lH6LGrU3uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 04:41:03 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::eebf:2b53:89e9:4a09]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::eebf:2b53:89e9:4a09%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 04:41:03 +0000
Date:   Tue, 16 May 2023 12:40:50 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Message-ID: <20230516044050.GA315678@ziqianlu-desk2>
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 273ed542-c9da-4e5e-3500-08db55c7c126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOZ7AyAICuU1PadBBbaY2alSaQml+sEa/IzZBUBYJyxdWw9aR4Mr97XF2RR42hpB47g17G38JKRhKrof/gxjQ65azmPtJmi4IT7iwT2vxjsaxqOjnsOusuSSu59hPWCwBJJwG3zSXbcuMtKENMY9kOo3JK7YnFWCnjSeBjEb6Lw1wqTwPPT6a/iojWRQFcr9epkGWXwmG4RDL8DdHqSTYxY09z7EbmiXTuFOpKgImleGDGCHVO5x7zTATecDf0fSKXVECydwJNsSRj7t7qoAeNnt+Ste+5koUbOCnR5YOoHe10zpR6O9H9ifGvVSU4ygEhjUfyYuxLHODVealpl+udJIbGIihOM+FRO2uDIf2/XwQBWZylb1Lx3sWFbWrVIu3/VQlNXZr2DcRXmZJQsS8GmXksNTGy5AALloYS11DF2Y+ruloJFlj9/D2bjmC9hxSTbCoixksAxhmMHIqc6VRxSmB6BHAZwk6eQq+jMJZtHWXJOsT3a9eLNZJan6GGZEduGadY+rGZkSiByLVlg1lWzn1xKK78wxmRmyHiouZtTbZz+TZTbB0OS4Hmvuvn84scTWZ0llCH1om30oIJHgQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(6506007)(6512007)(26005)(478600001)(9686003)(1076003)(186003)(86362001)(6666004)(6916009)(66946007)(66476007)(4326008)(82960400001)(66556008)(54906003)(6486002)(83380400001)(966005)(8936002)(5660300002)(7416002)(44832011)(2906002)(41300700001)(316002)(33716001)(33656002)(8676002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VtJZrh/D9+hKyKJq3XzEhJyJf4joz4tj/VXQ55vvR6s06Yt80aWY7t3/RZOV?=
 =?us-ascii?Q?QQXL1k47nG/Vn8wvpLz3AWvjKG5uypMyMNcrKh79PYgJ5rRCgCk18GVJJMz9?=
 =?us-ascii?Q?3EoEWJjN+ZhtKFmP7WUlIWm1PQunvQPeHktZpeG1wj+rKQ7R0fBxRNeUNKHX?=
 =?us-ascii?Q?IfNYhnuqVHEGtvxjcrqOut+9panFUJOOQ+P7CPwvBjpuWNq8GJHeZZAFnnKX?=
 =?us-ascii?Q?GOKJR+ZcIRJIvZR01Q2I3muxO24TDm9Ph0Uvn4W772pD58t/5OvlJPXRNPwR?=
 =?us-ascii?Q?NNK4UbIlTRqdHFOXGqX/Hrj5VlFaEcK02+NCx3XZqu0vNFxeBNqfEKE3ZyXO?=
 =?us-ascii?Q?PZdJdfp/WMrZzu4odXPetXRFQciGza7Du3p5CpHai8vmi8nSN6cI5pYdPxew?=
 =?us-ascii?Q?JFkrGEfJ4DVEGJYQPXyXR3GAdVpCTIV2VObSSUB/9XKWnzhuLvlNqQtsLF5D?=
 =?us-ascii?Q?goii9rdL4SJmzXGCbvI1o7BHdo1eGBYdJBcnft5lRunDWYXZK9VPp82KiUYm?=
 =?us-ascii?Q?d3/o/Rxv7PtxqwGATidRIdEXXazXkoxy8KISO5ZpOH5ZzuP8dTs5ouP4ypcP?=
 =?us-ascii?Q?JsOFy4bYk527w6P+tY0IC5JEM19f8dcmbszlR3Vqfgihs5XbC4t4m9YPk0Oj?=
 =?us-ascii?Q?VEW4AqXvmstUM+y7OLQCl+zuvnRga129kWo0qVFF84iIM/SPFeI7L/QOcHC3?=
 =?us-ascii?Q?mw8WL6WID1TzlzRuO4+NNGI4cD/HK52R/4Dm6WfykZcCrqocvbyQMDt9tDYt?=
 =?us-ascii?Q?M3Hu4amgofMF5ZzHTFKKCXopMpWSi0NHwz3iorCT4QNwSrsGhsNxIh63HkiF?=
 =?us-ascii?Q?dME24IEdlPfVoS/3sDyWRK3tPw9gytJPxps+jOLXSPM1AARalKlIpg3mnwCH?=
 =?us-ascii?Q?Bp6LpLJ0c3AGbMzp3r9dneaNPQWl9BQmpMnnH961wtoqf1yYSjrwTJWmj/G3?=
 =?us-ascii?Q?q5sOYbIVhrZjcnU0pRAPeAlsvSD7hH5KWd74elSonitymKKGdynyC01JPYDM?=
 =?us-ascii?Q?VkTKIaSV8bNTg6YomUDenADhqOTwiGI5uCsXdusKDEtJtJqGNGgACHsW7JbZ?=
 =?us-ascii?Q?MzClymawXMgpcWhO5QMZa5CSfDFTTzgskpKOvDd0UEgo3bVXzKk1kImlxHai?=
 =?us-ascii?Q?I2nje2n9IJY2Lq++6/MlC/Qizyhts9SJNCspc2aE+0ygzSrW7coYfhlYsv5w?=
 =?us-ascii?Q?nBWZZweeCA8eg4Q3ssofNRDccf787SldoDMzbS44IFDZTDtFLz87inXFvNLS?=
 =?us-ascii?Q?aXC63GV+YpFNPbMa/Yd2hZ36xclGOBAHUlwlIOlmyi+2y3J70+bfcl750bcK?=
 =?us-ascii?Q?Du1jBK/c7U9hnQhAUfgLC8vkOrzYX2YXgNv9SI2HOnUl2iLk2TZitd/JGMeZ?=
 =?us-ascii?Q?p62kXua3uhvGSK2iErPENjjY+tHfhIvJC9NBO4FQrTBxI866/ZjfN1Q39Pwo?=
 =?us-ascii?Q?i/NgaqPKAjzwDkUQZ8H5nTL9o3egWczsakXzoc3+k4MNhiuNA5RWdCkXYD01?=
 =?us-ascii?Q?azHkaOASDIMxDtFdWGbcwMeXjrUHPgK0FLTxfpXH5A8lriMM94MxKxUunUyg?=
 =?us-ascii?Q?fqFkmZW9gR0pRonqnCVFDIf5knDJ1EtXD7ztk6Yz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 273ed542-c9da-4e5e-3500-08db55c7c126
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 04:41:03.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSkxW9q9GlJuM059XaEbIW6oXzNzitDT1u7P4c3fdtSntVU0Vcqgtx/yPFqbs8OSwW/MRvuPl5AFAGxQCgFWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
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

On Mon, May 15, 2023 at 10:35:36AM -0400, Mathieu Desnoyers wrote:
> The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
> performed by context switch. This causes false-sharing for surrounding
> mm_struct fields which are read-mostly.
> 
> This has been observed on a 2sockets/112core/224cpu Intel Sapphire
> Rapids server running hackbench, and by the kernel test robot
> will-it-scale testcase.
> 
> Move the mm_count field into its own cache line to prevent false-sharing
> with other mm_struct fields.
> 
> Move mm_count to the first field of mm_struct to minimize the amount of
> padding required: rather than adding padding before and after the
> mm_count field, padding is only added after mm_count.
> 
> Note that I noticed this odd comment in mm_struct:
> 
> commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
> 
>                 /*
>                  * With some kernel config, the current mmap_lock's offset
>                  * inside 'mm_struct' is at 0x120, which is very optimal, as
>                  * its two hot fields 'count' and 'owner' sit in 2 different
>                  * cachelines,  and when mmap_lock is highly contended, both
>                  * of the 2 fields will be accessed frequently, current layout
>                  * will help to reduce cache bouncing.
>                  *
>                  * So please be careful with adding new fields before
>                  * mmap_lock, which can easily push the 2 fields into one
>                  * cacheline.
>                  */
>                 struct rw_semaphore mmap_lock;
> 
> This comment is rather odd for a few reasons:
> 
> - It requires addition/removal of mm_struct fields to carefully consider
>   field alignment of _other_ fields,
> - It expresses the wish to keep an "optimal" alignment for a specific
>   kernel config.
> 
> I suspect that the author of this comment may want to revisit this topic
> and perhaps introduce a split-struct approach for struct rw_semaphore,
> if the need is to place various fields of this structure in different
> cache lines.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> Link: https://lore.kernel.org/lkml/7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
