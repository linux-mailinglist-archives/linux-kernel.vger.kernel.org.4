Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A246D7378
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjDEEn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjDEEnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:43:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74841B8;
        Tue,  4 Apr 2023 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680669803; x=1712205803;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aTc8zcmBGSJq8wQtPHW4N161b26Qx3WyN8yw+TUt6i8=;
  b=Y6lNSi+hIAGkX8CS3HLZ95DWqLgRV+7nKRKX2VZUh2LFKbs/47d2cuc/
   FtKsyxIpbglpeclzNYht525h4ersDnF+CkYJXJpsDTFFQPTX0qi8QmwJI
   k8QgT2ShJGcvJlPGMZZPvJzSt0ZETsxW1ZWPkM0Wj/kzjh9reFZU9GFF6
   aOamnt2Sn8gdAxaYYTXZFEk6EZ70cNG4wduKJSCssKSU2Y1E8HdPkc6w+
   wtC3idAqOq/ojZQzCg7/i3k8MgWoMQA5KN4QZ4wMjQ0JFWy2n9YDQOYb4
   42FTjdBSB52gfa5QqEvpY9f+hqAgcNq0PH3vUGMh6Uk/C9P/NVduBcjXU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339861722"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="339861722"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 21:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="719185000"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="719185000"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2023 21:43:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 21:43:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 21:43:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 21:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBj7fNdO4jKugXHZEJhN5p7s2t7Dx3OQiB+qDLusuzcXG2ts6qosGWMSPNt2L/gPsiL0nke3xSoU5NfQvcjBKLF5l7K+1RGIsh+1Pvw1uxqpWFC/vVh/J/L5Lcy57Rk9OrgZPdCepFCNvZo10ajBqZZFUzbUOXRwawAAQPb4BS6GfSnalQF7tCOrhk20EkZU9ewIqo+z/F86dMIIQu4IAFebugdnHo7Ho5AaBk8GdHn6BE9vNthXKQjHYsupksrkFBdtw74RIkgJWeUPmeNb/9o1WMz/4E/M4dj/okwrydRISENVkVJCY/wk7aQOzucE1KS+StqmTy5Iv+JgaVwj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6KyWFpS2VRmz7IOTzQMfN+lE6zJdedGfx7YUi5D68k=;
 b=VS5uh0118q441jmKwTulg9V8w5TGPEYHlcv+ZKOxEOLX/n19mkGZhUwu0d+XkaXu7mpeWoHagqu9rEM9reQRU7VkXDXFyO9BQGDUXjVfWGFH1Fv4T0C5aNU9zh6n6eek0vDRJS/bzs+fQUqLeF+nc0i97ey+zEy2JT5o8qa0eg7l2lUYcM1+sI8ggL+L9x748RoGVfr/1bIjL3tMKko2Eg9rHW+1K7x4EjFROWmxhEI78KtPa4zXvudajaozojrlXMk46TqgaXQ+VEzsRihkB94EMvpP4Ua1+ZCiccgRCwZeWkl0h+B8xhQq3Y3mypsrhPwQbtVLVJAjMsIxJ4d8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.30; Wed, 5 Apr 2023 04:43:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 04:43:16 +0000
Date:   Wed, 5 Apr 2023 12:43:03 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>,
        Ye Bin <yebin10@huawei.com>,
        Nikhil V <quic_nprakash@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: hibernate: Get test_resume hibernation mode working
 again
Message-ID: <ZCz8V1zwFtoTHCfK@chenyu5-mobl1>
References: <20230405034502.583304-1-quic_pkondeti@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405034502.583304-1-quic_pkondeti@quicinc.com>
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b135b5-dadf-4af0-a5e4-08db3590454c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdpuFau2+daNh7E1X/Rf9A1PVd/kKNO/TesarjRJlqd/lTLJxm8sl9eNS5yk4EbtMkMtwNmDphgXjli7eTqsUO8vGQ28e3K6Px9D3uzwNFCL6m5EhAZ8uzSRvp7doquwHCggJw+c8+ZF/XHi0+3AQ5bvYz8y/XLSSyjPi8atmYwKnMLZll3uRpIQAACR+O49Usk4ddu+PVlWWDDKZ9JhW+krf542JzH9SlAIK78vWn3DhCeUQ7vcexfGO5Sx1IpoZUucAOX00ern3xdGPXk0+aABBqWiOG8eCCU3sZpdKuoR/XsEXpmCDxBeqy2zJt9W59nT6JwtLFhyV7sL+WfwlEEXmmxI/o9Aqx8OPE25TEvbzFyXU2w9dNgdEmqzvecuIRiBMf0YkDOAdUepUufiVwKl0Vr73KFaTTc72Y3GxK4bTb+DaiVHjdzvdcatGiUqDt4sKAoGf5x6pH40+xtXy7NFUEGJVYR9hG5QDePxKtgMTF8MdtEBpfDDusbyTU7mM0EGb4qnhK9Hs598x6DzkpTfYlpP+aBl3GgISOkCT5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(9686003)(53546011)(6512007)(6506007)(26005)(6666004)(478600001)(54906003)(33716001)(38100700002)(66476007)(86362001)(66556008)(316002)(66946007)(4326008)(82960400001)(8676002)(6916009)(83380400001)(2906002)(41300700001)(5660300002)(6486002)(966005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQeNwZd7DcpGVZMECt5NgMMJSgwDZZb1PClYRCW/UGSmd2Npi7iTu6Jct7dJ?=
 =?us-ascii?Q?55KxjJqHjFeSALDrSbROP1QoHkgT707xWUR1Akgh7gXhh3pLVW12V5ntJF0F?=
 =?us-ascii?Q?nBsFrB/QG5x0EeKoOyPrlXmCaip2z1E0Fo0fYQgloHGWYQGZQ0cNB4Rxq1cY?=
 =?us-ascii?Q?wNnzvOIW2u8MOlNsxp4YKRjTYvqC1rEN1hLvC5fGxcc9mhY1rid3KZcvthvy?=
 =?us-ascii?Q?/AEQiIeigRbBwP+7V4l2cxwr4+k93sYWMzLyjoEd4wuHs/TJhEBBhKxk9tIo?=
 =?us-ascii?Q?s+3tJzsV0lu/IS25xPwdTCCfOVv4Zv+WuqsfrM8lpxY1+vV/6DPiSiHtram5?=
 =?us-ascii?Q?u6bPXkgg2ITSu+w7QOffZpYo0iWLLL/G5nCjIKu/Wex047LqVD0a+6WF35rw?=
 =?us-ascii?Q?nwE4U+cfNSicXBtfHqhIzQIJSmWirXqX2m4da7NYyxtcy1cjJA2lvqlpvLO/?=
 =?us-ascii?Q?d2wKAqwtL4qHCuqu2XcPos5Wz/qVUDF1ZpEnErsZHLdpB347rrSmziofYED/?=
 =?us-ascii?Q?zWABz2rrBtPWUueWfdJtBOY5rRaWlYKww6lQA5Ja0X0GpfTdoIxBXkMLfWxO?=
 =?us-ascii?Q?WzyLxY7o/qpuvdhgVNLNRsjnot71RU2HtVWZjAqEMPbnH7vxcgTqwEYbZ/xW?=
 =?us-ascii?Q?9krRGzag4O7Q2nbPLolTmh+z6HQrK9Y0IdKc2hdRpUaRNkD34t4xHJvs8Wev?=
 =?us-ascii?Q?YRFOhjPw1/aE4XI3RYHFTh2UaROqSkM+G2lFCD84soGVlJfSzJmresarR0U0?=
 =?us-ascii?Q?QWhU/ZiAdWoRmoaHLIfYltlNCSKNh8+0vEt5zp1EGo8pchvnCt+1c5eFjLhw?=
 =?us-ascii?Q?iT9yDURJU9qc0BWedHIL4Y/zPiPEEMQA70gj9scGL3cGOdwPIMT9W3m90wwj?=
 =?us-ascii?Q?W80/E302cSOExGYXsvnYtWiC9CwaaZVHHG9Eftxs/879CnHg+N/IiInnKgH+?=
 =?us-ascii?Q?773GgSBIYSIC9kew77hdlGHi/Iox0Iz/xISGF3S6cexchM5e3Xh1G10OlGzM?=
 =?us-ascii?Q?Yo2KQ1u7MuosFOpYDL8fnPS/ifOdqNqhQkopv5nkcObiU2rzik25PJr7ryTg?=
 =?us-ascii?Q?EokqHtMLVfa5Arn+NT3zXvKX04w8bCiWO8mRdB09M/0j7kIB8MBmxpbVEkIM?=
 =?us-ascii?Q?gV/EBqGqxI/d7mgftr1emh51MF4ycgZvLT0zcWsbA0KZzszJo4vSWM8i2ftu?=
 =?us-ascii?Q?SMOm18pjfE7PLMeL9awH/5ZpAD0FLCMJhrMlfZhbzIB4ghkELOy2L5ssO20h?=
 =?us-ascii?Q?E/q0zpvHS3ouDpQOTeTGfrS54iM/Oy5PbJXKVRj6RMfEuzMC4WQeqUhZhlTb?=
 =?us-ascii?Q?w4gobzMyci5JMRjtxLOissZQpAnViVvMCss0El6OsGDeE5Xe74hQWv/3l36r?=
 =?us-ascii?Q?LPhWuqZ/nn2HwJqx1L04PYr+BuIAG9KzE8sikn1lfs7ohPEUcYsZtDEkSz0D?=
 =?us-ascii?Q?BRk5sxhg5qdEkSC5zE95sh1SEb46u09NgCPEOVY7ZFfY/pXYvTQv8HnOBVzX?=
 =?us-ascii?Q?kD/GOVNWlDrmqxolcr4rkzIKWEbL8RLTUe28xKkD7am6rpA7LxYHUfcxCLfM?=
 =?us-ascii?Q?htv9XKHTjtwtJXJsk/KIOJyeazjrrqy3pGU/UZ/Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b135b5-dadf-4af0-a5e4-08db3590454c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 04:43:16.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1qhjMEdBtswiPwoJalrxKOs1802HbLZwgGRdYEncgQ+Osigbe+BvjTUT8vMcn0gEnpMJmrqPWS3QhTkLo4xNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavankumar,
On 2023-04-05 at 09:15:02 +0530, Pavankumar Kondeti wrote:
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in
> swsusp_check()") changed the opening mode of the block device to
> (FMODE_READ | FMODE_EXCL) during resume. This breaks the test_resume
> hibernation mode as the block device is not available for exclusive
> open. Because the block device is configured as swap during hibernation.
> 
> Fix this issue by opening the device in FMODE_READ only in test_resume
> restore path. Cache the flags used in opening the block device so that
> callers of swsusp_close() does not need to worry about test_resume vs
> normal restore.
> 
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  kernel/power/hibernate.c | 21 +++++++++++-----
>  kernel/power/power.h     |  4 +--
>  kernel/power/swap.c      | 53 +++++++++++++++++++++++-----------------
>  3 files changed, 48 insertions(+), 30 deletions(-)
>
Thanks for taking a look at this, would the following fix make sense?
https://lore.kernel.org/lkml/20230401165540.322665-1-yu.c.chen@intel.com/

thanks,
Chenyu
