Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0F64DFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLORhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiLORhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:37:15 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F92A40B;
        Thu, 15 Dec 2022 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671125834; x=1702661834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y4Y72eqLVUU3z9SAn5v565pBPgiQsxtIZB98mddWyq0=;
  b=KE6CN8RotozovIBBTBkU2lcQhdnAdMPt9PVjEicUOa0Whx/OpIuUsxyE
   Cn8CCvRxc0Q7w26Xc6nTft2jCmc943HuMh8FLYS000Y60+KsEQIKG88GH
   j8EbRW/M+bvdK0eI24MnwpYCJBwKGJ5xBTZjpzko0fRRzTM7Iv6P8HUvq
   0Qssx3sThSwDNfn72L3Z/Kuwme61ZFngOSYPVjeV8OrfibA1HB4bCPbxd
   7d+sLBkbtET9DtP0QAEFGA/SfDDP861aC/OKTCLOBaVnvHgSeQckHjIQB
   4hDLUNEh1xf9U1t/CXTGddeiJDyTnX5YJTp4hqhysetAcae0q105wMhgB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316391947"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="316391947"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718093700"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="718093700"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 09:35:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:35:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:35:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af8jxPOepnPElQzG/Fuuao/br+HmOcRVotTroo7oD/ryK1v9jUK2XzmgsWxdolDSrO6tHn0qTNzQ0UewWSzT0IQBv7K2SxPLP8MXBewx9ElImIzP9CP/QyqR/HgaOssg/yAA5UCv/IOOfZhQD4KaaT2tXbTbJuIA5u9U4xcQOT4jv0H8TClz+Y9UVV0k1UymLJAZwfZn88HiN4gqcTVF7x6AxUwEOIY+OtEm0rNRfa/2NPGsxuVmHx08Vs0HAezj6L9icvAbm6mM/o/ScgTiG/RfdK8pIQVa0jnxaqJ5LPZlvCCNXsUENRimjIfDDPgoqn7lpBOuWeTdkZWYJ8xwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBHhTDCfQVrXFmHz207bsGdcfIGC/ICgnUSK1IeBB68=;
 b=VbZ5xc/RwlGKPU+nH6dP9uAag2MhyiZjkeXhP+norqKC+PnPK80XF/U7z5K3EJ3GVk7eF8D9xpYJKeWirDFy8AmfeC/lVE/aNSsTCIfwpL09cy7bZkwRD8rs5GCqNDc2uJzAljy6YXkK5duiiZWF5sxb/zWEHIegWl80T3Q2qd0FSFxQCjkm7u/7b9nJsLpx5wgaw31lqxFWlMhY4G3vRUJ666u4qPJcZdtxxc6TDoJERNRp2qZ2In3mNopMoK8wlptge5FF/Ctwzs/SPvFue2QQjrzWtohuEEt8SRM/DA/sCWT4a/JFkHdXELhygWC3/JrX7Y/+U2h2M9X9uSJDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB4823.namprd11.prod.outlook.com
 (2603:10b6:510:43::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 17:35:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 17:35:25 +0000
Date:   Thu, 15 Dec 2022 09:35:22 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <639b5adada2e6_b05d1294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5kAt3WRgncTj26x@bombadil.infradead.org>
 <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
 <20221215060410.2p653tgqw35q6wbz@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221215060410.2p653tgqw35q6wbz@offworld>
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB4823:EE_
X-MS-Office365-Filtering-Correlation-Id: 295f8983-86f6-4271-f603-08dadec2bffc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8F3GZirBs8CNbc3ZUQADDwV515MW5SKDX75zEI2xDOs/HqDo1qDH/6O3JM0+pmEfyGhg5ftczrWx84NXxKe4vQe/PNp6agixJON2Q0yItluU6YJtB73mJABNx1Kr4219Cphig7MARhXXFNQJuZxOVU6ZbnGym9j2/4mlbnFEH5CjEy3s0gAafrPljsHRcl1Db9gIu3W4V/zN4OnTuakaNo79th1svPJ80G/SiAbQ/STL9W1hXLD+/HEOQaTzT1019aJ3HiP6mik+vOQE/akJ6fzggm1W/TwDTRgrOtVXQ5EvpCXygpp2IhxH1Xlp3+XNjMYd6UAdU/fFZTJdsnbBWtZGa0pvTEJ5bP48VUv7rpReTH2m7NnKKDumApmYEliggvEyMiPFVR9uJAh9IimJQtxJ2kL8pgW4w49cazvLAQk2dY4B+oFtZw3L2lEdFNtCyp9TZg2TPyiFqv4IKoYjBwUClsxwFIV1dC6Viq8SFbLi9NCkNEYD/n0PcBO04qLYX1MifmiwfCaW+W/MF60f5hhtLmcjJwIjCfAR2PMrzBqJ5DdcbRiEcAVfdOUaTds65mk/+uzcz7mLE4iJWE2CRrqVfLpg0hTmXATdkX3T+7HR9pR6Pyy4cae2sf5WC9tRME1rfW7rDttUnzNs3upVHHgi+3dzOLKiGlq5mZLFQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(83380400001)(82960400001)(38100700002)(110136005)(54906003)(186003)(9686003)(2906002)(6666004)(6512007)(26005)(316002)(478600001)(4326008)(8676002)(66476007)(5660300002)(6506007)(66556008)(8936002)(41300700001)(6486002)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7nmxTHYKjwfWwbxUYka9B6SHPjJ0SLC+lLUJOsvIlYK/e5Dtzy7r0uWwvPv?=
 =?us-ascii?Q?CYYClSa1tdqe5qrOWTeOPutLqyZGWG5qN2qZs/PeoXXeRPjX1D7PsrExmFDn?=
 =?us-ascii?Q?MmU/F5Xm/ryniPjPVsUDX0YH283wgs7OZkSxrQA+Iti+M3awDUK6l50hC6G0?=
 =?us-ascii?Q?8PeJAmpP4j6zjejDWZ6HJa9+nsYD9h5fJq0FCPx1DYILGQvVDUloqlWF2zpN?=
 =?us-ascii?Q?X4Nh+8UnRvFg0H+4RafKecRdTRqEnzQODnSmRTDRQGfwVNLCSpbmcilapWkc?=
 =?us-ascii?Q?9AqGMchMzGmQR7dfJ1NvJJEljoqiMLK4yS5GTHho0rOJGcpOGjOQF2LAOxnD?=
 =?us-ascii?Q?t7C0KeP1zD9tRiie8E5TvdgSo7rHRXdG7eLD33AuO/eWkjgo83M1plEiHgBd?=
 =?us-ascii?Q?5AZg+M5oH3X6+TseerMkzDhDX/T4yKwu95jz0ndbDYT6QmUVQ9YH3mJ53QyP?=
 =?us-ascii?Q?NMY3LFbqq/TkHqYLYIxAA/KOc/Dg8eRhKRqoEGRjNgB3qwzdhxTiQT/3GRQv?=
 =?us-ascii?Q?EzFOA8iIivANsVByyV+3HFMefR/FvJ87aUR1GvpbfMY6H5MfZA7p1IhQy9Ry?=
 =?us-ascii?Q?eNg1sVM9iU01Ij6/ERIUfbjDwYhtub6+gKzyR6vQyjDpMY0tHjOkYFxtlEPR?=
 =?us-ascii?Q?17Xy4oHoo13G4BScanUka8ZXU7IKqxwfWQ+LjibkUOTgJpzKXjLLzLIz+rjx?=
 =?us-ascii?Q?11mu4szSa6UQT6OQ13XmLwQTm2DwOSAp4a1cuB2n5+pTkfcljG8wXVtmtIQZ?=
 =?us-ascii?Q?MieHb+CksZjHXRJIcUKkRag7aoKZnVLCjY1xzIcgERiXetwLEeY5hfXG5Q+M?=
 =?us-ascii?Q?PXGbQgMnmSg9qnWHPxv6sPzwFmMnpzmDC+taA5g1nJiblnbop31SiDYz5P5O?=
 =?us-ascii?Q?MOZF7bmoR8s/dt4RRma4DbG2vwpDTsQ76XELPh5W2GxvY67GbABDD2kR9i87?=
 =?us-ascii?Q?O5i0oqLxMOfwsTfm+QIaTPSfVV+4f1x4Pxr9kQT0KZK+O7La+ch9s+UmiN4D?=
 =?us-ascii?Q?yCnKuIxf1FOdGLnRHRoWCMKEyZAzcKr2XvDcWv7lRJRu9hTJ+QBvW7RoXJGS?=
 =?us-ascii?Q?TiYMEpRbgMUn1eduphkr+1V7iOhvKQy3shcyzDK6Z+gDi+w6LJ4smz111MYr?=
 =?us-ascii?Q?HwQTAk5CXnINdLlUN0x5NNyAqxkP16pxBtKE42AJ1Q8detUbcJG5a7iYHcdu?=
 =?us-ascii?Q?uv1mPc30Wc4aENZZ0FlLguBMndHDxzylVm1+Pm8Lpx7LdGgfi7/a5HCDTrcB?=
 =?us-ascii?Q?kIbEVk8GuA1kGFjAM9bBWmFKap5Mf5lBBio+Q8KY+0EJ35AI+UngEWaY4bS0?=
 =?us-ascii?Q?1KzBg7Qw2nKRJnqlqbSZtvG+jvhNJZlov3i315rG41yh28bW571kNChc+vb7?=
 =?us-ascii?Q?DihOdy8BK1O4VrAhPV/hHvy966r4pNnAkon6LQDK8c5PYiqs6J/tAO94XcHR?=
 =?us-ascii?Q?qFwqkc2ptgsCYk7zAfFh/hB26Ywd5AD13lrG5bEFHOQO+ghOXtYwWFr/Tgg2?=
 =?us-ascii?Q?y86lbwwlI7PJIWazbuvacpaD8ltB5VqXFL6BbISpYSImzzzoqoDEprXpcMj/?=
 =?us-ascii?Q?YtxTRCUzlcSi/xHW0itTydBqCt810WmZDcgJ4gsqE0Zh8E3oIRIla6emF1vM?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 295f8983-86f6-4271-f603-08dadec2bffc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:35:25.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehKUZ5Sv4CHScRjE7fjnBEMgCBwhlZsUn+u1VG88EzQZBE+Um+MJ1XnW2lEKEsc11ttnW9OmdBd2b2MUO5nhpl7UOp7lAgYyO/xffrVkyWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 14 Dec 2022, Luis Chamberlain wrote:
> 
> >Groovy thanks. Progress, but still fails now on the cxl-xor-region.sh line 29
> >
> >https://gist.github.com/mcgrof/aeac639365a651bd77f143cf38eb7493
> 
> Unrelated, but looking at this log I noticed that we should limit the amount
> of noise "Bypassing cpu_cache_invalidate_memregion() for testing" emits.
> 
> Thanks,
> Davidlohr
> 
> -----8<-------------------------------------
> [PATCH] cxl/region: Only warn about cpu_cache_invalidate_memregion() once
> 
> No need for more than once per region.

Hmm, the below isn't once per region, it's once per cxl_core module
load.

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   drivers/cxl/core/region.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b1281f528d7f..f367d1c10357 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2006,8 +2006,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>   
>   	if (!cpu_cache_has_invalidate_memregion()) {
>   		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> -			dev_warn(
> -				&cxlr->dev,
> +			dev_WARN_ONCE(&cxlr->dev, 1,
>   				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");

This will end up failing the unit tests because those want to have a
clean kernel log from a "Call Trace" perspective. So either
dev_warn_once() or just live with the noise since the message is more
for awareness in production environments and test environments can
ignore it.
