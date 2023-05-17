Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C6B705C28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjEQBF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEQBF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:05:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C71BFD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684285525; x=1715821525;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d9kGv7oE3Og53tf4M/6RUBCwzwGtshjR1RydeKineFI=;
  b=IxRb17aSSLc8RBLGcn+QMB2LHJWBDniFy1T0YMtQ62PwmtKLQ0gsMjji
   6JURsWiCZMbjRV+1Sg8hBNCBvYF3c8rApoODRlG9MFeOoBeQiBBfev/Gn
   dadZlYx/249579IYqVO/z7qmLRhSdXo1k00fLTBE4wrRuOC/967SmwTyg
   7BpH9Ki/MBAitmW0vpg8SJDkxv2VfVB2m+5dgvyPH0mO+9Nl58bHNxMvO
   hsqlNqrqhL1ZiALAPyrF/Bk5PPTjgqfULbAezA137uRdnniuzJkHHie8F
   eLGCDzdezX9DQbun/m56dxj6jxYOfVaadOYTwkJYnP2J/WmV09G65olcO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="437977420"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="437977420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766562598"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="766562598"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2023 18:05:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 18:05:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 18:05:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 18:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcqDD6CufWUHTMwTAis9pHKucy20fAwG+hR8zRNJ3gGga1rQHda1WYsgxqpiiCKllPQzGnB7D94nHAxFOMvRZaUJm5rgRJajgrhCToz0FxU6wHkg+s9I0HU6hxlEq74LihXb1vwdtYD/Ia7MlawE9slOx543pNnxT1L1Q4taX1O2Th97BI7gEabYIwDGKXP2/ZK+4wkUokXNvWWtapl6qX0E85SHVke+I9DqHansmPACnQ4zK1fT7/meRWK8GkL4VBuRZCEUrPPYh92zFKgFDCU7JRlDkkyRaGNkRiilQJnmX1JOfzhrAg0v/k8ylJP2fFJounFy3ea+HESpSizBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqACB+S12uNNs6wDFSTLj//5FMQicbNOlJP5qdIQOY0=;
 b=LceIeyAc43V/u4KvqCSLP5KldgUIJs0fo1fwDneViKVISKDaZcov7mGH33spz6f89vUzJNpeiGwLOMXusncFqEK9bg/ntNCTd7cQ0zRIgprMbKSBxkudJynfY6gBP3EuCwxmn4PR42RFMlgqEEKGUulzHrgMBMwiMikQzC2PUF8c8h4mAJ93hXrNTp0FWmoviACQo25Nafls9MV3U0J1ioyk1DwEKbA0kx23waUhbkFTrEaE/jymDaFaPPrZqBt1pKy17h5iZSWiFewcP4Fe6BlZaOMM+Y7nDsQRvtrTJ0te6s/4vA3kwmvpyHj0vvS7PjLNjauZaSrNnxhCSxZpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 01:05:21 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2dbc:e5ec:2032:55b5]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2dbc:e5ec:2032:55b5%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:05:20 +0000
Date:   Wed, 17 May 2023 09:05:08 +0800
From:   Philip Li <philip.li@intel.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "David Airlie" <airlied@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: Reported-by checkpatch warning from v6.4-rc1
Message-ID: <ZGQoRJrSvQkbFbUf@rli9-mobl>
References: <ZGKFV/FGu3oDNMV1@francesco-nb.int.toradex.com>
 <238b5d83-cfb1-ce99-8e1c-b69b8d65ed91@tessares.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <238b5d83-cfb1-ce99-8e1c-b69b8d65ed91@tessares.net>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: aa38b0bc-fc6e-47a6-acbd-08db5672c84e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Yxff1A/9AwD8QNL0/RRJL3BeX9RObN80gcrW8lhMIBQKVdLYuJ3vVcnwtc8yLyS3dFgxkPk3Ym+1ZUIAcb+W41+Mc8/ne1/yFjF0vuX7R9rX/ikIOvwQDPxDqs7dgwo7Zca58ZQ0BgULWpgq4wHWY/rKVF3FvJAnUP/5iGOui+TogaVJMY8fLRfsfbwLnfTvf3f2uMdmb80noPALqVQVV+vUTVV/8sa8dt0LpAp3XgPJwchDF3/dOEVFOXbPJhiw798xJKWLkuJ3IGsznXT8WfbIEucGhbfydUfBYMcUgXvkgwhx+LLekYZV+sXhKnewlW6wKkqsH3VvlZkGDs/EIVm4rUzOcPNLzdyUsZlGyoPsmW0T6BuUh/XxXb0X1nhwxICjpw/hHWkPr95gLZK04ilzwfYhRIZC3RNAamlKjOcytUOrSrg4pgVJPFhxkh9LmgR0wLbQqFNYl+WtzixdQZCXTygGGaUKePv4HFI5mJnF/Xwu6ziJK1CuF/Uw0ZN7rj5JvkLk+Wf609BpfNNZYXNnGW1uLezyCvpB9265QFNaBPow5+zXl2hEBy3iGgoTdE/Hlq7vEtJ1ecpVglbAx/GMOTTIuz0dvJztd8GYxXgMTDaexCD+nGLKDXCh6sUgfVY/ZQm786kMzWPEyJAyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(83380400001)(6916009)(38100700002)(33716001)(44832011)(2906002)(4326008)(86362001)(8936002)(66476007)(8676002)(316002)(15974865002)(5660300002)(41300700001)(66556008)(82960400001)(66946007)(966005)(478600001)(54906003)(53546011)(6506007)(26005)(186003)(107886003)(6512007)(9686003)(6666004)(6486002)(18886075002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LEMbtwsU/7y+QytncjqBVlH6OnoWDepvNTDqMNsOXf8WEHLfmDBJOyI2r/F3?=
 =?us-ascii?Q?0Hr7hCMXhqIjIAU4ro5DAmF497o7giXAitISHYrGVKfxLfPEkcW+0WN3Nb2T?=
 =?us-ascii?Q?fooToYuycI4Wh/Y1rslorx6YbXoHu3BAeSOpMh6ueuLMK6JK3+jyB6/bxv9t?=
 =?us-ascii?Q?2itQs5aIzJXQWauuvLcSpHckbJlHVCiOBZiwYDl0WRf8VyO9E0Dcs/V6KsO3?=
 =?us-ascii?Q?a+s6bB/mi8ZZkuCH/QgnoQHYYOdjTHVt5xKJvcHDcr0ZfTtcRTPEAMsklJ4S?=
 =?us-ascii?Q?aeBx28pfkx6WHjldgQGSCVlel0zV6ZmQCip54OSiDrl+wBm6fWKGUGsxx0Du?=
 =?us-ascii?Q?FtFYDMsKjLskR0nQ3dP5VoB26RRPGCFJaceaWjf5Hvwg8GUR4+kk98D1R1HG?=
 =?us-ascii?Q?BWM2oiashGDc9MJetp/+p5FPukMBDGgfvimJ/UT/vCoFJUiPPvbMmRuo7+GP?=
 =?us-ascii?Q?0yurG4+oVnOvOOVEToPQO2Z+TlpQ6JBqWDFTTTJzZqWcISnJi/1zc7wW95Bi?=
 =?us-ascii?Q?DiFksdMFx7cZM8JGnaRhGMmc8eEV77FEyE8/lxEAEPNVT52w6H9j6V3DBDw4?=
 =?us-ascii?Q?/l0ug9GXnlj/Pm52+WemwQmtZBKHPzuliJSzx9H1tzfwxMlS/cLyC0zdHayJ?=
 =?us-ascii?Q?l12Ze+OiIyu1qoibuXhWfdY4zI3rY6fXiD/lqXHLFZ/cnWOo7TDro0wvmSYi?=
 =?us-ascii?Q?Fb9ozCcEVuz7pw0g+jbBSoS6Gsii/r/ocdwTFtDe7SJxq7+SUSmGhffWbCPP?=
 =?us-ascii?Q?nQQDxksW2kADP1uKhlTbtTqAp2DHL2FA+I10kAebus8yCUm6WwYhJKi0ykCo?=
 =?us-ascii?Q?e4B67qFsTyIVE/hYeM/Kxb0545wUMmPhxRj2izXO+/TCkebhIow+779NSZEK?=
 =?us-ascii?Q?JWyGb/1k3WMrJthiRSYqmTsLAOem9/sG/KKg2L7VuGYLz2NLDzBtHXMIw1w1?=
 =?us-ascii?Q?dzJ9CNDlsDAV72QyoYKg5j8pBey88OKQbQfGnsPDVZclySoRTZpmSGAxFO85?=
 =?us-ascii?Q?vcI6jLNfSQLFaswA0RqYhT5cGwPUxrcwOigyRgYzbD+W7So/O/KHre5jIdKn?=
 =?us-ascii?Q?ZB+hvpXvypG6fbqrHIgVLDEg71PJX+bd4S5SXRM2sVfKmN2L+Ir8lI/yMcR+?=
 =?us-ascii?Q?P0PfMTzPqPMSgJotzqfvcGGOWA/rH7wYSQBdadASlZYC0/jEGZLzrITjMbPT?=
 =?us-ascii?Q?a0kdhPIQqSsZ5ah/4PCsXiVA9pOMVgxpzZnshWEahbImpShXoOSrvhbKRG6T?=
 =?us-ascii?Q?vsV4es9t4rYR2Ei0gxtj73qH85IiSaxYxJaZXVT76lH4S7G2WcSflzOEke4y?=
 =?us-ascii?Q?baQeTrD+nyGMs/ZZku0KYXSFQ7y6dTE+YWIhH3FhHgEqKZF4+/3WnhInzPk+?=
 =?us-ascii?Q?RtK1M29y4rDHHJYPM+lE0MUw3mARvNbs5zuqKj3P56J5n7zVi47OIve+eTex?=
 =?us-ascii?Q?/gD5n+s6teo2Jt+s+V/h+I05bX2ZtgIM74F9/Ew/DtypoM9FYcfR4xpQWwjE?=
 =?us-ascii?Q?xlsXQolzVI/0+KakrVupVtSoIEVFOueisJo7HrbuEveyUwh61BcRZisCJNrN?=
 =?us-ascii?Q?lZUarMvStjoO+2G88GaUQr0D9cMccmdO9ztoBjNC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa38b0bc-fc6e-47a6-acbd-08db5672c84e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:05:19.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJj5DAZbx/dlpv4uIE75LhXPYH4qMiEoaG9ttPSoFjjigRrHWSzqod0uQe9pl9IG2iHA1md1q9xdeJDQlvpaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
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

On Tue, May 16, 2023 at 11:47:45AM +0200, Matthieu Baerts wrote:
> Hi Francesco,
> 
> On 15/05/2023 21:17, Francesco Dolcini wrote:
> > Hello,
> > starting from commit d6ccdd678e45 ("checkpatch: check for misuse of the link tags")
> > any Reported-by: tag not followed by a Closes trigger a warning, even if
> > we have a Link: tag afterward.
> 
> The warning you are mentioning below is likely due to commit
> 44c31888098a ("checkpatch: allow Closes tags with links") instead I think.
> 
> This commit is linked to the modification of the documentation allowing
> the Closes tag, see commit 0d828200ad56 ("docs: process: allow Closes
> tags with links") for more details.
> 
> Initially, the intension was to allow using the Closes tags with links
> to public bugs trackers because in 6.3, checkpatch was displaying
> warnings when it was used while it was fine before. But it turned out
> that this Closes tag can be useful for bots tracking bugs reported on
> public mailing lists. As explained in [1] and [2], various bug trackers
> can use this tag to trigger some actions. It is then helpful to use the
> Closes tag each time a commit fixes a bug reported somewhere.
> 
> [1]
> https://lore.kernel.org/all/20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net/T/
> [2] https://docs.kernel.org/process/submitting-patches.html
> 
> > Example:
> > 
> > WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> > #8:
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202305152341.oiSjRpv6-lkp@intel.com/
> > total: 0 errors, 1 warnings, 8 lines checked
> The warning is saying to replace the "Link:" tag by a "Closes:" one
> here. Is it an issue to do that here?
> 
> I guess it means that the kernel test robot should then suggest to use
> the "Closes:" tag. I can report an issue on their bugs tracker.

Hi Mat, thanks a lot for the suggestion, use Closes tag is clearer here,
we will update the report info accordingly.

> 
> > From what I can understand it was not in the intention of that patch,
> > and Link: is still fine to be used.
> 
> Note that Checkpatch cannot cover all cases: it gives you
> recommendations but they can be ignored (and documented in the commit
> message) if they don't make sense in your case. Here, it looks like you
> should use the Closes tag but it might be fine to use the Link tag if a
> commit doesn't fully fix the reported issue for example.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
