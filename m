Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315A36A9B46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCCP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCCP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:57:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4C392BD;
        Fri,  3 Mar 2023 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677859057; x=1709395057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lZhQrSyXSsq45p8MS88DrLwE1YC186cCiYAdrwpLjuc=;
  b=VVkO9v/9uiEQmXkHS4x7hpHfkL1tXC8YVMlp+N9FjF5yr4eTVshc/mzV
   OqqvMtFFDx7AGuBoqP1eFShlMw5nTR4KVba5QCH6XflPxdFNV91XzesMy
   W4gsj83MVrbuC6vBtZXpKdGzOSm7OSHBXaWxUzx7cvpAPquv/6UOAtgcZ
   EpPMasVOoM1/oluzV9IJYD0TCgBo3pYesgRfQ9h8+Ulkb3zGFQZqlS8d/
   tZm3Y1T0AF3qI+M5H70/hFgKyeyhZ+Rk1bJHfxisJiBsq05FGf00bx5N4
   NBc/l3+otzSZ2in69GWRGMETsoG7HOZv0zKf4/sHYEDrw8lQwi6lHjVg4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315473415"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="315473415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="705680872"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="705680872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2023 07:57:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 07:57:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 07:57:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 07:57:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YteRfZipwDsAx9IfFY7bv3DJrBgQqrFy2yqGpyJvoDP0Y5zcQ0XoUhdTeIX/1FBN/JIQzKX0G9AABOE+oC57bGya6pUU/XCKxjloOC0c4kQsjvUNPNGkQ3ADFVb/N/65m6JGMVuLP0xWc9q9O+nXUA+u8kWuDoZt0JqDUrXFaOTyCIkVrPT97y1ersc/TDHLOd/+DRKfOjoAIxosJ9a2bCAJJ5MNE8gUYtP3yO4cTr6qMHCoTcoaD4uTl1zyIQCH2z/519kfYihLUr8O9Osw72lVlhIu1lmHZc2eWjKR9dAiCbLKp1XV0KfSmmJP3Gi5MJZt0U9BKCiq0QurMn8Yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpf30EWpNzlAdFGd2hgo4XljGy5wZEebhpU2Zx4UHUE=;
 b=DSPgKHuqWS7n0x1tezhO/wuCXGvYT79mgC/y7SclHNd3fYQrFNYCvE4lC/2mwu0DE8uXYBSEs8rFtlCtUuEQ+wrCq0ROYyb1O4ba3+TSw7QmR5OnvAoMVRUm4YgsI3Xeu+55+fOzB3wWEU+GV+f0K6ELHNn1c16VwKjkzTLg8C7Q5Uyo5KWomu0O9e7ZfBuxDSkKfho2ZSprEtFJle49CZYKHi9xp1jdnxHXvwn0idv1zwsaip93brIQ7Jljh22mvjp8GMETJ9vFIjFoP9zLowMNgDI9lAq1NYoYDlZZHArxM2cjWHp7re9Ju9llZBhVqJffPMemD40GLYsxOXYrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 15:57:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 15:57:26 +0000
Date:   Fri, 3 Mar 2023 07:57:22 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <640218e217c80_5a3fc2947@iweiny-mobl.notmuch>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
 <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
 <20230302062305.GA1444578@bgt-140510-bm03>
 <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
 <20230303143605.0000159a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303143605.0000159a@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d547523-b65a-4184-7e84-08db1bfffbd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/gZMPNqGZX5de9zczkOzxMbfODtR7Q8NQ1n/e7Gh2yBQ2QTkppOcDoeDQa7V3DGrvQj8GUZBjOV2LmreI0HmUk8A04siL2aw1pEQlXDGnx8MeyqGXoR8wxgcEB8wr/8MMsJXYRPAUFB9SuJ+HuBUG3/6XduRMsKT0W8Rfgc1L8L5U+tYuI0a7uidw5n+4ec1EUztcPOozvjMWvWUlmroyoehzcA9K2vuQDQhwz3CV3qDg1GuAEnRf3IvjbFAOnYgcyZQnUyVeZZSZLrxzcVFGINRi5TKWRv22AR9TQxkGi4Nye+psm7oAG/60hD/MtqGkb5z9je9gQ5NF1PbnHfNOERrD2oA/ZbCEZSOqsiLrCaE8MKDEqM67DxioTzWoF6DsQKP3gKIlBusOIMJU86z9ZESjUD7N8vaecXQi+OmKGsBkHeLMgjtLGbHu3aibHbDtSOpRSm6EtlvX8QfO34XHSGStG5PNAjnlslFZD5cvRN6+/+Xp2D3o+8BHjFitjsqqhnH+YTtqFb6pag+wJlAL3Co4THWvzedLoiKF1uM2lV7UaaZNBf3Rmg9dWAaPymfyWnYLwnPr8Iu+EHr7gSCNkVUir34b1OPzuGpBwAnthrwDv6dmAyUaCMJmqHnLgmWfcl83B/ew828sVMB9oRDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199018)(41300700001)(66556008)(4326008)(66476007)(83380400001)(8676002)(66946007)(38100700002)(82960400001)(2906002)(86362001)(44832011)(8936002)(5660300002)(478600001)(6486002)(6506007)(110136005)(6512007)(6636002)(316002)(9686003)(54906003)(53546011)(26005)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqedQLEiVZ9ne+Q0Krxauk1qAci1zC6qXvmKbscrNJgPqk3gT2JWBLmpW7TH?=
 =?us-ascii?Q?iOT1XO8LNacqSNspqoDoHKiRfGsgWemhwFhvIf0n5IlA8yGoGQpxm5R62FX4?=
 =?us-ascii?Q?Ilx3Lp1j/VHqLLNEK3oqL0gJcrc3hW1Z+qglXLVKWJlOsam5gqT9LRE7e4e/?=
 =?us-ascii?Q?Em4ovw1EP82PsL1xQ1SA915D3G2RWyWTHYHYg4CrQGg3DgU18q6VWmu8A1F5?=
 =?us-ascii?Q?vF26DAj1Xh3eMHRiUsPz91eEzbAOR9ML7kA9BYCEgaxaXsgvk3bOQWKfe8ew?=
 =?us-ascii?Q?6DPjqOv3mV4/llb+Sn8OxY5ZbgXNwPzN2yie1jmWjTxu0xOTEqyqt5ZqF3KA?=
 =?us-ascii?Q?4e8V6vVa/t2K7qYQ+ol+cHyXI4dyaZPqYtAEKB/uGjtUrMgH8hG6OlM90+oh?=
 =?us-ascii?Q?e0nyOjjeXNBd/z9wHF5GTZ5cr+urZbrXlcu8Mn7JLYR9CE6tMayanmHlSiC7?=
 =?us-ascii?Q?dAdlYgglAnRMhgvvsEpMPtaqlGxcreCqTHmZhs0TUDXFY5n2CV/N1sVHoEEe?=
 =?us-ascii?Q?wnth7Wtacp1iOZTijv+YerIxxCBzBu8CBIR3HhyhmOBvNiGuEIXP+V0c95sn?=
 =?us-ascii?Q?SqANtj1y4MzHi/HYGB+TDrmptl8LffQDE52gULwHxNS0RqboqztaulP5dUP9?=
 =?us-ascii?Q?JguAErQGC9kRKwBKGQGIUPyCLKeva3qD+3LKiRpiU8JomtB1X+EOTmjj6oMF?=
 =?us-ascii?Q?sD0iJpRya6qOwNrpbR2tHqJkgnOGQ2HreMy9lyop0IVAQ8BEY2ldtV3+/rbD?=
 =?us-ascii?Q?GDv+WiBvvPobBE1Jjm1PFi6p9/v5xNKapgh7E0l8Kdcn3XSjSRT+H20xbZxK?=
 =?us-ascii?Q?fI5aizGbg2naP4nhySuYVDD1K+EUNpJUoKw6H6dFParEBhwIZ0fmDLILce0W?=
 =?us-ascii?Q?vN6v3lrRdGj2zol1dOoSfFgcwQuQg+fVPZPvItIfsU4DOdD7uLigvdWDbk8X?=
 =?us-ascii?Q?Pt+5Z5SjudnZLDOAdajBPKKKX4lv5sNG4WgIm8P/gu/4FW3aAczRzmCDEPN+?=
 =?us-ascii?Q?qNJfMzGUMklNVkuJHag5p2djKX+6SBWaGzEFCLjX8rA90qFq8MH1RRKLFM4h?=
 =?us-ascii?Q?pJzSZ68AKt52LZNsl67UVrXZKjgJ6odsNMabo9g/RzNPMd8+yuiaVUCTkJcJ?=
 =?us-ascii?Q?ptNCLABVkb6c3h2JJYfVOFB0IWanpY59UZkVU8RB2e1kz6tRgeto3WOCVYYW?=
 =?us-ascii?Q?2HsIYFJ4J8i30oYJhb2H4CswCLCbw0xc42hbBmX1zKcgH0iIyQfsxHHicy9i?=
 =?us-ascii?Q?LOeIEfy3KYZuNAFtEjWUpStw+2xcVwg5S6mDX5hCjuKVr+vbEiYCG9pLdlbv?=
 =?us-ascii?Q?VruvXIZTeci83b77UgqqCZnNi9bHL1+eAEejMqK1b/wCcKcBM99Q9O7Qlmia?=
 =?us-ascii?Q?Dz3v9mMtMcFaaTRo1Gdxnm7rGE4w+W+6pk6UHe8+coF6UXmCoaxy+EqCrps5?=
 =?us-ascii?Q?QhDp9hOQ85DjJKu5k6Bb+//L448L6hkiFTsowuYZQstH71sC9Xk4/h33yx9o?=
 =?us-ascii?Q?Vp9zZjIk1y1jVzb9dVL41AC/qFSsVzd6gWBsOrMnhUP0PFbyvY42ndyaTU1N?=
 =?us-ascii?Q?kiFTIILYrh1YuInIUrQ09sfakS+llgOYCXS+LOt9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d547523-b65a-4184-7e84-08db1bfffbd1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:57:26.1374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hzw7aM4yGJHsIva4f0zK24WlIsHoY1fYKfnnUW+o4Wtm54ZHDTY2gC3Z3GA577Oo7zymvW3541Z9Q0anVP4sfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 2 Mar 2023 08:36:59 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > On 3/1/23 11:23 PM, Fan Ni wrote:
> > > On Wed, Mar 01, 2023 at 11:54:08AM -0700, Dave Jiang wrote:  
> > >>  
> > > Hi Dave,
> > > Thanks for looking into this.  
> > >>
> > >> On 2/28/23 3:40 PM, Fan Ni wrote:  
> > >>> Add COMMIT field check aside with existing COMMITTED field check during
> > >>> hdm decoder initialization to avoid a system crash during module removal
> > >>> after destroying a region which leaves the COMMIT field being reset while
> > >>> the COMMITTED field still being set.  
> > >>
> > >> Hi Fan. Are you seeing this issue on qemu emulation or hardware? The  
> > > I run into the issue with qemu emulation.  
> > >> situation does not make sense to me. If we clear the COMMIT bit, then the
> > >> COMMITTED bit should be cleared by the hardware shortly after right?  
> > > 
> > >  From the spec, I cannot find any statement saying clearing the COMMIT bit
> > > will automatically clear the COMMITTED. If I have not missed the statement in
> > > the spec, I assume we should not make the assumption that it will be
> > > cleared automatically for real hardware. But you may be right, leaving the
> > > COMMITTED bit set can potentially cause some issue? Need to check more.  
> > 
> > I have not been able to find direct verbiage that indicates this either. 
> > However, logically it would make sense. Otherwise, the COMMITTED field 
> > never clears and prevents reprogramming of the HDM decoders. The current 
> > QEMU implementation is creating a situation where the HDM decoder is 
> > always active after COMMIT bit is set the first time, regardless whether 
> > COMMIT field has been cleared later on during a teardown. It does sound 
> > like a bug with QEMU emulation currently.
> 
> I agree that one sane interpretation is that unsetting commit should result in
> the decoder being deactivated and hence the commit bit dropping.  However
> I'm not sure that's the only sane interpretation.
> 
> There is no verbage that I'm aware of that says the committed bit being
> set means that the current register values are in use.  It simply says that
> when the commit bit was set, the HDM decoder was successfully committed
> (using registers as set at that time).  There is a specific statement about
> not changing the registers whilst checks are in progress, but those checks
> are only required if lock on commit is set, so it doesn't cover this case.
> 
> Wonderfully there isn't actually anything says what a commit transition to 0
> means.  Does that result in the decoder become uncommitted, or does that only
> happen when the next 0 to 1 transition happens?
> 
> The only stuff we have is what happens when lock on commit = 1, which isn't
> the case here.
> 
> So is there another valid implementation? I think yes.
> In some implementations, there will be a complex state machine that is
> triggered when commit is set.  That will then write some entirely invisible
> internal state for decode logic based on the contents of the registers.
> As such, once it's set committed, it typically won't look at the registers
> again until another commit 0->1 transition happens.
> At that point the
> committed bit drops and raised again once the commit state machine finishes
> (given QEMU doesn't emulate that delay the upshot is if you set commit then
> check committed it will be set ;)

I'm only barely following along so I wanted to make sure I understand...

Are you saying that at the instant commit 0->1 happens hardware will clear
commited to 0 so that software can later check for commited vs error not
commited?

Ira

> 
> In that implementation the commit 1->0 transition is an irrelevance and
> it won't change the committed bit state.
> 
> So whilst the QEMU code is doing the less obvious implementation, I think
> the spec still allows it.  I don't mind QEMU changing to the more obvious
> one though if someone wants to send a patch.
> 
> Jonathan
> 

[...]
