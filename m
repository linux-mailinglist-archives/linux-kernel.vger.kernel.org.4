Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1974E686D81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjBAR6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBAR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:58:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C637C706;
        Wed,  1 Feb 2023 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675274322; x=1706810322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+AgHcRXjVsavxfByZSNcTknGeQWex9C6z2ssXzA4jPM=;
  b=U8Rsi2BoPQiajOUPgzEq3pZSBOK057QdX2Lkbgri74fHgfSPDkKiGh2V
   7uaH8TKo0XVFu1LPYVDRiCd4AUxwz4uvTqEvut8xOpcmLWvM1yWGwV4Mf
   UkA65PGj/4GA8cL2gjiof7x9kD6i+m+7vxN5nmMTXvD8yhQvRPMmWZv69
   zTZL7LnDRX3FazvGqwQNo6gO4eio1dKdnNmsNWvkgWBHytq932FOicts0
   KosRZwq6bUyRQ9vdRNuzW9hdgEpQ9ORrA2GqH0eSEC/4CgG5gTYJNTT+J
   xIg5BsAC0vwf3+pWy1Ntv6xupFCLdYCWuEx1rrpQi08kpYOWSpX14/nGA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="316220262"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="316220262"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="838863126"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="838863126"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 09:58:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 09:58:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 09:58:40 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 09:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwFBsx93X8YQIn6lSqc/e5SZpy0ifzsszkpaY1YWfw75c4pFQGvtf0NiQKH90imlUZeoqq+URmmiseANXAxuAa4JAS5HoABH3r8TO+0g8m6TdHi0DZKni2yVgllDNo/qzVA2rbnVQKIpQ05pYl2KBrmNKkpxZILFxkkmDer3Gi9U3ojUGnhi6fBpPm7ylgr41+2AH4beIqGsGQNsXwEawCBVHzUuouR1TVzAMMCS1lvnZS1d/wwm8kyC+QqE2Hsh4UglQiKBHWZW1fOYLDEqkSxqpHBxdMwILNES+u+93jrYBzji4bq1zdcVIBwkau8zXjQKWd4VhCmFZhSqxb+mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs7kmnwbMEPKh/Izv8yXmyvKw21e7HUxyS+uPp2LfhI=;
 b=n1KZy3u9qeiba+PUIrocCte2egFJ5Q3ghMoq3ITqyFazU9E35nDm9Yiu0hxQZgFQN41BBLg67OSSat5UmUsXLUvY/3i5k6J9cjOvsqQmbgBEoqCq0B93912QJGcGIxxqeddpunFHjZKtER0r2E0Ahg8SIcTXOgDhNZqs37TjAxPZjABFqj49m6AGVz6yq4uc9F4qzzoV2oGn0QhmZruPErGKdxY+FEeno+e9AyhSX4VJwTfJmc9N8bGtf/vyEWsg4sUb4rwByszo9dcxq7obt41n8QxArZua0jy/Py/CJWneHBfWehu/uP7nWal+TT689kT7y4MmdD/3nmQoUCz2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25; Wed, 1 Feb 2023 17:58:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 17:58:39 +0000
Date:   Wed, 1 Feb 2023 09:58:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference for resetting
 decoder
Message-ID: <63daa84cf5a4_ea222294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221215170915uscas1p262ccdf32fb2ccd3840189376c2793d06@uscas1p2.samsung.com>
 <20221215170909.2650271-1-fan.ni@samsung.com>
 <20230113110108.00002122@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113110108.00002122@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: c013d6a8-b2bd-49ba-cec6-08db047df262
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1PjklxML9mCle1mzjOQoTVFyW+Yg+p5DfU5rIOsG0rrCftrKuxc0L7X4Wyy/EsYGH6s6DYPyimo/0tIVMYoI8YQ25KRhMUa3/vGTTSq5AdmaKuxlDW+nY7FSacZA4PSIt2EkXUtx+EL0+avb5ii5nzWfsuixmW6gPoNmi1tef/2JmHg4Ws1fSKFKsMV9Fi9mLVpWU4JCksDueOkCfYCo99qt+v2gpKt8hd6yt3Z8S6Lm6ZQKoX2Y/ptJ8hGU7EuDqj85z3rf4gboE0hGkb5xn2TRJYSZxUgYRAApZ6tgHId60ki5pka5sXiUaKd+TKLTfya6FeGBtT80CP17iP5jsDLUvPmuCtz2T3uxStPC2CeRzDK58ajUfiRBEiyWk9N9GYzlSjq+OLv20+sJZLWj4lYRaQLzk4UIPypT7SV5EKO7bm8RgFJJczMR9mlv8EYaSTD1mNDoucDF91BJvpg61QU+STOqXO2d67ctyg87rT0SCimrXEQdsp9DGhsNd41lu3kaqCTdwiif+6RryjrXnLL+PenZCgrFZssIlATvecPKC4vzANUYj+2dyVx0gcueMD3WrmmgEFvrsrm/b1MJQnUgGR/ITWfDs8W3SO/u8NB5AAtshXu2FJY4W6d4YMzRzjdUAs1RtrIQb4HmtSS6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(316002)(110136005)(54906003)(6666004)(38100700002)(6486002)(478600001)(9686003)(6512007)(26005)(8676002)(186003)(6506007)(66946007)(66476007)(66556008)(4326008)(5660300002)(41300700001)(86362001)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWD9GGwsMbk4t4aqWk5bK859geFcOIPJ/jAnMNsu6NYcPRo+7dqR2hKUuswe?=
 =?us-ascii?Q?c/kjXlCLC39o23XyHhy4IJxRJ97rPBNN8uB90AZaAFKPW6HJQtgP15ep+Dj5?=
 =?us-ascii?Q?NHZbp5w3bsv3K5TTwXp9/XgBz0/FV95DW16i8g/9n3PCpB3gcvvoybcAveVR?=
 =?us-ascii?Q?7CMOHZk0j4hYjopeucEK9CSph3oIiHTgA0Hl0ffTZPACmRH3q25oC2qFiP6t?=
 =?us-ascii?Q?ze/uaonjlz6D0fPKr60zv0h8VjbYk0/vAfMOTS+MJD7VdjNIoBJ8I8ATsUaj?=
 =?us-ascii?Q?LuubCW5lV4Q8+4ynT1VSg8Qm2TAVtg276dNc/PHyKiqikfDgRmxzcro9sMPd?=
 =?us-ascii?Q?CJcN3TSIcZXxVebSCKKtQcNJXILDt4VS17a+uA11IP8yhcBagGBKzRG0ouWD?=
 =?us-ascii?Q?yZCSdxYp8kvuAj17xsupCJQpG6QHZotyjQsEOqi2TLxUxpW30KbsiLW4O99M?=
 =?us-ascii?Q?hTJqp87kx5jzyCub3Jl1946LJMJH2hepbQWAuFckLq/Pwe3ax6W6OlMB03WN?=
 =?us-ascii?Q?vYYRqCMQRsXXNHEQDd9I62T0FZZJ2mf+Yzj8017+He/pCSvw7ZA8zGvF73jt?=
 =?us-ascii?Q?b/AsGn3F23lie6RBdjA+tTrRY0vm3IJDzjTRdN7bNOqWtyYNPpDhmJ1C/Mvg?=
 =?us-ascii?Q?uYtPzWbFZD3Ic9R774TbbY2ZH2h71wCUq06UoBIOx/jU5Jk6LtxO+JPshxL8?=
 =?us-ascii?Q?77oiKh7Z+5bapGlLrXn06iMKZAprSdIlsqbIh7pZLB1tgb7PnYnohiHEzXSn?=
 =?us-ascii?Q?99J63vt8uVMvN6DX/kVx65YxigZ7N1ofdtFVeRcYup+x4QXRfkC5wU7iqPSL?=
 =?us-ascii?Q?c8J+xwd6cYklOXew9d+2AsR8fAkUDdayvydPBftZEpnqrfBio9mQN4rfAU1y?=
 =?us-ascii?Q?cd3uaoFJunvc0SdOoXPm5EaL1ReVBsF+FsNhmF510HWUNiJPI2hGT/MwxFk/?=
 =?us-ascii?Q?n3FKWD+TvOAp7R2ZZQMYZrEgmhcmliveHnT2g7OXkmHK+T1bV+pVuKh+KiTL?=
 =?us-ascii?Q?uSxnv6iujHNBX1xvEF5PldBDMP+Sb6y26UGGPYaUvUjkmol4qTiZdGxbr8Ow?=
 =?us-ascii?Q?Fmp+0v7A4nnafAwi2hdVd/KfSYXhioJz+uszZwCEpb85j+IYc8D7xuIWfITC?=
 =?us-ascii?Q?okHSPB4v3USIvzseeVru7kCZcWswuu7euMMOdIhnI5cj7YHY9+sZP5ivh9ka?=
 =?us-ascii?Q?NxQj2Fsp0aJNBDiC1weTLIrNvy1KS+FIzkaEm9/MAkZBlnVP11rTudUgu5bB?=
 =?us-ascii?Q?KdwkcAc0E0Sq38qOANthqaM3Zt6yfkaQfoy0wyq0UXdFpMMV2tRgk9wnrWcN?=
 =?us-ascii?Q?Hj2W7OU7X1QxN1un5zfQaBCsuyvOcEe8d5sxEmq7KAs/X/wLA8sGPoc4od1C?=
 =?us-ascii?Q?dbRL6lG+CaE77tIdtXqtb/JNalbeFWXn5BUOJ+1B973qgg3keBDCnwJQy+dJ?=
 =?us-ascii?Q?qJMTLLnK8N/iyZbk2RTjScmtaf6MQ2NnuqEXX73rLW+70gGOSyyUW5mY4Knd?=
 =?us-ascii?Q?iy2V9qp90yY7jlncgru8qvMUfTPuCVoAwNSeBzqPK6JxMpJ4VIjvHBALHWpi?=
 =?us-ascii?Q?F/F8xfo3aUolXYc5SUcXP4KmZlvSERI6J88QSDvXA/3UKK/2nn+CsKkfD5sH?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c013d6a8-b2bd-49ba-cec6-08db047df262
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 17:58:38.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td+9TtDVSvKlEFqeXAcceXn/f27GVUq1p/DHDkwe3yRawldkjgDwK67a8BhJnpCw/1glE57y70tDpd1pYPW55FAvTQyZ63WI3JcO4SsL/NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 15 Dec 2022 17:09:14 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
> 
> > Not all decoders have a reset callback.
> > 
> > The CXL specification allows a host bridge with a single root port to
> > have no explicit HDM decoders. Currently the region driver assumes there
> > are none.  As such the CXL core creates a special pass through decoder
> > instance without a commit/reset callback.
> > 
> > Prior to this patch, the ->reset() callback was called unconditionally when
> > calling cxl_region_decode_reset. Thus a configuration with 1 Host Bridge,
> > 1 Root Port, and one directly attached CXL type 3 device or multiple CXL
> > type 3 devices attached to downstream ports of a switch can cause a null
> > pointer dereference.
> > 
> > Before the fix, a kernel crash was observed when we destroy the region, and
> > a pass through decoder is reset.
> > 
> > The issue can be reproduced as below,
> >     1) create a region with a CXL setup which includes a HB with a
> >     single root port under which a memdev is attached directly.
> >     2) destroy the region with cxl destroy-region regionX -f.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Explanation seems correct to me.  Only question (and it's one for the
> Maintainers) is whether they prefer optionality here or a stub reset()
> implementation for the pass through decoder.

Yeah, I think this fix as is works for the purposes of the -stable
backport and then a follow-on can add the optionality.
