Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133505F3264
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJCPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:22:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED12F1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664810536; x=1696346536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ulyP0AYad1VElF8s94oxtJJxJTXrhLQRQQ76VUG1G2Y=;
  b=Velravn+Tuow4cwrilUVxYwzvRN/PgG1cTaHO9tW7uzExd3R4Gm1SY+3
   cmkMacpWSpKOt0pWcmvwdSS85lxcag87uTaF0Yy8Z14RxumDiwwFLQKom
   BRtbZ4pg+eGq811uRfwRuLr3JUSktxbBbM1Tphw0GnlGBzfc75ok2YKrc
   frqrBuAJ9RBPUxYm/ILuh3mHn2la+OIiRZnOBElSD5s0XURO3KCOgd8e/
   +vP6jQV19nzWWG+ACA84DPpYmxy9tPb00oSQ+/cnj7KYwWt5LDHZs/AQG
   tmpFuSCVA7vHEap2I82ZTJIHYqSKeRffcGAX12BRZA7VRPsdKkUtO/l6t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="285820662"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="285820662"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 08:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="625809075"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="625809075"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2022 08:22:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 08:22:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 08:22:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 08:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RErFHK3jE8eSmILAiNFSyV0lhhJChYxVhWt+HQ65ZIfTs3ctkfyDmOgQ4nMN8t95grK5TdTf54OWgtgHzW03x+Fvwz4pbCIs165l1WECmkPO/5GdjSXTv5Uqq8YVVhvWTgRFGDNyp1Tjls7GQWTI3OD3kgmDoCk/fTHaU1pow7Dk32BZZ+KB6DpA5JU0LgDfs5cfJEZI6I6zrW4yR29oEdPNc6Qx1d/vS7KpbFYhmdgiH8Cy4qwigxduMsJM0ZE3yuyNs25eggjSpEUzty3j+FIIjQ84Z7DQLpZOrYqy0SUsqRywue5J/AkvZIqHb6bNw3c6EUjxiG2ZCkxRcCF4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a/qr0MzPCSEjzPA24NyLRgekJMlRyss6ik+8xPPPv0=;
 b=LZrR5fEPTJOLeCePOqay9/c84BFyTla2ktU1PA8IhJN8yAd0Se7i7RgvA/cfWb2KgjUhxjjObRjZgOTwNtNHwnx9gASGDumhQ2U9SyJvEcHunvlqmNVVxowvj+06sLc4voFmULhD5P+3d8xMycpAnpYWwHIdqyehRcDKOty4YAOypIrp3+e5/OxHsve5bfQKgU40G7FOp/Zr8DmqAPkso30JP0J9GkM2C64RQNckVfNet/IxoZq61NprHRVt/f5NHvfRkf0lArNzdAQSw0Q+YAArv08j5LdRvx7FQYHmg4qnDzA4u5rzlQb+II34rQausTq7nBSjt1Gozw+34zlENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 15:22:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.035; Mon, 3 Oct 2022
 15:22:13 +0000
Date:   Mon, 3 Oct 2022 08:22:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 0/4] Remove get_kernel_pages()
Message-ID: <Yzr+IU2IMkvJQqbu@iweiny-mobl>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <CAFA6WYN+3inY6MYrMFY0qhmifCYtj_immFMFN6jC1BamQCYGWQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFA6WYN+3inY6MYrMFY0qhmifCYtj_immFMFN6jC1BamQCYGWQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e50ba78-7eab-43a8-e792-08daa5530c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyJ1RMPVJOT4FEk7h1ztvVmy/SETEnKlhYxsB4shJ4ghQ/v3OKHxteTJu2ffPIQZHvyzfBWQX6yb5QL6ca30hoAPRa2PPkdxbJkA4nn5lDL9lO3ld9WZjBlRByb/bwDtCcj1vx1QP8p26bNlAaSf8FkiPwTFBc586whXni6dt5gPAGgRDbtIPbbIYaLPCGBaJ/D8Yoge8zOixirDFQXOTtRwjJ9mRt02Rdf078onz+JPSa6iAW/dyrozjFqfxwQkCJrAlfhxfeDDKTRgpxkV4qhUdfH2Xy7q4hbY/JjBgzlEZmSaU5mOPsqMuWP6O7m8UqYunBg8SN4Ki8oafVJrT61BI5G+/WaTmGn0a477hjz23gFJJyI1hrHROG5Q70gkdUXBhJpyEDHM6Bho6fLJzDwKFmblYHNP81dTywVyYbSlvxBjliTWUyqR5WyxRKNHobUV6IS/xM3jxzP82YA1byPeXIh8ebqC716hTEI4CKtp4cj0Q9yQ/vwsJCkVzkp7nJa7wTpD9fys8qE/qow0k+TfeYBoJ7kw9D+DTxPk5fh0z6eQMUbbzv0uE0AYVvm1HAn2H03q9GVVlj/F/+xjsrXgn4zc09VOXorvoy3u3yHl7blRGpnzRSjZJugeodZZ2UHhlEAeYtddglQQEEaYCLxuCe0HxmF7J7h4Gopx16NPUiPqLwpyC4FH3kCssge2EZxYKfL1zSccoKJfGaA0UBAGFGi79jii9RJCGiv8RR69TxK1Wb8XS8a9B1DgQJSPqTyzLMcgs46fBloNKPJ4Qh+7E63XQKnDfw6oFN4dfCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(44832011)(2906002)(8936002)(54906003)(316002)(6916009)(41300700001)(5660300002)(66556008)(4326008)(66476007)(66946007)(8676002)(33716001)(83380400001)(6512007)(38100700002)(82960400001)(26005)(6506007)(9686003)(6666004)(86362001)(6486002)(966005)(478600001)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMRanG+i6kqOd4UJASa2ht0mOWO/B1S4mUZ3qhRHy9oPiGQcOr7qwXfk6TeE?=
 =?us-ascii?Q?Kh1ZrMKPCUfl7g6ThAIBOenMks2lQMdBVxII8MJTzs5tJJ0D3EsDsMaAS5Yn?=
 =?us-ascii?Q?yf38EqcgGYxoi36dgwXcNH0uiw50Czi9VTW9DznN36k1jetcckDWWwyPMYvM?=
 =?us-ascii?Q?HvuJUXjgjUV9RhURD9v03T1S4qVBMe/9LEdrttp0k05xaZEAAJL45kJn3i70?=
 =?us-ascii?Q?IaFy8k87sPZ2ny6jVFZMczqxl06inEEkragZTSNjz4ShRswfkbumCad1nLN8?=
 =?us-ascii?Q?TG6Sh2THtDvJ6esBcrK3rtC7gSwcsE8S8NjnDGai+iobtGAMW9XV/FAJbEpd?=
 =?us-ascii?Q?m3b+rbY+IMzD5aWimTou+uexlOPcrzX9lH2fWyEODthQReHi4Nfg4I3f4JR/?=
 =?us-ascii?Q?VYZ4POylreBdmnPDSEfM+wg33DZqQPIGlfmPBUmaWoTVapMa35ZUal0DLuGX?=
 =?us-ascii?Q?exXvcSl5+DHCGKaTPzdZnLHPwv/TZSNQZGEmzHD2dpUZbaF4m9O0+3PrT/Iq?=
 =?us-ascii?Q?NrhhxZEMwJ6fhpxfipJIQTvIc6ykmAl5NSPhVtFFTwWU7EKyMddTNLY9+S89?=
 =?us-ascii?Q?yRUy+jD+KduaR98xLjGtRvipPVKtTciFzGe55eyXVNoE+CsAYinaUSca5FsC?=
 =?us-ascii?Q?vhn+/Sq8hhdm+JYgl7qj8DGhxNHfxrb9Av3t+n9aYEdNGasVi8Pl6VN6GDp3?=
 =?us-ascii?Q?OHDFiS2RPJyIW7HA3igSzjXL1jWGSap+rgnWac83skZD94T1rhe77t7F7VOk?=
 =?us-ascii?Q?QIS26jjkpd4rr5ieNkZvUKTzwIETrwXhAFwudbnT7V/aGNAJte0AwtBcYCqV?=
 =?us-ascii?Q?diI2dtgglYZ4vRM38vEdHiY08vJ4viByoDPt5kmuH2sTb0AUxunSAiWpeXZq?=
 =?us-ascii?Q?iXzsdJjaHRY5ISmrLt3pBhUhXV9ct4XxFXOKpiDrrznxMnTfAaKijNc1KIWD?=
 =?us-ascii?Q?KOz6fLuurVRvPlFpACtTE5DCE4c2eX5y+f+ogpmTl1vbP8aB4yQmPrkD/G6b?=
 =?us-ascii?Q?rWD8J09bUveM1Z06f1B++Pv/UjW/FWtw40p1xarNGskyoasyBYVktR5TFRwZ?=
 =?us-ascii?Q?bbiKqEGFEfFG4Te72X5D08OS5i6G8JYWilMvM4ydghP6INd8Z4l1rEUZHRDM?=
 =?us-ascii?Q?p0FAsQIMxH62UgRFwQyQr2FexwuBPlQCu5xQE6bDmL1rGiHhmplb9oy1+HY3?=
 =?us-ascii?Q?ZwYy/QyvBOOLH9ar2P0iYC14Z1tVMRJ6fom3EPf/XTcYF2sjlKJ6fCnIF9UT?=
 =?us-ascii?Q?lfHYs//6++Ost/kWg6hKV8d33V5wKvH5T5Am0qPzCt7nPGOwaizoDJoAJqJ2?=
 =?us-ascii?Q?u0pn2WSItGw6DtjtOdEfaaOpAXD4x8E6IO8zHqak0bKvL0R6Abv2J/rTQl2G?=
 =?us-ascii?Q?wC37pHCyIoHtSZ3QhArSA7MI34SdcUOj6xlt5karMuk2dGSzumQrHDPKw0Nz?=
 =?us-ascii?Q?9+buwtrFEOiVBJOblIDNXA1uSwpYJ1fqsslMth78ML+hxXEcSaFqm827tdfV?=
 =?us-ascii?Q?VTDs+jCxgOETXcf5BjYXv1W7ppHDJz4VBLv6Fnj42fL5co4cHprZevEeNFeY?=
 =?us-ascii?Q?F4wEU1zZn8FhXl4pDX2pPDNgc0Yut5ofpSif37T7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e50ba78-7eab-43a8-e792-08daa5530c66
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:22:13.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x38oWLmHcCGtxIAm83aOrXkqOJceTTkr+VWdeQGTZ/otrh1+NtE0ICxGz3P9MA8n20Q4Zs5lKULJGIVxBvM2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 02:55:02PM +0530, Sumit Garg wrote:
> Hi Ira,
> 
> On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > get_kernel_pages() only had one caller [shm_get_kernel_pages()] which did not
> > need the functionality it provided.  Furthermore, it called kmap_to_page()
> > which we are looking to removed.
> >
> > Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
> > get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
> > does not have any need to support vmalloc'ed addresses either.  Remove that
> > functionality to clean up the logic.
> >
> > This series also fixes and uses is_kmap_addr().
> 
> From the above description, I am failing to see the motivation behind
> this change. Can you elaborate here?

Al Viro found[1] that kmap_to_page() is broken.  But not only was it broken but
it presents confusion over how highmem should be used because kmap() and
friends should not be used for 'long term' mappings.

[1] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3@ZenIV

> 
> Also, since you are targeting to remove kmap_to_page(), is there any
> alternative way to support highmem for future TEE bus drivers?  As I
> can see higmem being enabled for multiple Arm defconfigs [1] which can
> also support TEE (an example which already does it:
> arch/arm/configs/imx_v6_v7_defconfig).

With TEE how are the highmem pages used?  Right now the code does not seem to
use any user pages.  So I can't really say how this should work.  Why does the
kernel need a mapping of those pages?

Ira

> 
> [1] git grep CONFIG_HIGHMEM arch/arm/
> 
> -Sumit
> 
> >
> > Ira Weiny (4):
> >   highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
> >   tee: Remove vmalloc page support
> >   tee: Remove call to get_kernel_pages()
> >   mm: Remove get_kernel_pages()
> >
> >  drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
> >  include/linux/highmem-internal.h |  5 +++-
> >  include/linux/mm.h               |  2 --
> >  mm/swap.c                        | 30 -----------------------
> >  4 files changed, 19 insertions(+), 59 deletions(-)
> >
> >
> > base-commit: 274d7803837da78dfc911bcda0d593412676fc20
> > --
> > 2.37.2
> >
