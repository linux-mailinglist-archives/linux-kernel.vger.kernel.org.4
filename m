Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749F63D7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiK3OUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiK3OUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:20:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69595A6F6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669818037; x=1701354037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kzHwdGZ8lT1vGqKc7SMISFD6a6ntSw8rxNGWWkQpQeE=;
  b=JZUQGWEPJBTSe149VF21i7CQ5EolrdDiBZyD1hS3bhjvR+NTIusBYWW9
   0+P1cA0pnC99LPwB2zBuOU4ILm6vbtuXbrluTyGd1VvuI1E9pgfMbmsAC
   SOgMk4j0PpCQX9upugVIUBQe2NClC08wzocZWxkuajpKTNx7ycffOiSPZ
   WhZh0pPF+MkoUaOvcY1rNPCJGGdu4X9x1psssU8ez5NJP+a8lKZnyt+pm
   BSTcgLDdlUAfEFj3GWvCrxBSyCWnMah36MLegWy9LadgDMpRLbh1yuc/7
   sHFKfc3GjmtoEZdyYcIUVL3Kyw56LtgskBE52RndRZ8fohmMQj+TWOFz7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342326645"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="342326645"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 06:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733002090"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="733002090"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2022 06:20:37 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 06:20:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 06:20:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 06:20:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQlRs7Wjcjd0EAWkCjD/VmJ4GeKqcvJBSRwYWUOrWQloqDHT/cPSa4QeLe/b+Dxm9126Nn9lqAhmP5mj4SIN3Cd6XuvjXb5DXUNNY99RbTX/p8cmOAPE4zE8H1qTpwm/l7ntska9GhbFwrBv2esYxbnWjRc6ItJaitebaSXz8T6EsuV7d+5wFzDFZFn75dQTEW4KVKDq1f+Kh0WKs/cW7hKZRpzXdfEjZJekSq57UWQrTHMlOJ9jsZ1daAxFVK3dGQIzX8azJa/ndBIvc9Ifnc7CjV06sk00Lvpzg2UsSB7gaNF0rvljx1zhsSvkf6jmJSSYwn7yBGO1geFbhXUczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwHy6Neo2jpvm3/OgtdRaH9D3rH/ZgeOiqP1GCJ3b8k=;
 b=YsIIOCQi7b2rDbVlWUWR8NgRtEUQKURVlPp4ShlwPW94ib41CJtuRChrNUYcjO1VHLmLSOufkXiHLpqxtB19wfBjZY52jRpbM7x4ieCNcobklX+v1hznu4F6h1pTmK+lTk0KEG31n05O5fBmHhHYswOj4g3lf4taCflb6xeEqIAPMXgayYkw4EuwUdLfzWPoP1WchjsZwN0Tko/Ve/BKhznNz8a6Ei/hUJiHe1SNLIX1u3Pk/7uh+FQoyMB1vfDUfvC+d8T/s/gbfDNPAY6uJhiNwkmsqqBctBW0yh4nWo9L1lfWKG/DOBA6S9onhmxKWsDAtIIZieArf/Uk8DrFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:20:34 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::f4b9:901c:6882:c286]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::f4b9:901c:6882:c286%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 14:20:34 +0000
Date:   Wed, 30 Nov 2022 09:20:28 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v3 0/2] mei: add timeout to send
Message-ID: <Y4dmrP9RzXi7wrwJ@intel.com>
References: <20221116124735.2493847-1-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116124735.2493847-1-alexander.usyskin@intel.com>
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|PH8PR11MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e125ef-59eb-4fcf-6ae6-08dad2de0b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8K+8lJkeiPFL27MfyJvDwHIgGSMNRpKqKu4uJaNPWYECwzhLbDeRo/p/Oohz32LU3LLLWQqDqcRXWZdwoiYkGI8Nd3DhHbVWpPtoFjRdownk5J9F4IHa13fDxKJKL5vUSsu9KVgKSlM0g/095LsTOcoSdOtjqonWLfyTuDMxdlvz1r7Qps2xU5lzSpVBFNlprM94WY7/M5ctlbsWwFfav+e6ahDu9pHiheGGfK6N9kszsiQCvQSRDcRItS2unJC8KiEDPdAPBqYxe30czW6zlDmRM04cA43wsbi+u9F0DXkHyDHDTalbxcBRPt3j3uhvEMhRLC6iT9n/Dzwj5lwRdIzcIEaHYdQT9nGQ07cdXfTFlePcsol+FAYPmwYKNiHcFeI2N1PZ/+EDP1VfsbXn6EI7dxU3m/x28q2QMcFq7BVjfX1zg/L+n8SWdQBRXMEud6dCN+FoJNyzGdTgCeYbncJNfF8mL3OgaS3ei2CAp+0sfRih2cJJyfGIV3xiXoA0KoTW6HQzfJlUXiyoGnV+K6Fm3xvasa3GHJoCi5UaUXKBqVsURErZoTwmbiy5IV9/qwmzUMFqr8pygbnCJ7b/TxAlF21Nhej0+wMrOaGHfzD8ghexSOl0DNzKKNaC+IsctbAJYtC0orc+YiXhovFxaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(86362001)(66556008)(8936002)(36756003)(82960400001)(2616005)(41300700001)(66946007)(186003)(44832011)(8676002)(5660300002)(66476007)(4326008)(6666004)(6862004)(6486002)(6512007)(478600001)(6506007)(316002)(54906003)(6636002)(37006003)(26005)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?819Eu+lavdhBVqGhvumhuGsGAcXgBqH+YSFv3tiqWdCjikHMfQLYbZMy//eX?=
 =?us-ascii?Q?m5Twd7t1jFPWA6P9R2DmoWAab2e/EzNT6aIfXVdQEZ94w5M6t+TWUUXIFvFB?=
 =?us-ascii?Q?x1z6bt1B7D9vnOxDQqFZlAd7KSXQLsLw2wRYs5JNWqoFPN2WSxqlVpNKC5ED?=
 =?us-ascii?Q?XN99dQBmTsWf3ZMPGA6VgcvwwglzmPZepl2Kqer6e90CBNBbsjA7y3xoYbep?=
 =?us-ascii?Q?LoHCoUyW4r02NP9DdwdgpUCSv4sDByplJPQOqKfQ6vIOxa6zgqwyvpnMtDHJ?=
 =?us-ascii?Q?mQNcUGH62Iib7oTcPr/ISxiQejc3dT5Bjj2bU3Wnvl6RiaoyhwXhlFTEy5pb?=
 =?us-ascii?Q?PMsUTvmvq7cHL9kgtV20uHLZIkU5iDTZsdtr7uD5lBaRDCArQIivNTi2IWTE?=
 =?us-ascii?Q?4XU6uR6usC/CRdrccQx1mXSADtj3LMXBm40DX1FtyrN/GaPOCKhNha9BZDLB?=
 =?us-ascii?Q?JzI/T6HmvNDXLt5oHkt1RSdrn8RmdmVjirkBjdn7Qg6tbVWsXl2HI6G1faQ1?=
 =?us-ascii?Q?hwEtElq4dISD8t58ia+dJQjowL+U61g2HORPVdK2e/TsWVWW23AxA4D/BMDb?=
 =?us-ascii?Q?1CIpUCaJRtc5zgQVsBYSaaoYqTRQ2MtqX7O5UcblEXNFN3SOaFOML0RFgyl5?=
 =?us-ascii?Q?0lbpA5ldQfPy8lM/ijeuRds2OS/hkdXTLqZL3ZSPQ2TmYep5gA36Is/aiN96?=
 =?us-ascii?Q?faoDL7GFk2bMRhu+9fck75Mc7cFGZLdKkpERvRuA+yIZkUAMhocVr6FBn/Gk?=
 =?us-ascii?Q?ZcDhvdnpipdsXPwQ2nUY7vuk2HBnPN67p1h8d6pJkOCU4RhckJLVm8AyHoAd?=
 =?us-ascii?Q?ka1Stg/JB3uiJjn7hX5PCWLw249jqXkoN6p3QuR2ubSly5vW0e4nVNLWlhdC?=
 =?us-ascii?Q?Uck4qS/+kTBLBV0q413+y85Qa6BqCPp5pXrvu2Yg52dlyKeJs8weyDu8/7Yn?=
 =?us-ascii?Q?CB3M/g0JiyJi868VmB1zs/ITehupyctarJcJiharlGtNAWU/Fg1RYKpagVov?=
 =?us-ascii?Q?Uat3iffFED06sETPXjSfRscOAhQV7EBA462eVvqyKdF/tZEtXkafJbV/4de5?=
 =?us-ascii?Q?aFfmPjJAhU6FEiqeZ6CZrEFz5mZ8W7bU2tQniy6ptg84IczmVBV5NeAWW/is?=
 =?us-ascii?Q?6RGqueWLFy0qECsTAzleiNMj0rkHAypsd255fI+5XOfYhAwMVaeFFiUnzvH6?=
 =?us-ascii?Q?QiTZ9J3vUJB0TBBXr0sYtZd62VbpvnT8Gs4uCFdBLFGNllYXv9M0hglJwNvZ?=
 =?us-ascii?Q?BxYT4id0TcdVdIyWeyTTBH10X8SfNExNdjJ5SJxyRS+0MvotKntJJCtOW+2w?=
 =?us-ascii?Q?EFSSP84slFj+H4WoTiAXkJsynxqcHJcKfIwS0zV6+dYz4f042cUR2a93coOe?=
 =?us-ascii?Q?ZhfB6svWqMo3RTJhWauBvl0wodKf69RMrLYkWz7JSBlwYIkNHTNBbjLVj8Z/?=
 =?us-ascii?Q?SkNvgaV3femv2iwcbp+n0sK/VmI4cnALb22Lo9/ZusZxqoZzLjuKa2VOzujv?=
 =?us-ascii?Q?5+adif0+xhAcw6CBeGxiu/USIgqhJ3zuOkTupSZTtn+soIuqtOe6QtIo2g6k?=
 =?us-ascii?Q?z7B/TY/MGyHRzaeGxSR5Mh/jd5h0jXS5UPvC2RU9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e125ef-59eb-4fcf-6ae6-08dad2de0b0b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:20:34.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBvwgpXXMWEdC1G1Bcmrxvyx6+72FvR1T7NtmnE3acCr+pTADCcsucWBVEFVmFcdXh7OVroBixfQuHxXO0QaHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:47:33PM +0200, Alexander Usyskin wrote:
> When driver wakes up the firmware from the low power state,
> it is sending a memory ready message.
> The send is done via synchronous/blocking function to ensure
> that firmware is in ready state. However, in case of firmware
> undergoing reset send might be block forever.
> To address this issue a timeout is added to blocking
> write command on the internal bus.
> 
> Introduce the __mei_cl_send_timeout function to use instead of
> __mei_cl_send in cases where timeout is required.
> The mei_cl_write has only two callers and there is no need to split
> it into two functions.
> 
> V2: address review comments:
>  - split __mei_cl_send and __mei_cl_send_timeout
>  - add units to timeout KDoc
>  - use MAX_SCHEDULE_TIMEOUT to squash wait to one macro
> 
> V3: - split the state fix into separate patch
>     - document define unit
>     - expand timeout KDoc

These 2 patches looks good to me now.

Greg, whenever you review it, please let me know if it is
okay to me to push these through the drm-fixes, or if you
prefer these to the mei branches.

Btw, Alexander, would we have a good "Fixes:" tag for these
patches?

Thanks,
Rodrigo.

> 
> Alexander Usyskin (2):
>   mei: add timeout to send
>   mei: bus-fixup: change pxp mode only if message was sent
> 
>  drivers/misc/mei/bus-fixup.c | 14 +++++++++-----
>  drivers/misc/mei/bus.c       | 22 +++++++++++++++++++++-
>  drivers/misc/mei/client.c    | 20 ++++++++++++++++----
>  drivers/misc/mei/client.h    |  2 +-
>  drivers/misc/mei/main.c      |  2 +-
>  drivers/misc/mei/mei_dev.h   |  2 ++
>  6 files changed, 50 insertions(+), 12 deletions(-)
> 
> -- 
> 2.34.1
> 
