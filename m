Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345D726393
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbjFGPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbjFGPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:00:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF110CE;
        Wed,  7 Jun 2023 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686150054; x=1717686054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pt5ms9kx4PS6rMn8iPLLbgnSbFdoUi95+I7fiKU0RQw=;
  b=nrnQk9u8AwoEbkQZ9zNQb8ISDv4G1oGk+J7yDa8LMp4iGqnBaIKNIchE
   NZkuBQZ5Y2fsTQIgO782mowO6nLlNn/4f6VjLHBd2mn+6uT3QIbvTQDo1
   B2+fUahlO8Ilm2N1hx324A1pUY0bhR8Jwsp0pmpSkAc2fnqfDiqauG1gf
   TjaWxm1yhx4jLObShVSrVHkPHiWW2aH1jCahpg3VmdXSAuur5cECyFUkO
   sy79W2wFd+YMAPqG0LxfcZDx+vQ0MYvB4p+cnHHTf34wZ86imdOqLrFcL
   WeTGgrFy/YTlHTgzIoSzhSG6bCVs6gkdGDwArWJZ4GNewf2bnyymlvzJo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355864339"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355864339"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="853939070"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="853939070"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2023 08:00:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 08:00:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 08:00:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 08:00:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE8QtePFvYu8HcbCRXScwQzP8dFLi9GGzkIWld62OMBMf2lpiPx54rx0FCreAC/gQEWhPbn2PKWo/FP75vJugadk5st/6ReyZJo6Mzmq60MvHQ1jFBtNQRIKbjT8NfBgWlmlwSkgQlqZSuH95KZ95dVf9wZ3wVh6SguZWuCXOqkUOmJcz4KYcg23YLu/XlgJuQ3w71oaXt/MXXdIOnf9rIwnNhgk2EiT37QVeyDX63NugvQq5z01MQporFIksPeLCKQ4dkP4wGdovEqr8pTjN3Rhj2cCZl8OUUM2Z48rLjl5fhX4JBq4+I1vD4ya0heKKzBTvli0JVsKYv1LcdyqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25497L0MCKCymRo66dUFtE15DFk/8u9wUVXl4duNs2M=;
 b=TPGTubOhhDazHw0KrTUuayU3bsYp1TqTUsZNAStM9LvHL5v7LwkBBYnBRrSz2iRbVOzBaiPutei4/Mgg5Jg2FyFKJdQMnUW9XL0pa+Ln7g6izbxSNuWgVT4ve+4IxFrTjcdM47tXYcokCsyczDYxQN+jZNS+/bQPpiJH3Oj/kDrhI0I+K0LsXOJYVxFuQoCxxqHmQu7rW384rBa0bFYTFF7TGaIxMK1w3do2rSlDXi7kYc04biwY/85HDdcgfCcgry3LP1Oxll0C8uVXzxb0R/rgA21Xk18kNdm6kaH2w790s3wOL/JCyfyJHhPDUd+UtgnNKY47PtLygiVgM1aGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 by SA2PR11MB4922.namprd11.prod.outlook.com (2603:10b6:806:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 15:00:51 +0000
Received: from MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf]) by MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:00:51 +0000
Date:   Wed, 7 Jun 2023 08:00:48 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Message-ID: <ZICboAIZAcnYzyJr@ekohande-desk2>
References: <20230606231844.726272-1-abe.kohandel@intel.com>
 <20230607112711.alcspwuwpt7nqja7@mobilestation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607112711.alcspwuwpt7nqja7@mobilestation>
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To MW3PR11MB4729.namprd11.prod.outlook.com
 (2603:10b6:303:5d::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4729:EE_|SA2PR11MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a0745d-15c5-46f0-fd60-08db6767fc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JN60gxccib0AzXl9FUHsdvklrhgM0hXfzRw5brBaOqlqXroKZms2dH8GVwmIN2DygsPfycbrtU+z9SYejDO5sZ+sUlUID9BGwCsAiabkTWA1NmK1xQVvypaG+GagKm7HTPTSUL6UW1nj1STG4Zq6UugQdMQRWckzHJfeAF24Wjt8mMgv0Q0iAHNivfAuFsecUdaqdbJKuVn+T4Na664kLGXha0cG/ZK9kStUyy6dvmmHFgRICqHOv8xBfRCLHfiK8+PeZhpgaH7kyiKfC2rcXjQsW8wAOHracZAlOVUKgBSkVIiZEScIY7//luZWO4BQQwAnHO2q+PytN+kG3XBoIVl+RkApVpsGLbVLIh0urExilJXeOcabeaCWNiMfXFrIQ4dQqt+MZ14zxCZzckzmKw3oHbE8mn0tv2unLXnxc5ceFR6Fl2aEbMBt39xLTR6rWSJ07MXZftxUR7R9j1uXnvLXbbnB3h4FOXzlCQEnBNcpN02KWgEbUgT385nmaOAN3PpLpSQ/xtRnsAMxZnXKHnYzIRNlCmzXYPSthd/Nee0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4729.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(54906003)(478600001)(8936002)(8676002)(5660300002)(44832011)(86362001)(2906002)(33716001)(66946007)(4326008)(6916009)(66476007)(316002)(66556008)(82960400001)(38100700002)(41300700001)(6506007)(26005)(9686003)(6512007)(186003)(966005)(6486002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjKJPdGJ6GA/X5Ks3a///hbrWYBgiRb3cNprwAjBY3m9r+IW55Qz71vv7YRT?=
 =?us-ascii?Q?6tQc/z/errrL/hvO3aA4h1mXJJJwNSJBqitMZ6mRXE7kPFsXaIyGsm76/UBB?=
 =?us-ascii?Q?tXPmKenE9KYeVAxlV7kb4zfQ7jMAYdzPjLcaXjNmef+uiqIleZxJzBAQOLOm?=
 =?us-ascii?Q?NsAZ6T5v0Lp009ezsUw0xTWBwXdi25SfEPXfjdFkMwhIXUWN5JdKTsP8jJ3m?=
 =?us-ascii?Q?yJfFTLPudBb7SJhwWWZRKi7ExRNSZgcTaNv6CCLCjYLa8sj9rvu2VtTSdAaE?=
 =?us-ascii?Q?W7H3w9r9ADlQ8vg9Hhi0H1HKFWuN1eIBdEtkRF1U8zhaKFHf6e4WOHssGni+?=
 =?us-ascii?Q?ixbUtIcuSnY1h+1H6ClynRMKZJmb7xRNEpCl9j3MQXouCetQIp/Pln6jFDVe?=
 =?us-ascii?Q?Gigkz+BqYcB9pgZeR5F421YLwBkDz/wlwBu3INkeNEWGeealqHQqGPf/rrpS?=
 =?us-ascii?Q?1XFh8lS7sfd6egoeq03inGa75BzG86ThLZJsNKIWFYQZCh3pV7szWAJfohKk?=
 =?us-ascii?Q?nYkKq+1lAfZFkGr3ZHM9q+EU+v8z0NPHSNx0lzCaoK7gW58L7vAoWzFewQDb?=
 =?us-ascii?Q?UcjkbTV+E/4+CHlfRoqKzl6u9ReZR34m6Qh63RNkmzyV6RLgyE4uPW7G+tNp?=
 =?us-ascii?Q?rdCiBaS66u+wd3Uan5f94Kca28MK/7t4eSz3JcxL6p8ls6bdunW4CNsSPnC6?=
 =?us-ascii?Q?ZKzw6/V2v3iKh3wpuFKr3lT59CYvg0VVSHb6tLGbJEQqFnOSWAPSoepb8tj6?=
 =?us-ascii?Q?01cEVeCava/OrBmANnwkO0Nk8z0PO+LJsasQMwLQDbgmS+X8C0ltwYYlLty9?=
 =?us-ascii?Q?ZMAmFfc6LJH0vZEWzcwFqc98kOTVy9So3sLbLc9ow7K4TpK4eMj8WIHSOO/i?=
 =?us-ascii?Q?v8nq2+7cKWH/2k+4pOrV8g5LWcGWyXVISiXskZVZwy/xoJ7bYsfRhS3gL1xq?=
 =?us-ascii?Q?hdXcNg7hjxnZhJK+yoAvbx97DjqWDQBVRPCoQ8VMGVU17N38i4wiwTYBsIZw?=
 =?us-ascii?Q?WuQG+lwA7WMNxwuPgDJmYSXJyPMl0mxe3xAujcYUeUvCOfaE4fwsvJmysWGJ?=
 =?us-ascii?Q?moFlFLTldS2WaYfBI6LQiMnfaAsM9JXVlhfQAtxheYUmHtroO87Us7YlNGx/?=
 =?us-ascii?Q?cG3A+C/kegx2VtE7OZu9+QNbFrylvF/xHUgggW6deDuSpPw+V8Afh7BiK+Ub?=
 =?us-ascii?Q?FmF3oJZZjDfdIMesSR88SpxkSiDFsVDTvUw5gZZsyelwwl6ShyKhzoaSF2Ew?=
 =?us-ascii?Q?GHjfB80CfEzQN2VlOFvQK+rm85DPNt9RPXA6ljCmq+0ALinvbYk5UTOt7w1W?=
 =?us-ascii?Q?qu2vlWgi9tKjg6ZmLTAeKdVz1Zeoun1CirZmLhcYFSLkcP/uy2mK9vJMZ/3x?=
 =?us-ascii?Q?OsRuLbaDsUtJjjYpae7rAdbhTq3VKYfsoaOJjRhgFiqeW9mdBZtA4AkyC/Yx?=
 =?us-ascii?Q?FP0MNE4EQfjvJNjoSb1GXNrlAy87RAnX45KA4yTt0wWqnLGL1v3HbIWsuTFn?=
 =?us-ascii?Q?s9MNboklf05qrUdRXO9Knf6pUtE9Q+1vytk1VFikXWsp05vAy9yKKTMDUNQC?=
 =?us-ascii?Q?rnn+5lqrb5GW6Z/UHUOCRVpVAL8cstIS1ovPTMkB2zPMmSHuUODsam70csjw?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a0745d-15c5-46f0-fd60-08db6767fc06
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:00:51.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rvrCtUaa7BcHuZXSeLgWbSXbMt7bIlPa6iU93DX2+C+0Wl2zhEC15RYwdlcDHEPtoLpV4Fqgd2cwD01FFFP4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4922
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/07 02:27PM, Serge Semin wrote:
> On Tue, Jun 06, 2023 at 04:18:44PM -0700, Abe Kohandel wrote:
> > Remove a misleading comment about the DMA operations of the Intel Mount
> > Evans SoC's SPI Controller as requested by Serge.
> > 
> 
> > Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> > Link: https://lore.kernel.org/linux-spi/20230606191333.247ucbf7h3tlooxf@mobilestation/
> > Fixes: 0760d5d0e9f0 ("spi: dw: Add compatible for Intel Mount Evans SoC")
> 
> Note Fixes tag normally goes first. In this case it seems redundant
> though.
> 

Thanks, will do this in the future.

> > - * The Intel Mount Evans SoC's Integrated Management Complex uses the
> > - * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > - * provide a mechanism to override the native chip select signal.
> 
> I had nothing against this part of the comment but only about the
> second chunk of the text.

Thinking about it a bit more there is nothing precluding this controller from
being used for other purposes in the future. It is configured with two chip
selects, only one of which is used today. I removed it to so it wouldn't become
inaccurate if that happens.

> > + * DMA-based mem ops are not configured for this device and are not tested.
> 
> * Note mem-ops is just a feature of the DW APB/AHB SSI controllers
> * which provides a way to perform write-then-read and write-only
> * transfers (see Transmit only and EEPROM read transfer modes in the
> * hw manual). It works irrespective of whether your controller has a
> * DMA-engine connected or doesn't have. Modern DW SSI controllers
> * support Enhanced SPI modes with the extended SPI-bus width
> * capability. But it's a whole another story and such modes aren't
> * currently supported by the driver.
> 
> Just a question for the sake of the discussion history. Does your
> platform have a DMA-engine synthesized to work with this DW SSI
> controller? That is does your controller has the DMA Controller
> Interface (handshake signals) connected to any DMA-engine on your
> platform? I am asking because if there is no such DMA-engine then
> the last part of your statement is just redundant since you can't test
> something which isn't supported by design.

The platform does have a DMA-engine synthesized but I have been having some
challenges with getting it to work which may require some further quirks added
to the DMA driver. One example being the system uses 40-bit addressing but the
DMA-engine is only synthesized with 32-bit address capability and is meant to
only target a specific region of memory where it "knowns" the upper byte of the
address.

Anyhow, I hope to work through some of those challenges and enable this in the
future.

Thanks,
Abe
