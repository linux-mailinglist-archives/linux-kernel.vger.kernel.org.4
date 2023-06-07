Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB010725B06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjFGJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjFGJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:47:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663FE47;
        Wed,  7 Jun 2023 02:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686131277; x=1717667277;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aTF4gfGAxzGMdNknwrnNoGjavxqjY96g0N9tUyPhzfI=;
  b=Ai1Qflihp4065Rfpf/9zX5L9g8a2y22PddtIL5vPnM9SWyUg9lRX28F3
   zmRy1uXXwq0Kv9qv1LkgoEKmDgSsmwHWS72+PtGdt2NdjfShRGWAK2Hff
   tfMRvarMJT3SutFq/23pz0D1SOYXZI5WnZRcResac4LRkfnnO2vIhSI/6
   tlOhv1ZejXSi0j2y7Svql2YMznu55uq+tH24UJ0EbW0GF1mO6k5HcH75B
   v3zhpqrEaz5MDEsiLgwV5JW57Jliz1RNawOxUeGTStWoezG4aX7UwpB36
   BNWW6gz6UB3SOhaDE4/sMMP9tpy73RaP8pMou/+yrG3yyRneryqwkQ0oy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346553167"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="346553167"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 02:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="883667329"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="883667329"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 02:47:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 02:47:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 02:47:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 02:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noFxFGH0qvCu5jYQZqJxnW4cSaMHxVfDWljsaphhU5K8O6fUm3og3V503jT1brxFll0UfX1HLGyXSsPISxI8jl0mMEXlf8nY2yudomTAPPUTtM5yOH5DU0bCofX60R85/Iu2V1WAS9j0c/SJO1W40k47ufPyp5eehAv0ha3S9uaKmAxDVTMSMbw8BwHlg+cwUeS48G016NsBbsszpyiMQxdqoMD3rNgABYymyywqk/1VPzVFHTGROqOY/CshQFzRg3fxKIo1WX4SMovJHinr7aOZCmpOC9ZUX7gaOHMBTPjNzKGq5kyL8e2u+GivNEByrBqJMcg7M8OrWHVwJ4A2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWhxfLpR6mr4E1InuI+1J5i1R96zMMCWK0Rnvr40zmc=;
 b=ArYWqxz5CqOJbpwSaAUNOJjr9I1R2P6njA/2Y68vz7LjcIwWSUObzu80unAFmT0l2b//fmEjy4LiYt8qKyS6s2TDABmyrA1599WR9nd9406W6/ufgkD+MLtiOpyfjzWCf/ES0/FilDGxtXBOdoy5tK9MXLKLc4C7/Gz3jYz1J4kGftNCsn77fJEGLcBGkq7XFqoGLyQTMDRcf9cSNf0Du0FVso/AcMutw3Jabrqi0KCszzBHk9ZhqXa0eUJt2TGq4jxPB5Lc8n7Qp9bAvji5aB1mPO8iTjIsIwBxn76vFqFXAB9BaMuaAPWZ1/pilKGb8DQnHLItoz0MOT68JrR8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 09:47:52 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:47:52 +0000
Date:   Wed, 7 Jun 2023 17:47:41 +0800
From:   Philip Li <philip.li@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Richard Weinberger <richard@nod.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
Message-ID: <ZIBSPW0NYWaY4JFj@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
 <20230607042340.GA941@sol.localdomain>
 <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
 <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
 <ZIBJadzmheKWCErq@rli9-mobl>
 <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
 <ZIBQWytL3zhWFLgd@rli9-mobl>
 <4b1c8af737eb5bccba12883f32ec43f9f292f70f.camel@sipsolutions.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b1c8af737eb5bccba12883f32ec43f9f292f70f.camel@sipsolutions.net>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH0PR11MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f404511-321a-4e9e-1186-08db673c42c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va3aJHQrcReC4SRHWTeD1rMsJHzw1UDuXlsO5J9xFtgUmklyN7aUZXxFR9PVLdCcFgifLntI7oeaS+NaA7Yxoxqbg1QX/PFzB2rs20bQ6nt8Pp8kkQdz9EWb3afcePws2XHtCg6TDwTN3VihpuUDFm30U6r0KIyRBU/iNUhFaMr6a6yBhnNsI+GHKDTaIVG+5tQmnpiAEqxqlVpAQY2SMZZ5RSv75Z02TiwniitEFLus/IG9L3KGjbH7fZ7oqNhvZcqp48VvxhejFAS/+01GBgda1pHa+VUC0eqlmGjW9J+70W1QxuP5M7YWw2e3B3f+jImFJfFCPGVUVDeNL3HtRfG/1ydADqpbYk0ipL6SY1BnfosQYS7yQvthVixVKFWOkCRmhwukgHw+QJBHMLG7tFjoK2+A4H0pSWq2k5LEsKwnH1XH56PrsPlLyuCUIsDGVzegZgiyPukHzurPqmcuUNuoDnpwNOo68XfsLpNXa/08btJu6o+2+dbv8Nboo+mCCjpbFtn+AkxDv0uf60nFT3B7ICbkE9hKS8vayygYBxjUoV+Mkhh1wXva0c7NSB14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(478600001)(54906003)(107886003)(41300700001)(6506007)(5660300002)(6666004)(316002)(6486002)(26005)(44832011)(66899021)(4326008)(66556008)(66476007)(6916009)(66946007)(9686003)(6512007)(186003)(7416002)(2906002)(4744005)(38100700002)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUOHsDHLKn/CHz7DRkGg+uVJLKG4TlJv0G2I45+ACoF+xIWAyxxnnIqzkk7Y?=
 =?us-ascii?Q?l6rMKsU6uHe3/CyeT80Inkw8Kt5dIlIPiYfDv3Bjv5OrUDIlZURVOny4+Mms?=
 =?us-ascii?Q?O+UfAKju2BeILh6mRGx6MXNk1irH4O1Z5zP4hrmQcafBJW6nmJi/IiSXA45Q?=
 =?us-ascii?Q?8RZH4KD4X920vk1xvaSyn/bNZHOJzaJspqY4HBkJrONnRHzyEIooctwHlOCg?=
 =?us-ascii?Q?CCjJhSvtFFw6JOiri/95h5StAohrUfb6EMuvSjAd4pVIMZT2RwohfS6Ugr0K?=
 =?us-ascii?Q?XUxSeQ8v4jJe9Q6SBTS+Kr2ZsG6EoBVCdDadstHODMpzFUzKv3Cbao43rTb4?=
 =?us-ascii?Q?sUOjaD10KtqO8sszfJ5OBxuYkQwVGq+VI6qRADpQ5uTwfHOYdsFn0adqrFJR?=
 =?us-ascii?Q?pTmODrc4j8FzHhUmzXozepLzq/aMzTawIuiXoNlN+oZgwgSf5muWpo+34rt3?=
 =?us-ascii?Q?uu5DTBVhfIozle/dHk47zU2qXMEJv+kzHNUSZ2vNkRYrA4lJarQoOmmewCSl?=
 =?us-ascii?Q?idLnlo3ki9FU13dDJ7Aen7LFMblSL0J+vbUR8PJCrBZuBvngr/rPmRBnp3Zn?=
 =?us-ascii?Q?gwwFnbWPtOGnLt54ZdGfBBbWtwqyOT7hpjnOvAAlIn8YOfq/XMPZQBAG8cME?=
 =?us-ascii?Q?r2R7NTpCYyKgSIFERdr24LlIPRQ9+f8NRYt3cgvaPrs0myXaVsnRgJHLYi1S?=
 =?us-ascii?Q?FreGrZXLmHeBOwEEXy5R39DLRyvs7yuoQAaX8UDVUFahOTsGiLcgUPElt7Og?=
 =?us-ascii?Q?Dc82hve7+f+dVVDnXjYmmRL4QT0fFER0ofnDuokIRYMki2Yw43o8z+0PjLRU?=
 =?us-ascii?Q?86dq4c73kizRR1lfKkj4QDERiM2XQ37dnAJPrHmk40vrZBq5Tz/LLjtskGcH?=
 =?us-ascii?Q?JqnQajOmBHFPOYb1nuv/Ssw4WKsQ3NOsXG0QdkcW0UQGNp46lIaaxVS0dRfX?=
 =?us-ascii?Q?13Io3NVmWF7AQmsF3DiS9rovZjGFH5tFlG5lsNnSJmDE6BDfuQspHV0nVePb?=
 =?us-ascii?Q?8El5lC8a6G+74H+VV2f7ySusVnZbnW+UE/L3EViurMR99J3gEwRP3b1VlAoZ?=
 =?us-ascii?Q?HHrVpk99spGq7eomN4dRi/50kMlA7yOEyo6S01Ov6x/tZabHjoS7dumZuhWB?=
 =?us-ascii?Q?jz/bo2rlju6iDMQ3Bs87O+VJ0Bzkd6ZM9yzLBx9G6sOp5IXh+rEr8fPvwi8O?=
 =?us-ascii?Q?i9kpX94uUSmx/ulnLkX0A3qy3J+ayNZIDQGWr5kTxOdixeH4rAOUncUItZQq?=
 =?us-ascii?Q?HISuF7gecWbk1vKZvRfOhmgNHY5QC5AgrEP7TsU7qk9nntkOrXJq1c3XBXjJ?=
 =?us-ascii?Q?yma4w/rhXxfAEU+dfpZQ+lTcUvMlNdPGDLWDQy/2Sc1ofQufDAAIEe3q1/u5?=
 =?us-ascii?Q?s13ZsFsdIq8M0qjveYWRoZW+YMYFNrDDK6CZQ4/ot8tBZ4eoWilfumaEJqKC?=
 =?us-ascii?Q?2bKxMK5Wy57J5vbTQvFLYQfPYpc5aI16+gHmKVoV0TOsvFS6IYul4lUlGQFl?=
 =?us-ascii?Q?svBMJ0IMsEsW8ywCzxRDtPwGW3sJw/e7CTBJMLKdlgAOSPS1nGL6mR1H4PqN?=
 =?us-ascii?Q?jxOffVTxKYDMB6bG1OSpOi73FE8XY9sosf/BmwIY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f404511-321a-4e9e-1186-08db673c42c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:47:52.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6v0Dgfjj790D66QxSUmPwfcZtEUxypPmhCnB3CmYU4QLcN3o/RB29oeM6jvoezvchwVj3yM8uM4JLICJzPCMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:43:11AM +0200, Johannes Berg wrote:
> On Wed, 2023-06-07 at 17:39 +0800, Philip Li wrote:
> > 
> > Is that ok we just take this phrase as a quick improvement for first step, which
> > is
> > 
> > "If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of the same patch/commit), kindly add following tags:"
> > 
> > This could help remind for most cases if not all. Also this allows us
> > not doing "complex" judgement by the bot itself.
> 
> Sure, feel free. But yeah, that was the idea, that the decision logic
> wouldn't really need to be in the bot, that feels very difficult.
> 
> Maybe someone else on the thread will have a better suggestion :)

Thanks a lot, we will adjust the phrase like this as initial step to resolve
some confusions. And as you said, we welcome more suggestions to improve
the bot.

> 
> 
> johannes
