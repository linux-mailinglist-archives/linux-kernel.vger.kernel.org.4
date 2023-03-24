Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DC6C8833
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCXWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCXWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:18:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277BC2132
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679696296; x=1711232296;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=siFUZ4Mtlf/XEXiRHgczaDRnYBz6B79l05r/ARSH9LQ=;
  b=Wud/MoOVqIV2eaczCtc/GsQ1TxjFvQS2yrBJAR/eeCkQEnDywtRGRD+o
   kxULi2m1ripLdD08uVDaJnTlQ5EV7nZ2aernTkh7LY94pZcPyibZcDckL
   n0CA8QvKhdUkgCA+MtMBdNnUTxSOPkGrk9eGLP5l8p0baCL5KnlNwNw/P
   D4Ehr3HtOWMWIhBM425GMKQcnRsoRECwpcDr6sJSHPXfzA41u6nR3vEQd
   2uXx4F9hNlegeTtwCUqhba7iRyfZDmgXjGWDEDscv1RScmJXGMn9rkLMB
   9EiO1jiRejeNJJVsF162YB5RL5/5U7kwkPFIYooX+c7pdBkM01Fiv2q14
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="319549184"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="319549184"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="715402739"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="715402739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 15:18:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 15:18:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 15:18:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 15:18:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqtuY2KDGE/Qe+iwEGu0d4qi14HdA5idtGdt6hnapu/R8Q3vf/xQyQuWXipglZNrrTpI0S1oC0O1kmY9ONfHm9jv+MXQFK1Iz5c0eGtnNiz1LBHdN6JRWD3+WV/9Zs8lBnQt+j5+pV9eO4HZi6i7kJPXVk1XQ4saVMhoMDnSJ/jxKXl9de/7pWpygUbDcWn650Ae13PszoheuFSUj45lR5p8pssE34n/HyZb/lGBbkcogK0d7MJRV5QMVqqtcqA4hBGEBLuoHl5yrw/vJd9rHa1H6qYNsaCiESI29cjrTVQYVIwPGv20Z4fLjumKTNpelxtnEB4gvpaRy/2R1ODAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDZn9FD+eal2+SfPdtxr8ZX/VW9pvwQvxZf3akOlGOI=;
 b=WOFVuzQB3bUHFuJ4pE2U1nQFVIUzVnUoZ9phzcub2SM58Y2TPLRgH2QHKcEcl43kwa0IpUCTovhyCDcwjMp4hrj2tTnbN7DKq+DQTN6JC9cQ8CUyUaOoSUjR+oeufi4Mw6medJlV/jErfsSS3//Q7r3ptkRVVhxvQmUBhmyEp05q9G/2Z1ZMclbsftIlv9HBRJPYSliW5WUOPQS0aP9zvFe4T0HFXmQ3RmlHay2O34DYYz9kbJxfbxgccE3rl29Tipb4mZGGbwiprr7kr/OIij2YLg6goZWOCkYRYvJeqplqltsWXNMgwWtKX5JlvVHY/CQMnPtK8hGR1Hxv+WG3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5680.namprd11.prod.outlook.com (2603:10b6:a03:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 22:18:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 22:18:12 +0000
Date:   Fri, 24 Mar 2023 15:18:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        <outreachy@lists.linux.dev>
CC:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        "Christian Gromm" <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] staging: most: fix line ending with '(' in dim2
Message-ID: <641e21a1235f6_325e1f2949@iweiny-mobl.notmuch>
References: <ZBxLT4w0cKZ/aOZo@khadija-virtual-machine>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBxLT4w0cKZ/aOZo@khadija-virtual-machine>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 3889da08-688b-433a-d8ed-08db2cb5a7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PcH7J10KDVTuEWVWXar4pplcaIwQw543RWQ+Fh152PNRj5mSrm/O/jy9Tw6f6CuHEozvcR6aE1GEIZ1/xvVQUFjl0Y+U2/kHAcYukCOPy8dWmQZe08Rzh0ZMXrXD3lH7SKJYwFSk/k6iFrxmqyPXStQ+kgUzcvsDMWhr5+EDKUi0g+mRCxC4P0tQ11WLdsXC+4KwuXlurBIBrOQEJ6W/WbjQOTX6ZV2wSAWcFjeDW6gDZPsZbCKQAP9vnJ3JpqT4PF89ndRkwjkxLxTH0KDoTkbo4064FeT5T/c1P++b9oYF8wWuA1SbVZ9hwTg/6k8j0II3c6F1DJIfpCty7AZgazDAJYYQDgpLXejmR30j/UBdwfzgPggRMctc9DzZuRGklK6J747q2GFHIaE/M5r+ZcwsB2xEPoEY3ejFOSqoJaz0LbH3dkki9MMPuz6VJNKavd/6HZg6scqXjU5KaSLFi22dy1tvMxArC2ryWoya1dR3kPwkxZKmS7dKs7VVi8u201JwOhr5uwZeFUZ0P/ciq9NrseWP22L2WCJUmHLcfKvgn1QVwTobodjVs6fb9B6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(38100700002)(478600001)(316002)(86362001)(9686003)(6506007)(6512007)(83380400001)(6486002)(66556008)(4326008)(66946007)(8936002)(41300700001)(66476007)(8676002)(82960400001)(6666004)(2906002)(44832011)(5660300002)(26005)(186003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kt07X1UBsLyIS7+cOHysdbQ0Xx8a0pKRmLhWo68Pk865/jw0X748M6PJERX5?=
 =?us-ascii?Q?iX2p0UHXFUy48y4up5EC7xZDQ/niAjbFhpiRvVaKy//VwwycZtifgfmW+sBk?=
 =?us-ascii?Q?1ZDqD/11bnTJabYihP+6U3s6qSkLzOvPCi/KOS7ibC3/pHGTil4k9Bj0uLdN?=
 =?us-ascii?Q?mXdmNFPLWRp594x9v/PXDND52vvtiDxnIULu9NrlK+3ZqlsbpId8FAN+UsDj?=
 =?us-ascii?Q?ZQjh4dfFy8MBrXqCjzIJjX2BSWnfn5KANKKNuXshzm4Co/Ur00qmpzZTQt2G?=
 =?us-ascii?Q?xBKIlyq7dvtAC7mEXv3aThLRH4zRsMh73Cognzz7/Su9i1lI0HxS7m4RTy0E?=
 =?us-ascii?Q?4XydOtqQBmkuQ3ZxhVBY1XFsmSfdxhqh1C+3JlqpEgvVXdCaL1tZeVvKIeOW?=
 =?us-ascii?Q?W6YcrSEfPuO9fRCLHmmdxPXn9wWTpx4F4FhwWj23pRi264PEIG70mgWM+u+s?=
 =?us-ascii?Q?wy/knEb+J7wswAEkfobNuNcd4QoWkv0BbJpOl719okhlev3cG5G4oIEkhF+m?=
 =?us-ascii?Q?SJUQV9FyKvlLi1REIg1tt+jrG9ZWaZ7q5R6SWO21ANgHKarMayAqoEuc9g2Y?=
 =?us-ascii?Q?vDX6D5KODsA30uSsgBkRxIt/6z2JtMinS0xCGUIBeMvfpZGzif/4fcYrk81e?=
 =?us-ascii?Q?ESuE9oXVrew7nkGKegsHmswli2zG/iKipU/0TiIikpPkUZp1jEE3ktkMfXAm?=
 =?us-ascii?Q?V2n6HwMdYOR9ajNrXVfzFJ2o0NvUYa3NEalbtIQY4u3X69lrPls7OelpuoVK?=
 =?us-ascii?Q?Z6Mxq8eivSk6oSfoYrye4IdtuN8g+5ztuDb+k0riX21kTVJ5MW3dSwY5Q2/R?=
 =?us-ascii?Q?YhJT5PAtjBnwRmAR3YzMw/86sgm2mHyZqNyGyN2wxxQwIvcZqnLw42rW51FG?=
 =?us-ascii?Q?TkkDtknk3fm3tx1BQYDjp0ZUkNb7dlwSLC5rGp+HJf0ugf1AmywOWXeGpI4Y?=
 =?us-ascii?Q?+lqe2tMac99Y6yQdl+3Y691/y6AU3JFw0dRbcC2xZDev6Tp/yujcxpFc4yzL?=
 =?us-ascii?Q?8WghUbrtD6EaFafE1aZv+yiEehLczczcF3vpxvArbAaPHoJKbNUnExgX8+oD?=
 =?us-ascii?Q?m+ViiIPaY/Rlk98c4touTLUiulBrwqr2C0PtR56ZvWMfDAluKZAukonsgHc9?=
 =?us-ascii?Q?mIoj7CC80SIfhOynVzX6p8HeiS+VvqyL7FYqfDjDW59nSVh/ssFq/EkHJjfO?=
 =?us-ascii?Q?Cusvq3RQcpvdbZm9b+gS6OiMaIhEdhnrJa8UbIsPIeuEkDFiY3YcTQiQ/xX1?=
 =?us-ascii?Q?JndQeCVEYPuQDPufCapPyaq9OL1bOGhqye23jfFFebmAHPO2M1VPr2ulhinj?=
 =?us-ascii?Q?O2PL6vrJctPT1NoJEV2DId+HgV5x8cYuaIiPxjgya6BWe4iDq2+H+LXIwcpA?=
 =?us-ascii?Q?Z2sTU2ujldJxHUGd5l6wZRR0a9fjg+8/uuzssv4rlIoxckojZTrrmfDU5WIP?=
 =?us-ascii?Q?yF/yIBa18+j+L13nLVK7E2oGGBSMI9Uduwc296ZG7a31rxeX2fZzt3EXJ+Ou?=
 =?us-ascii?Q?gqhLbCjB68siGkxMwpl6MtB33MPkME1FiYUlNB/KHSAjX8KpC291wkg/Djzu?=
 =?us-ascii?Q?vhNnl1SFp0L7lqQwU4W1s8VF8LyuIS4czjTw7XK2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3889da08-688b-433a-d8ed-08db2cb5a7bd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:18:12.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xvtNLiTPIDwLyRekH9wIShY0xBr6tJCSlYnLDSC2SinOrZyJkNInExHcuyBXSjQoOptiX97KpZrmRgmg6QE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
> line. Align the rest of the parameters to the opening parenthesis.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/most/dim2/hal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
> index a5d40b5b138a..6abe3ab2b2cf 100644
> --- a/drivers/staging/most/dim2/hal.c
> +++ b/drivers/staging/most/dim2/hal.c
> @@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
>  		dim2_clear_ctr(ctr_addr);
>  }
>  
> -static void dim2_configure_channel(
> -	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
> -	u16 packet_length)
> +static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,

NIT: This introduces a long (> 80 char) line for not a great reason.
Since you are changing it anyway how about?

static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx,
				   u16 dbr_address, u16 hw_buffer_size,
				   u16 packet_length)

Ira

> +				   u16 hw_buffer_size, u16 packet_length)

>  {
>  	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
>  	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
> -- 
> 2.34.1
> 
> 


