Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD862F39B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiKRLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbiKRLXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:23:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845F8C79D;
        Fri, 18 Nov 2022 03:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668770538; x=1700306538;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WPB/SBATvGA5bOrIJvv/7uIW5hNUi4HZzvX1SmmezDM=;
  b=ZahuDmDU4XkdH5rij05wlquQS1R9qJtwavBB1uTm2IMxXoD4UjhkH6Uo
   9V989YySDjoINqCh7m65K+9PdLUiBTv+iUeg0hEDrOC2sVw2EsSDG4/7d
   HDnkluMSnsCniUtygmOkPLel1TINnGc5zpqM+4RHALhSAqWmgl/FRvkdJ
   GwIpCjYllDrJcrJONEra4DQDZM7AQvp8dVMmNGu2TomSrxVd7I3ZQC3XA
   jz6ZyUWR7IFBd3IKoPAfVJM9dnjT2pOrPNys8VCKXD8iIBU749Kmw1bR7
   8pp5F4tw0wfVVOOleHXOlmu37Ud5e+y45hk8jwuDA7QJtLmQxxIg5RgyD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="310746149"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="310746149"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 03:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642484753"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642484753"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 03:22:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 03:22:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 03:22:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 03:22:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1RCpJR9ShvVC+XRp3IMZONLJ1AkKU1pcpcpkJbYH6gF88HDxoxCgqKb09Qscp2pBBQTs2cAsEHIEqkrLtMfOz/uYfbNnHqddJjHGpN7rym7XkOtoKi9E2rkDGykCrg37U5dNTmIuG+xmrvLMdeAOqcopY0lkXcGVpuyL+FN1yEPiLdf+k4Eb0ENx78L3cHdVbN6yAca3q3qyJYFh4la3+a2KozOvK2xn71XP4CpnzDdNr8mruZBnveqmdZxLoqvFmEaUY9PpoC83HyzXLXS8LKNgXbA+eFhY6j0ROKhQ1L/FRjz6kth4KwJNNrs6FL09MMk5sSWPEofhXHwLmZtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSQC3Z11LWmr3tyOZioC1ICHtpfElSVg2l0oJ8NTQuc=;
 b=NvtcaeprzDIRpIUx/Je4buzTXGt8ODSJoPoJn9tVaz/HXlFwKaOQQHDyGzXDL7BL5nuXNeoxnJy4ggcBwm6LBbIyeF7SvTVjd/GXBYFoFGQlRBedHVNdOD72sTjSCZ4mm0ABAzJHrvG7g4QYfwkbVHeUywpa2cqaTGL83oAunmkjFGD0wb6t3nuk/zEq0NVRLevswCPBNKVvgCh/TtWNM/v3Xrbeu8DVdtFXbeBqeJ0rCS5pAe7G5vWFeNdoRp3DqGLQ7/ofzvDZaXYGjajhcgiaCmCIEXRAickH473XpyffIjmJEKWDwCHe5NTZrWlhi1dP8uzDsv5jFGT/EqhWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY5PR11MB6510.namprd11.prod.outlook.com (2603:10b6:930:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 11:22:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::3849:238:f7bb:f1d1]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::3849:238:f7bb:f1d1%7]) with mapi id 15.20.5791.027; Fri, 18 Nov 2022
 11:22:08 +0000
Date:   Fri, 18 Nov 2022 19:21:54 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <guohanjun@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ACPI: pfr_telemetry: use ACPI_FREE() to free
 acpi_object
Message-ID: <Y3dq0oxTbsQs6SJR@chenyu5-mobl1>
References: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
 <20221118063219.2612473-2-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221118063219.2612473-2-bobo.shaobowang@huawei.com>
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY5PR11MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af4cba2-524a-41c6-9939-08dac9572100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fap8MQm660nOpzMhLLE1l1u4kA5CCvO0t8M8hxMEPr50fkiO6ZFLgMzG6Ma0rqi18TstqgofiSJM+uN1oWpTDTzxyB0VPE7nydsdRDx6tk1NB1QOmGtbF7j8HD/H/zdkCx4UqRxrPIRTZc78DF0hUWufmGlnPfib31q9TyFSz6K+pY/52rca9uLyZFaYpJP/pUtGUiwGFW2e7FHFNuZGiZJysxDN9YEB1/vaAdpB0JWCwg7P15h2Mu+la2wDSTg6wwwNsb1ORRJk05+G9AUe8vToikf36sOs/wDQLGpSjBvg4DwEyhkW+TNo8STwCx9PDO1vxHXcchot6zBE9Hk2GDR5fBV9uWGJEFuV/vfLqnlclYoigKkf1ATyXZ10XHXI/R2BCBN9+VPQV5/qsAC/xwFfTcZm1PTAYkkFR6of9Hu9HiGWkXjcb+lHzxKMuzOJrZR/UsgHlM8a+DmbRQhwYJGMZhpkBRxSRSKimdbqOIJDfoqL1825NSY/oUT/zUwUA4hN+sIWmL2piltuuVVD4uhyM8i3P6FfTrdJtuU6AdTpCRE0k1HUaKR4BwdCAN2HQ55WEk8JYRuS8vy6nkRAqccKD/ZXbxO+G6nOgVTh52J/xCTQBL7v6HyObdasFKzA/XlfTk2O/L/BEZnaKsMK7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(86362001)(83380400001)(66946007)(38100700002)(82960400001)(8936002)(4001150100001)(4744005)(2906002)(4326008)(41300700001)(33716001)(6916009)(66476007)(26005)(66556008)(53546011)(9686003)(6506007)(6666004)(6512007)(186003)(8676002)(316002)(478600001)(5660300002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3SPCZejO2cxAV9Rgd8flbLFicJKBEF5JWH/RbZOqMdB/FmkPY0M2D+/6d7dK?=
 =?us-ascii?Q?ZxsyZxr9guUQEeZg80EoEZ4OCEeR70Vzqw2Moet5WSBjSbCrRFpFmSTQmF8P?=
 =?us-ascii?Q?s4MbW/VkDDu/HE/dtq+3yllGHoqAc2oRGqLocEIaZT0+J3SrFvt39SQopfUR?=
 =?us-ascii?Q?7cS1VDRjt1uRXXMFon6JM17pbVX0lazfZdYckCDtvzQ/QTsC7ycekRnYp6uB?=
 =?us-ascii?Q?4ksGGQDIt0lIESlwlA6zr+3Q/QkBQ5vCiCKUBana9Y+ngafNxAvMYVDyohrv?=
 =?us-ascii?Q?i/vqIFgSQDTx4zd6HrSD+7z+RCpxs1II6KgEPJJ1a2J3t90Caz5N4FZYG43c?=
 =?us-ascii?Q?k5Nki5LQpP13BblPuxsUmgewhxfQfvjtj6HmAhJoXxXEX98XyHNG3Y14duRq?=
 =?us-ascii?Q?8QcjEd0EjF3e33ta49nh8k3qo/S55uydGBSBL02ZbzWx80ThfvCGp0Y8egGi?=
 =?us-ascii?Q?YRGUhHdpIiuXb5HOWCCmVSJF1C9jFcoZK4wKLtry/C6+x6DhRp2Hz/IrdK9W?=
 =?us-ascii?Q?F+muGzssSdoCw/RZqyjW3P5Itki31bkuf99LonAWOVlqv4sG1SEL08b0MwU1?=
 =?us-ascii?Q?9VlSAmE9NEKbYMhRDBRcBNmPOZ/akCmNNDCNq750wkoqQtDTztCNLwUBpeNF?=
 =?us-ascii?Q?Sl/+tbo1pozzfyxkUX3W1U6v4C1Dc12PbkMUCNDVJRrI55ZNoY0Yh/0GP4xM?=
 =?us-ascii?Q?x47KsQqbJ6oc7kF3CQmdiwiOz48mh4JA9IFF2yOr31b7zkwqFoflNgt4Vvyn?=
 =?us-ascii?Q?AUZwQ/sk3TjFEkAoUo3Ei7asyWMw32vwayzJz2OILKCZr8Ir4Pk1BHPruSuq?=
 =?us-ascii?Q?OUkHEK7vdn2nYUe927jjyUr2muE71gnMwaJvpCPDwg4bbjeHqsSEbLzru32G?=
 =?us-ascii?Q?lS1nW0MwrjoItomWU/W0+WnyQrbW09DvewklV07/D4zrGnCH5gNDGf9qUEHb?=
 =?us-ascii?Q?6G5faNTP+RlwvH3vb2TPTDDhsz441d1bgpskBp9guj+JqLExgkR/RYIlRO5d?=
 =?us-ascii?Q?+8DWkObH1+pbJ1rWgtsxGF1hLeVGhIQZLWLU3KnQrZsgiEA7y6EqcZ8peaK8?=
 =?us-ascii?Q?ZwLElk+ga1eJl76rAmEGpUINzJJuhit4v/hSpwOhtJG7u59IDjwLrSAduDUg?=
 =?us-ascii?Q?m5pjgNQ8jes0FAxmZBhBX08UL280fvknYnwT1UJGdyTc3WOnn42piHlmDRhh?=
 =?us-ascii?Q?HZuSloElC1X6RY5tTuLf0RjMByWgq4Gb1eYspMC2raKF1XVQocmkkhNwsQaL?=
 =?us-ascii?Q?c9bT9O89B80rqK0K9C2zfkZwDozSWBAaG/OSFtQQTr9jGlPN/Jxc5P7ksfGr?=
 =?us-ascii?Q?EEuMzGv9YCVEGRbQBhzapr/ynhOAgT8MztZYS5t1HTab3XfzOVY2I6bBa+SY?=
 =?us-ascii?Q?cEl2Q7NNbaft7GdIYv0cvNjIKuW2gKbeqEwl16TU2ql/v6+QC2av0lE/bci1?=
 =?us-ascii?Q?M6pBWEFC2py25luHZPQzvbtNMeo5iLC7wYrwpxR6BxWfoc65ZqGyB9uRViGt?=
 =?us-ascii?Q?cRWajKDG9+fZoaRMKFqQV4WHhmqafV32k7bQ9z2D7I7Rz5dy7H2mYuGuQY9A?=
 =?us-ascii?Q?tGHltCwet4TJIc9o7xjDcpUmuBdYvWKSAj+BB7ST?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af4cba2-524a-41c6-9939-08dac9572100
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 11:22:08.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzeK1XTqBvK6Ik/cFfTAUfI05Etys8TNEFQXiCqlJzD1ryF7kX5e7hJVCmnvvcligZkjPwMl8Vy8qsKwAA43VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-18 at 14:32:18 +0800, Wang ShaoBo wrote:
> acpi_evaluate_dsm_typed()/acpi_evaluate_dsm() should be coupled
> with ACPI_FREE() to free the ACPI memory, because we need to
> track the allocation of acpi_object when ACPI_DBG_TRACK_ALLOCATIONS
> enabled, so use ACPI_FREE() instead of kfree().
> 
> Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
