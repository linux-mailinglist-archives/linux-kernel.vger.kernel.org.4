Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14626C8842
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCXWWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCXWWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:22:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E9125AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679696532; x=1711232532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=98yfNvJC90v31q4RMlB2mfHfD+Z/xa4BJsP/hl0Aags=;
  b=eVGs3rRUjC+GjKSWTKU1WfiUpOhDIiENi50W8IihFk+TpFQPeQ5JoAcG
   76Oy6Fuo2rkdW+x3XPbexFfQoYPup5ascAA752yQo6L5UFC2wH8AOTz/X
   3gmmXdrQsWCWkp3cOWNAcFVJqr586mDb8xOJct6E7adCd3pE016Oy91ER
   QuoO9mOHMbgakReI4yYJrZVoELH5CefQj/E0nrsbnyFodRNVxo8cVngFF
   GDfGKOc7sFxQpgLr85xNJYg/9ej2uidDWXvCOCRwo16WrlzcAI8AFWBiA
   /W6yR+H7eEJ6sVYsn8OnJD9ZdIs9hFt+2aNOy7wZmHcrGcr27gYhSc+S+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338619506"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="338619506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="660212988"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="660212988"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2023 15:22:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 15:22:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 15:22:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 15:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfFzOtjBa5A1AqToxL63KG3ZhTODH0YvQDOYwokSP4JnF/L6o013EhgfDtJc49oNGRqAj/T91mcMZrmBfL4p2srlNZ0vkV3WzHwfCOjlfYTFDYejQUPfKTMjb4klKHI9KbcEngIPEmaiCCvcZEPQ0E5oAok/9jFEgJ0iIeB39ALfJY1LyyBTqSxwCYvIRDl96yVINEalBQbwV4w4DnP2j0XhO9LTfokNBx6CZi+gKgNsj7OUYagomsAepT6eHLDSOYNVjqBmXHkTd8W/9xgEYIJXUrJ75PvW6ZHhJS9DjM0lePEbR+cLSIcvJgNW7+3Laqa9hPjlifl7mcT9742xcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYjidNcLQPt6K3vMDfMMI+Vw3K8mg1X8bvdNTrJBqaM=;
 b=HLvBY2taFAO6f6R2kr3RBQZTu//B4HerjurDdy0M6HvHh4t33YhqrRkXt1vjRaliaEFxIAX9ySENnbB+/BWyPmZcL2GCi2ZFdxH9UESg084CdQWt+ZLAK/u6G+vSh+/unt7d1MCx3jlr2i3y2UlY7WJ7aYID4wlx5AV4tVRornKSKzm/4ATBeLD+V3BM2goLottjJh6O/nVmR+66PwGylR2xlWBACwTsbQ9ioHYnPrr9hwc1i08CSE2S0xCxQgUjdXcurREpVamuVWsTC5fiYI7QZWXRPuUEdAo+02rYuz1NEvaEzRLYVMtMZaaRMNEdxhfkdTk8aTuPQZZZcDnSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5680.namprd11.prod.outlook.com (2603:10b6:a03:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 22:21:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 22:21:58 +0000
Date:   Fri, 24 Mar 2023 15:21:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        <outreachy@lists.linux.dev>
CC:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        "Christian Gromm" <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] staging: most: fix line ending with '(' in video
Message-ID: <641e228264b79_325e1f294fc@iweiny-mobl.notmuch>
References: <ZBxL/yqLU1dEQlta@khadija-virtual-machine>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBxL/yqLU1dEQlta@khadija-virtual-machine>
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb70b95-c0ac-450d-a5c0-08db2cb62e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zw/6CwOWpg8kV/FY0bu4Yb9HSc/UZC11FLcfjmj0qEEOzowygo790jtN94zl5g39q/nOf8x4g2fc7jtAQF/u1ObGPvit0PrrndWYd8/MEnpfKvSqsvCgx3n9ve2HwKha5rGGMSKtm+Asvl+SGZWJ1D1+Y8B6KgWRsvPB0OnWxBDdvpFKGzNWSAtyMOHSz46MDGwMo5eWdWIv97b+roeZJ+s4/TkHarhkhwdwVfzWWjOXY0IWiGbvUa0i8Yj1xa3dWEzpLZyjWNKGsTPpWfcSnsvvWu0IAh8STlPgiGejZKKYFeoWHwq28vFT2HfQbjCngZJNvunAAIfl0wz8hbQSZ1CNTSdVRVFJOJOnZ9tMnUcpocvJhOv9cTqD1HBNhXopBG7ur93xI+Df2ZKlIIJMRgAVxrz2s8kUK8UWPct44YuvN5xDKkXbbdsFBpwPwF8hF4Sdtqqiu2gndmi976TRgVBWHvWlGgbEb8ACzHC8IZHdrbvo3yt6Kgq2pqYRozWGfEYtvZPOodhT1v0fa+Q6pOzn7+WbKMPleD+nwWbzOE779f0gy0mlE8qMrMfQDA0B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(38100700002)(478600001)(316002)(86362001)(9686003)(6506007)(6512007)(83380400001)(6486002)(66556008)(4326008)(66946007)(8936002)(41300700001)(66476007)(8676002)(82960400001)(6666004)(2906002)(44832011)(5660300002)(26005)(186003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbJiv+AogSDvcbhOf68hwbbFxi5ofutqJD51buhyq9d/aEihVzA7DWrn3hnD?=
 =?us-ascii?Q?jqyeFaCJtGqM3pA2ydS5QDFdyHl94iGpTW2XUqeSO4E23I/QQK/iI8jmVbBo?=
 =?us-ascii?Q?4yV5s68boCJvDIMR5TvEZu0TghRAp3Uy/e8BT3EshQVV1ehcWh2tJR/Mu7ry?=
 =?us-ascii?Q?lTqNtRWDkWNvafmak/dL0iFgxnJZfRn4RiaO0G0YlhOLxDbSO5fP0SjTdE5g?=
 =?us-ascii?Q?+VAMczYLclOb6PHPEi2Jx8hPchw6AvhlBUPNrW2YII9DZH6zbC4GmRJdPfY1?=
 =?us-ascii?Q?N2ri7ixC73R87drE51dnlYKH+25bMZ86Fj5dYpiXoK9APSlLbpSjO0TUoequ?=
 =?us-ascii?Q?XoFEBCc4mNj2P9/XNzLYIPXu/+82nlFYF5Qi0SYiNca0xpZsHwA3+PnA2FRe?=
 =?us-ascii?Q?DoQntg6ycVzyJXtmOU1aWDwUPbt/TwyOKu4TPz8WeI4vu6QQpQLX2GlM2zQG?=
 =?us-ascii?Q?J8cx/2d1OapZiWBRkqgHqFnq1mGUKDqKj/FY1EZAmjBPzTq30IitGuv8Y6De?=
 =?us-ascii?Q?6vm6/DTK34l30t12DzzG9Nt6zWm12ucG809rQ/amMpHQfhb0YoMzIB6nDbbX?=
 =?us-ascii?Q?QW0eUkdX/T635A1td4VO8IffcjAAzvA11sa0LEiq6VhexbhEteqqXIjPtghf?=
 =?us-ascii?Q?UG6nnhA6enwD5IGzMLjiMKp5KTm0gLp5JaNvzyR2F8wfGqjYPeAaJwvDCAHO?=
 =?us-ascii?Q?GhqbP9KcDdhR/WkyN42kpmDgO5gs/LLfVzh+ChLypVTF1Zw2dOzsf9IjRqoF?=
 =?us-ascii?Q?+5A3/cVVX52WiFwH9Zv1S7RBkDBxTrsshTghzeADLVSCMbeMC3njNdVXk5/3?=
 =?us-ascii?Q?n5oTebvvWz7+qxJH8eF6DsR4Bb63zltX2wVXT9IE8Xy3Uos+xF5osDtxeOIl?=
 =?us-ascii?Q?kypiMwmt62epsGK9ih6rsLSCmwZW4X7M+EX3BQltVgI+zXtB+pIwfthlye1Q?=
 =?us-ascii?Q?vgjz6obAb0hyD2AOyZhwhb+WCrA1r2hHcZBr0fyYWHWVu3++1QHpGqktcWZt?=
 =?us-ascii?Q?Ko0x8NqxXPxy0wsWh60P41l3+cTHL+xoznBBEwa7h5OlpMho5coVW/+rRkEV?=
 =?us-ascii?Q?mvdk/+6knghZDvsGB61lJNg7VGNH7NoYhvbsajHkphlKThCznNKMgupSalN9?=
 =?us-ascii?Q?DXhQ21i/z9VEmUQMthHx4c6YN4noKL6XCiGtLcAQs7IdyMyu+f+NDMz2XW7r?=
 =?us-ascii?Q?5sLGLdIVfa+0gHHs41ikMK/wz555hBApCtDz8mNE5wInh1ulJyf198BIAptO?=
 =?us-ascii?Q?811TM4yiK9tGGvEQmrSLMiPl7QaCD5zXPxOXricjAwekSVueOpIZq+QOB5Ot?=
 =?us-ascii?Q?s8YsLo7DF82Xjp4byb81iZrop0jGD8A9LeecnffxM2Vpjh3Jx8f6gCsZYty+?=
 =?us-ascii?Q?qj41DapH19B3taa8hZhkGNxFzQ4j73Ke3EuJ5xcjqKqGuDolhV7EwnKwTPaj?=
 =?us-ascii?Q?h4C1AYucVtxeMNzlYHPugjsFDtkH65bM1XJ2LI3b3O+8jwMsP6uBJCpam4ml?=
 =?us-ascii?Q?NA8xTSlTiBF9JkMUwzOgnFFbJ0yHTiP9jl3yGWXVNUM1RB22wTZ0Zg3x4KfU?=
 =?us-ascii?Q?SZEks4jdbGghjAxAtJ3XeZPYzGFYVjYt97VkjtxP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb70b95-c0ac-450d-a5c0-08db2cb62e6b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:21:58.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MAHVN+WZ54ctq/oXSDPX0XMg0g7PVj+YtHdg8SYUxKCOVsX5qrzMbsaUJEWUgkpSQiulaOssXm0eb3SNAbd/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the function parameters right after the '(' in the function call
> line.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/most/video/video.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index ffa97ef21ea5..6254a5df2502 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -365,8 +365,7 @@ static const struct video_device comp_videodev_template = {
>  
>  /**************************************************************************/
>  
> -static struct most_video_dev *get_comp_dev(
> -	struct most_interface *iface, int channel_idx)
> +static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)

I know the 80 char limit is not strictly enforced anymore but I, and some
other maintainers, like to see it adhered to unless there is a really good
reason to violate it.  How about?

static struct most_video_dev *get_comp_dev(struct most_interface *iface,
					   int channel_idx)

Ira

>  {
>  	struct most_video_dev *mdev;
>  	unsigned long flags;
> -- 
> 2.34.1
> 
> 


