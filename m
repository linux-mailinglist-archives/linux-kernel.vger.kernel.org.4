Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAF68C6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBFTSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBFTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:18:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12518A8D;
        Mon,  6 Feb 2023 11:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675711079; x=1707247079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WZL7KYh8ID4GfRs9QrGEDOl+CnXITIyoUyyWxgb7HWI=;
  b=DyCIUSSQVNA9d5Stgq01HRZWad3+m4NGdPbQM0fM80kDpBmt/xQj+r3V
   ylV2IsBTOQZOzkP8jZbhikKRynM6OdVx80S/fu1YRgKe6iPiGoP3aVoUe
   0lqWtKBnA52E7f5plVB2vLiLlP/0ERCvPrbarTnhzis0PwyUWvmH/fHbk
   rp53coJ3H9/8vasjFu2wLfVNlbpVIvPGHTtydrpB/36QUNDUHrkBdRQeb
   Eg58aWgfp6e7hkGvQ0gwRsTohHvx0BxgSdtv4GLD7HpAZOuXFrZGJyaym
   xc6V8nkElyfroKFfBxWSF4QBL1VYbF9i59JzzqCnY7EorHHmLpKE4Syzj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309625864"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309625864"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775254266"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775254266"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2023 11:17:04 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:17:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:17:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdprKLBfbDdW09sIErDB9pN+RK9vUz3YNkSrGwsOmZhAXFBrCGxBoOp1S9zvmnLhEHsb1+VjTOwC4Q51/Aet0bYqT0UKObWi5XUv8JG4rybfokHGyUOlbws44qjHVtOCyNagrVVfDIC443/bADH7gu3WE+TiLLA/UW2RAtz7nYYbIkcZyY2oCcsdrFkWtsbj94w58Q843pkk2d17n3mMi+/NQwjH3CJE4yEziJ1qu9sbdFz6PZiDVRq/aV1sVzFrF564gWO8z0FSDOCK3PtwP4lgmiHwDofTaAPe/hA+PVCd2yi98V4M6+KjDkJm3mcRDg324m0MxxvVTDnTJmFR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZyE6hBkneSEGeBwqCTOUgFNC931hJ2AlClWbSotU0c=;
 b=QK5ILvoHFHNyzkXKxNvnG0BIzJ8Lg5XOudMvLrWbkU0wnVR+Or96DbwMueiX+MyXP3qVDUVqJMAx+xSsNt1uxnYyce1SbOnxri1B8QgK0KXMkh0CP1KcMmiV/8+EIMOhk/UJPQ3UJIOqU4AG1CVMQVNerJBYnaiyIEH7fx5caO+R8YZTBwLmU5AL1wkUPOYemD2jtWpZPn1orxvHZC+zQ4tSlRzhX/S6U8PAu6cAkCT1Ats99Gs+P6JJ/PNbVhq93r53DQiqkZRP9wB/R56xm1SU3SyR0ldVzNDXe+StR5Ox7Tl7kSVO/kXQkmdoaYJmb92P75vdUcVbioM4QeWrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5703.namprd11.prod.outlook.com (2603:10b6:8:22::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 19:17:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 19:17:01 +0000
Date:   Mon, 6 Feb 2023 11:16:58 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Message-ID: <63e1522ac520b_e3dae29432@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
 <20221215170909.2650271-1-fan.ni@samsung.com>
 <Y+DjMTSoG9nZwN+e@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+DjMTSoG9nZwN+e@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: 308c2ec1-8051-4e8e-d4e9-08db0876b92d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YXZWNwtaAusGCA93xXBpVDDtsRsu8lrkhhzJ6puB609Hm/b8J30k+t6i99cj8JYSqj9kN7e1IT0spxd1HPoXJUnkpibjraWW2rvsvWlE8VZYqnzbyx7ygXBmqQRA1mt+UMRsMiexAlmOajXuSHv6dYd7IUaX+Aayty+pRcJN9wF/NZ2DAxqBMBinQECL3TR28PbWK3vPtXN6iIa9QATdWEoImCBZZhvK1QdGtpmJ66BSpCqTNNqqejgz0xcYYd54KBmJt/g3Rwf69oHqTWgn9XK2/ydv12iYTJvnAYvrl37IcPDge1PWhDZeMLFlnrxywIEjDYvSqzeGcnUJAU5PAn1JtIrbpGrOtVYcUICQKpIuWtLBRPlr93aXjjf08ji65JoaQvoPGJdrwvrQ+a1I8tX2KnPC7jKjejLQ5DDGNC1VvjQkzlnOLi3BJrZ8TUIoX6q1+hTEYDdhmExeZ/pAc76Wje6LtnY9VLjNAEbkmMZFMDTJRwtL856+Ky0V61DoHmrY2Vb30JvXk4ipsDOcBnpTrnTWTgVfmgBp+kEpVsAX1XbR/aSDbiemIPe6hqBG+fpGdDvSECC7gurI8qtjLf6ue5G4/jckMrVDfRn49xSno4qsM20XIaJVpuC5WjeEPjc/QPwQQrj7jbOwPu7dhGnpyFyPKST2BvkYA8lmNlH4FEbTlvo176SoJ35nuPM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(41300700001)(5660300002)(8936002)(54906003)(110136005)(66476007)(316002)(8676002)(66946007)(66556008)(4326008)(6506007)(38100700002)(82960400001)(6666004)(6512007)(186003)(26005)(9686003)(6486002)(478600001)(966005)(86362001)(2906002)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rDDfLDkwZMuiB8vSywSsfbiEdJQ3JqCL9HDSAD8t5qQnjFSJ5uF1WpFitbTK?=
 =?us-ascii?Q?a0+0GF7hcQrohBVpnLdAMsa9sbUbhr++S4Q9EHpJ21wOkwV3KsKG0UnxTbek?=
 =?us-ascii?Q?RAP4By7E73PCLGYdBGEEJn0iZ/X2KsFamlvw9RShBz2F8h+/ikst986sQ8Tc?=
 =?us-ascii?Q?m3UTd7tdYuBLEm3cbkm84QfSNxjcdRrOHiwUQtmxYf/e70beCskErvmpYu0Z?=
 =?us-ascii?Q?dSiJDWStMJrZ8PFgVhAcu2YoLvnzsDcX+CyvDtWu5CTraoe4Cb0ChQAhhe+u?=
 =?us-ascii?Q?qTXZiZCNrMHmXNXxsuqaoyOUrn33hChSTgRE98aSBwNNp8TBYTyPcKwFPZzX?=
 =?us-ascii?Q?nYD0dwMTeyODpvsTA+MGndy0ox0+YLMf3b+9D2V7WypF32mYzIHjCjrD5Yvv?=
 =?us-ascii?Q?hUxCakI/Mz24mlKLGBfQ3EaqYlYnzimr7OR3i0WhMfeCQu/pNYZH/DtMM5Uo?=
 =?us-ascii?Q?gqRz+wrawTaB+PcOuV9rQX4LifZMac+biLEQmCUIb+JSQHGLMzNzchteisWA?=
 =?us-ascii?Q?s4OvZoyZIiw2bXYwr1YPkvI2t47suwWASLn8m/rmJXEuFc/vvaMWPD6wauvB?=
 =?us-ascii?Q?+svwR8b3EuZoX/kRrmPXHmFA7z0cgRBdpYH8eJOmCneWi7aVZAbW48X3RlUa?=
 =?us-ascii?Q?xT967RpuT3qqGjfRWGIykSf9UkTSK/KETaP4303ZYDmXyxoAlV48j0jP7hOg?=
 =?us-ascii?Q?fpcsnzK/FnJ2aEPhh4yZJFZDpRFf4W+Bzp3FcQ4TGf3wjU6FErWf81Q7sLt4?=
 =?us-ascii?Q?LxwrbURxorILUi/To+iryHQ6rWcqdSFqeQ5uI59Eg1x8qt+a0wVWnHfZ/lJ0?=
 =?us-ascii?Q?/GCzZRa4d/TfhXMY50g+2q3Jxg+Jpv5HRPXHdOYvElF2iuhHbRa9gyog+w67?=
 =?us-ascii?Q?AOjR0A0r10oH44iSW2/KIAMu36inVJGwYkSnMNCpeaBitNdrckKcL1026rk/?=
 =?us-ascii?Q?SeEZ3J5JQfjP1wfIxej/srtk0ic4Vhfoah+csvJpgClcVgWCDHsproW4nXkm?=
 =?us-ascii?Q?bYZx7ZLtRXHdA141sGaZbndXeAlHWJNFh2ij9VLhwqjMu/CUK+e/Ej3Hr2BF?=
 =?us-ascii?Q?1tEamSocx+yX6FADikW+FY0xm8JsL7UBsJUee/rG+Mkw3CNwuGzrz4pc/FdM?=
 =?us-ascii?Q?DEF8VB86j5q/7FHccjYGb2OC1zBkggsq9kloyLqxhpDhZFYpxv2i5DN4e5jD?=
 =?us-ascii?Q?B2jpa4xYA09AAmHZBmyazr29n+RlAxkzIMk1/GhEz/T3U8mb+wHXngPtYD2l?=
 =?us-ascii?Q?YXLAFIRzHuHoW+UgnKQFbKHY2BwW5fHn2bTYlQgHenkJb8c9+IdB4c0qolpV?=
 =?us-ascii?Q?vLJfdd1u7yhIixXukEvuufdtzimXWNIih/kekdanioGgEnRdwvu7ykZzThv/?=
 =?us-ascii?Q?fmp2teK+4tt4U5mT4zSJHhFz53GVWnNSOFNoFNQj9+t5JFkFTgBp52ukdkZ0?=
 =?us-ascii?Q?aYcyDYa0OhoMS19veI34ZjK0p/gqgje8vXxuTdjkRYmnkE5UlM/hl6RpQTnN?=
 =?us-ascii?Q?xWFWS/SjzWZKrB2lrNDTUblOmDyElDa8DbNsGqLmuYf9emlhTqgKIs+VyIUM?=
 =?us-ascii?Q?PBw/RsHBsgCWUT2+p8ekFQmuLrULnKE0eNghzwPD3JAIpXxHdDa/xhsZmTKZ?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 308c2ec1-8051-4e8e-d4e9-08db0876b92d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:17:01.0884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20+UTc6woN0rWl/n3Xe87X08kVVhUtmZt4QPEI5U3ewNiEN18Ys5u3rq6NA14WCCC1IARgnRP8gH3oV8rj6C9accsE5+l/8tzpYwowH4WYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price wrote:
[..]
> Should we try to get this upstreamed in 6.2-final?  Seems like a good
> stable addition. Probably doesn't affect real hardware, but it certainly
> affects QEMU.

Yes, that's the plan.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=fixes&id=01d2cb2593b1
