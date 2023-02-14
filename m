Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CBE6969C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBNQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjBNQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:36:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C2222CB;
        Tue, 14 Feb 2023 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676392565; x=1707928565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=53h693cXNy6dgyuGalXZylJbfFjz4qasabFF50VwdC4=;
  b=aiS95fmu6f3qqIF7rv3uqecpILVSbv39MJtMZN0T0mh9ooeCocr0EBpU
   QpmAO1gbT+GMPXF030oS4eWRSZ+A68eKYWuLuFfVGFIYE8hc5nxRExcYL
   dIqrkrhxfdYaUxMLlDgY7yILk4ZYUZqefT4jz1E5MqI4taUjsPeN3b8aj
   kKhBxcW3NlFIYoZ7Yoz7Dsov2azHQ0q+taZOcoMIv4Sqbs+QI7SRGBwJY
   u6C1oCrGDezAHcBCgHn7j068Vpp5ljMW6m7AEhXW5H6vb4cgh+YQLqF1Q
   knr/+uTvRm1EwRuXHojV8U9zNbcjSAcYSrUMqQUwBYU+uGv37jv2joqvI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332512892"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="332512892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 08:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793156120"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793156120"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2023 08:35:54 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:35:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:35:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 08:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRRXs6+YRRYBdP6vaFDRy6/axSGto835dtauSId6BPGjz3EWqOIFYgDcPgx8Jha0GXJ4KPrBBjiYzTBo9Ea5+Bl1ygDbsykJSRvvEHHZgYeMGaVnWabhsmXnciL2OoPtzrs4xPf9QEf4mEa+JoUw9JIwdndjX4djR/qYQ1qHsM1rgTAOgFd6oK6unFm/VhqFRMK0apFSRZKcYAf5wANJ19QNFyyslYPOsryY/0MHmH+NXRE5i3IWOa2AQPN2sdIpXaIfby2aLc2q6fQFYXnMzNfvQ+aJS2i+DoXDi63vnOM1TSTBA+y1tKkCCmETtGCFh7gDh2NzejzwBFbGlBuzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt2bTggYOZyUaCS+QVWAwngywKQZzuKc0p0op+oDOT0=;
 b=FE9u4dfoxjIMAaRzKcF7+Xui6M6emW/uKmu6Htp7P4w7CSze449zNxz1lM2UJcPUH0/DOS+meGKshQ98jKJgq4hNISemCoAH+2OFhv4f3Gu6diT8hEC0Y3tdlu+KK7wcCR0NOBFwRUbXMVtRoraU/PM4cKDy+sczYRcwazUB0Ql35SrUK+s3U1+XiAmX3lTISOsrP9nMVPV54LZnnZQb9AfyBD2gwNR8Ld5+4oY03xF9mDcR7+muaqURZ/i4dUtrp6+WCkj+hAGioSxGTb5goNTEbs/ovaQ2HFKl1//W9lTYFdubni1WYvjZBtkHw1ZRfSk2W7/4EoAUhulpLYXNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6746.namprd11.prod.outlook.com (2603:10b6:510:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 16:35:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:35:51 +0000
Date:   Tue, 14 Feb 2023 08:35:48 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Dave Jiang <dave.jiang@intel.com>,
        "Dan Carpenter" <error27@gmail.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl: avoid returning uninitialized error code
Message-ID: <63ebb86432d39_32d61294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230213101220.3821689-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230213101220.3821689-1-arnd@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e68352-0366-4c23-5645-08db0ea988a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iybOeNXAahW6YpU654OOP1wJNUrlOoAMw2bi9P2ZqBxRnhc2/So+AFm+PdKOFDcyKPsvMWdWL9a3+D+g7mABajH6lR2luD673QbTCJY6rCPA0LK9XigiynD0qFtRMaWk3u/tstsC6BXpKPOjaO9BFydZ7THHnTmoQ8Cqc/XbGoPdU6ZK5kmyIePOk+UTsP0dqjgiLhL6prw1SyIC/gNOEz1uVzx8ayc+LkRUwCnR+beNkT/LKI48JmloWxT5nDKNicpshYPW+qA55TntgAU8lWJEIUEz4WJ7njyIgYkv/gIFSsJj19ngKgBr33Wmyyl8NRVLzFgaXukR3YQlMf40RNcizOCDiM1czoi+Md/GCgs02htxignQQYLQj1L+znf5Ukgy2qX95PqN7RCEm6AWg49OEkXYqqnn2+MqYqckiaSCtQQhcZOtg8cvLQkQd9XbEc9ULiMP7tJbTKcWWEAt5zZf1txy1wojoYTz/VZ25vm9W8J677DU9nb+CNh3kFbRvw/DHUZc0R7yFV203okeD4663ahyy9GwZz3tl0RFUQjbP7+LmwXDvQwXQbaw2PM7BgBJZXgFHf/vc3o3y9/+9Ya6P/fN5cLDoW5pjPG9+acnAi57iVm5czVQNQWm7cZBMBpmuyYU9tCGfvZPNjVnDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199018)(186003)(5660300002)(26005)(6506007)(41300700001)(9686003)(6512007)(6666004)(86362001)(38100700002)(82960400001)(8936002)(4744005)(2906002)(316002)(54906003)(6486002)(478600001)(110136005)(4326008)(8676002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MPtG3DPEjUGW8fHYH4/KGTBgBPaQsvQpql2IzlQZkinI7psWFEMvBx6nIQc?=
 =?us-ascii?Q?RGCGmnxJCvyrMKJcUdGXsCmK0vlHG36E4P0kspeA5YurCr0ahwzQgUi1DbP7?=
 =?us-ascii?Q?N8buSiw3Un4LOCLzL2GNfRM++K8knhGe3/BqTLkPbor4sUjOsoWGep04Y7vC?=
 =?us-ascii?Q?vj3RvyJnRJZ+sEGChFzXOLYzpcERbO/OJBRp7SbUQWPVKTZXC/DF1tbrdqr1?=
 =?us-ascii?Q?Y5aWBQ7voe1xrW/Pwhl9FdgP0X9S+kRRPS9ct9reH+5e7ELqTzTu5Qm9lP4p?=
 =?us-ascii?Q?mFZZT4ssoUKY+otoMtXXRvIUySnr/Atjwpq68T1lWo9wBkgyc3EfruGAzcyi?=
 =?us-ascii?Q?HlaHnyidvpivT7M1CgkMx1Cwaq5sl1emc49/xwENL4fR6sYwPHsm8kGs+aRZ?=
 =?us-ascii?Q?fUxTy/a4NnnDgJJj8DAZIQi7nU4pPNXbVODcJqluXJwPBsN1ow+ubMm6+suF?=
 =?us-ascii?Q?7ThdXU35T+w1K33l1bOI6evFAsptFsZh5dLXzaFRNmep6XhaLxHQeKWRJuMy?=
 =?us-ascii?Q?45MbWLKrF3XRQi1Rvsu2XaYrGw+JWwxs80qkT1424hjQetfpF6WDJKRB49L0?=
 =?us-ascii?Q?2tPRqtJW8fHQpQz+SAy72x9wjWkWB9oWMDL53dy0kQK6LDz/WvYETrjVRTMG?=
 =?us-ascii?Q?CO51UTM48aX3QYWy/ClqtXjtD2nWq15RXG/zDZ/KMWFTQkMpf/bp4Pxc9fWX?=
 =?us-ascii?Q?JMisf5eGsJ7X29QXAKZnYxKcWKz+H9kBZhCH2o1+N0m6Y+wjoAPyLsSIpbRs?=
 =?us-ascii?Q?Y5TSfnzLfdktslKWxzvQIAfNdwWwF973FVnUenxEnisvU6tmVl3HWuLPOkED?=
 =?us-ascii?Q?hIS0p/tLLgmpUtPNyWfp3gokhEQt8t5v3l1OzosdF3Nws5TnVRQUDA9F2lwe?=
 =?us-ascii?Q?i+xsUiTJPHvvlCS7wyWVvkcfQkgA02XnfGVWt1jVQaAT4UMd0ojw20LVf3X0?=
 =?us-ascii?Q?BDYVo0wxM9dRYWsFOuXEtgTFoDolDvOXM2pvSb4vnNaiYrkTpgPshfH0b8xN?=
 =?us-ascii?Q?NGpKwCan6mRyZRwwu/l91g0jjYxdN+I64ItvRA8/qoZDc5x5FKU6PDSnjwLW?=
 =?us-ascii?Q?qzh1/kHk3R6Ob9XfbpdhPC6BW2DCLPyEBoeKcomWM/MGu/3/p7Oy5t2bKuP1?=
 =?us-ascii?Q?IIlDY1k25IpAbOPkjNGYdAwAui0uhPyUUZ1XC4jE0BknfH8yXyyYPY1bZnIs?=
 =?us-ascii?Q?kzE5g5qTJfp/40Ot/UKT5awuYaUAVkLDi9x0W89V+5EvXERFqb68M712s5hM?=
 =?us-ascii?Q?7M4h8EVQTmTeW7jUPs9847huRsuPO4s2X99rURvJEACAyqQHaMi9JrcWZheq?=
 =?us-ascii?Q?YzCHc0+m5a43A2N0hrwGlVG8LFmCTTmgtsYsxTVt1UBFQdAzMetVgB5vNDVj?=
 =?us-ascii?Q?SLG9X+PBqMETLp2RjosdKErmGY1/tOtPFoETFvtjqsBjdGXJ9Ji3Kqj3uuyT?=
 =?us-ascii?Q?x6xuj3hc5gcfjj6ID4aIUtuqIS+c+KNA2LcPMAHuZGOS+FuSVBojCZgMY5RD?=
 =?us-ascii?Q?9YC4HOSD//t70eVe1DFFjwNRQ4pzxV+9NoprVQASXqlQwcAwQ7Vr+t5ziLGE?=
 =?us-ascii?Q?R0DG6YH2aPhTwS80tNLfkJF4paz0q4EmN2jooMdnZV2am9FO4FHjkMf7VcH3?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e68352-0366-4c23-5645-08db0ea988a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:35:50.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrpj/4PtC2KM6RPBIsvcaH/ht7iKt0Bb1/Ec1BhMWwYAyu2aNx3UwbDAR2t7YpfIpSYF5ofGTZTSvsa2p6wSg9k4JOKYDUsjD/tn0+QgCsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6746
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

Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new cxl_add_to_region() function returns an uninitialized
> value on success:
> 
> drivers/cxl/core/region.c:2628:6: error: variable 'rc' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         if (IS_ERR(cxlr)) {
>             ^~~~~~~~~~~~
> drivers/cxl/core/region.c:2654:9: note: uninitialized use occurs here
>         return rc;
> 
> Simplify the logic to have the rc variable always initialized in the
> same place.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good, thanks Arnd.
