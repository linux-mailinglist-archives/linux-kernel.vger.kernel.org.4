Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6947C64D4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOArd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:47:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C621F31DEA;
        Wed, 14 Dec 2022 16:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671065251; x=1702601251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=txHnSpXEIIUclFlS2oqlXgaB4TMHoffj9NGoykOODas=;
  b=DZ5khXxQ0KkEAxp5Fz0zHqypJ7Gh7G+C7gHe6e69Tqiv+m2PCd2khn8b
   hSw5A2riKNA45qceijsVCU71ivuD3wUI93mvygVpi+O6/XPaKsoHW7RcC
   mUtu8MwtHB53kRQps1/I8X3xBhRu937tCR23ZMQZguXR3BVRVRQb0z8sB
   czC2Bq237A6Rj1a1wawYiexkFEpj7eN7vsUrIIiOVp81ldthqgDJRuApU
   dfBcAaDookQDAVo71eTKav07MBErsVbeUicWaxsSk/48nsNAjk0bhyGHg
   Gny34tNrxp45/jwFy1KrKAUZY/YEgmhE5M8XLsxrkdpHUyyHqLPm/WuJW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="301961103"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="301961103"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 16:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="737895103"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="737895103"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Dec 2022 16:47:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 16:47:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 16:47:30 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 16:47:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhsBXqZLF3y8D6kaFm6KYuC/o9IdznLRNYRVDMc8dkq1PTq/cHCCWcHJU+ws6Ln/HEDIdy6+NBPVs9Fos3YTqIcDWqmJjD6+l1iMjW7y67PuHx4tLPTlsIt9e6iDInPfMkZyv5S/yVDqn1dLzzr2Uduqp7M45CXUs3r2W7iZDnjJ3XMp66ISCUuIUXVFuH91gwgPWaZipMwuveM0cUzDQjHoFujegLLtGkiVDctZkfY1EwbITCAGaaGX9UAwZJbxd/f/IXkNevPXSMv1S6i95O3J5th8yl02FCPBJKVtJOdhWX7D1MTksD57goXxO/nPfZQuapmT6tJw5hK21Ww4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US/DOi/2gcQNerMQGGOAQUTUhTNpRDk2EGtdSSIlwn4=;
 b=k6Wc6So8/buwwaG8Eh69/FPLOfz2RllklWerzcgx2Z3wNjQwow/vrvhmpm3gOqNR28Dn1pZjAJ+BVCH1Sf//RZCsH7/Gbyp4CK90p1OjbniayNK0FGULIIwZOKNW6XX4jIYP8Pdq+cr3uL7mbTd8tDc8KJ7r0a+zcw6aJIbHHM3Upu9SDM5jVlRwli9SbaD8XUM5P4wPN2kt3UHT+xaLWaguIMqLEakTEl3PnI/Jam5ngGM/bzgFRbifrM5tA2DOmQ9mW4euYkvNSDCIVn9zcakku4FuoxBYLV9pI47c605BMf486ixNSwzd1Y/0ffm410zRApqj7zD2JHSZBRlvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7591.namprd11.prod.outlook.com
 (2603:10b6:806:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 00:47:27 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 00:47:27 +0000
Date:   Wed, 14 Dec 2022 16:47:24 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <639a6e9c6da4e_b41e3294d8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5kAt3WRgncTj26x@bombadil.infradead.org>
 <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5pU4XTchSKVqkjx@bombadil.infradead.org>
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: ef10351c-6895-454b-4e20-08dade35efec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xD7+b378/aKK0PCtn3adkocMb32TL1N+NR6rhotW8cqpP1hAXES6GNgc3ajAIWAv+mXDnDuNzFoiiUg/2Y7KoSn0oUSMQnMVtsiQON5bekJxqhaYBLM9Z1e+AeRzzvTyAQ6NZUh2ylQ3QONJ8oZMdukLTHKwCSBGimPNk0C7jZnKaqxnvmnuGPdWDnY0RwUB1jpKGfG8Z1dXf4I/wLKhZ9brKs8LDCFqkmFykFjk0TpoDkydimE6J04TtB9n4pnlZ9LkT8OSXsc2pzPLnTjxzuy7Bv/if1/NPfgTUwWogu5hjZhdoWV10vYbxMa0Q8ZzaYc7NjeNtqucOCt7WTf4BNo1IpC2QvaDNKKuVpQzJyc3P207sllIdqq1oQqQNU3kfzCsp9VY5BrI/DKpsc6WbzCJofGzrC6tzY/JYOd6t8FUMETmMUFocCKO8HAplTIHXLkH1jT69vxJD++fPBYavb1iHKaaP0W7jSV2sNnAU727rdsy6Q0HH9iBdPpfNEvRalW7IkX+NFwZjGHcPLZIH5apU3crt6KqdclCFqK/wG7oje8g2uBnFoIAJFKp4hJQdxlQnPu09+eTBo8wOVBPuwzVV+JurJ4wUpTF6SdWm98raBXZGxZ2FltnKREGtV7BLJkeRVlyMW9vNyHnmDWIynkvlwaQlgvMPIknCxSvVL3j3f+02KJspNF3HsrZhOccFAAJtEmvJOrJCOBgKDUWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(2906002)(38100700002)(478600001)(6486002)(82960400001)(966005)(6666004)(6506007)(4326008)(5660300002)(8676002)(30864003)(66946007)(66556008)(66476007)(6512007)(9686003)(26005)(186003)(8936002)(41300700001)(110136005)(83380400001)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p2oTo8pm/xyg5SdLtbYm9mYEN7FxmF7wDT91hMMIJXLKFcMMsyIm1ljEg7wp?=
 =?us-ascii?Q?OcQSJZ8iIxjYvdIhNpDS05IecC+tTVe2GolnLWdCjNFQUB0TblG73T7bH7fL?=
 =?us-ascii?Q?y/41i9FBq+V2gVr5rDI935dNe8TWO1/LAShLGjK880G26khdBWZuEnJqk8zS?=
 =?us-ascii?Q?Tt+KsMlYf4iQlZpjMV6szS2T7S0SMPPkciElY0Q0JaNI0vfojTApyMH8wc86?=
 =?us-ascii?Q?2bLaWosdlB9JihEulScPB4S1BmvCdkhxWJ3kNL2fcSkBJTLaZuxoGuMMcjEj?=
 =?us-ascii?Q?W+5q6//Z8/oXFWu+JIwHz6GeviiVkWoGr+8XD/3Cd0MG63L/XufeVBfBb6fk?=
 =?us-ascii?Q?e55re/AcpmCr1P4pzE660E5fkH3JRsJw1wVH5bCSeT49iuqjUA9PjfUP82yU?=
 =?us-ascii?Q?YA6i5PKhf6o9Ts8ir6Av6YnutT4cLzSUP7hTxtXQE53m9pIeIuLxxwcVXjq1?=
 =?us-ascii?Q?CiDl73GF5GUgEjZ65jIORmvLzDTwV8AIM7Yl844K1E0JCzf37f4uO42CrfK5?=
 =?us-ascii?Q?zvnbSU8OXRkYyBTMMTdK1+V4c1ll1Iwnyk9qMzkLjKR/fIxhIYV0ePNFroOv?=
 =?us-ascii?Q?IUqLxYTpaP0yR29FQnzHgjUXAd3P1GgmvbReGWjPWC51yxIOPHrmWzxVBaQ0?=
 =?us-ascii?Q?BkGnOwFxCQpdC+59sbYK14C675IrdiFs2aOIUFmLmpKPEXJcthGJCAfJqXA+?=
 =?us-ascii?Q?Gi4RDvQCll6wSmnt2GkHGewV4AK529SaRl8HNHsPFMW8tRVM+0iQeZ7ZTXuU?=
 =?us-ascii?Q?3ZK182ARjCZnbWxex8qnzObnImXc/OY6tzjsa+oOvcbnYN62uKFNGHEgYWvi?=
 =?us-ascii?Q?broF4+ztyUlUNbF58t9LYvnu2gY1WN5N559GEfkxZuIM0iyzOgE+0rIyskOE?=
 =?us-ascii?Q?YaPjsEz0/GHp6EMZ7VOhxieAWTF9Be5ojljXmqvbOAQBCb0C8/ZsWiomdOM7?=
 =?us-ascii?Q?QRU28hHjT3PQ7mS4EmMSe+ZMOj7gnjchsp9mpy8sqrsuGEjFI2l4vmy/1CB5?=
 =?us-ascii?Q?INxQ97VgomnttI8NNWqZzYSpo1adn+JqVQW0gNa5FuvIhBMeWLmo6FHnM38i?=
 =?us-ascii?Q?OYxsRBuaHkhnkT7yCaY9IvZa5sYuKJ6ToGSv+Xv9qykPEUcuT6GA0RoYpNH/?=
 =?us-ascii?Q?HruwokgDJSyf6AfHcHrvCTyXN1p8ad+z1SXQHC2v523n4wH9rLHYlToJwsIn?=
 =?us-ascii?Q?/Chj7jYLa/EUjeaH/tgngzFXtuV2YRk9bFmxmG+1FHR9rGEXRE40HYVJXWXS?=
 =?us-ascii?Q?JFwEWQsrJMVUBCmGk08O4pQKvSBpwcgXInkuwxXsk+vWr1OBw0E+Q7IuIwnJ?=
 =?us-ascii?Q?54dbkcuovJrOiWKrl1H2qk1gsP9B8RBNkQFK385iKwzfceA30SJl6AWkKhDB?=
 =?us-ascii?Q?Fehxb3gZXj5rc4ianLd6Zqeb987X1Ne8EwCro/7uE3jOoq8pjE/YgfRgs2DC?=
 =?us-ascii?Q?n8cvl9HuxB488VQ9mdHZZKXjeF+eH0fxDQiRBIQ7G7ViUOwqW82a6CNzBGhD?=
 =?us-ascii?Q?p5DHabws4vmDfEQn6u6A+HZOEp76OINP9w2Mbiu08jz5h3nybTMuGuLKgIyJ?=
 =?us-ascii?Q?kosJdJugVv4r181EFyyStIzqAbUGKwjaZRugdwi8Z1wyhqJJjBEnm4WxYXYe?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef10351c-6895-454b-4e20-08dade35efec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 00:47:26.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJxBfUE7M+fkJYsl+XYs22WnUXjxqwup9iR9Y4UpCxr7Z181okNvpozGb2TJrpZ+n56nQRDC++AIAzrKr/9nmo9PoIzN0EHEKNDNJsrHOGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> On Tue, Dec 13, 2022 at 04:54:32PM -0800, Dan Williams wrote:
> > Luis Chamberlain wrote:
> > > On Fri, Dec 09, 2022 at 01:07:53PM -0800, Dan Williams wrote:
> > > > Dan Williams wrote:
> > > > > Luis Chamberlain wrote:
> > > > > > Simply loading cxl_test ends up triggering a null pointer dereference
> > > > > > on next-20221207, 
> > > >
> > > > Ok, my 6.1.0-rc8-next-20221208 build passed.
> > > > 
> > > > # meson test -C build --suite cxl
> > > > ninja: Entering directory `/root/git/ndctl/build'
> > > > [109/109] Linking target ndctl/ndctl
> > > > 1/5 ndctl:cxl / cxl-topology.sh             OK              11.84s
> > > > 2/5 ndctl:cxl / cxl-region-sysfs.sh         OK               6.82s
> > > > 3/5 ndctl:cxl / cxl-labels.sh               OK              10.14s
> > > > 4/5 ndctl:cxl / cxl-create-region.sh        OK              18.32s
> > > > 5/5 ndctl:cxl / security-cxl.sh             OK               3.35s
> > > 
> > > What branch of ndctl do you use?
> > 
> > Yeah, somewhat unfair of me to say "works for me" with patches that had
> > not yet been posted to the list. That's fixed now with this posting:
> > 
> > http://lore.kernel.org/r/167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com
> 
> I b4 am'd this after my branch reset to the latest pending today.
> 
> > ...and this one that is now on the pending branch:
> > 
> > http://lore.kernel.org/r/167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com
> 
> Groovy thanks. Progress, but still fails now on the cxl-xor-region.sh line 29
> 
> https://gist.github.com/mcgrof/aeac639365a651bd77f143cf38eb7493

This is also good news in that we are finding integration issues early
as I did not have this in my local tree previously. Will take a look,
although I think Alison and Vishal might beat me to it.

> 
> > > > So, what I suspect is happening is
> > > 
> > > <-- snip -->
> > > 
> > > Yes you're right.
> > > 
> > > > From 93bf2c04cd3a708c73c0e4ad7a4121505a0698da Mon Sep 17 00:00:00 2001
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > Date: Fri, 9 Dec 2022 13:04:26 -0800
> > > > Subject: [PATCH] tools/testing/cxl: Prevent cxl_test from confusing production
> > > >  modules
> > > > 
> > > > The cxl_test machinery builds modified versions of the modules in
> > > > drivers/cxl/ and intercepts some of their calls to allow cxl_test to
> > > > inject mock CXL topologies for test.
> > > > 
> > > > However, if cxl_test attempts the same with production modules,
> > > > fireworks ensue as Luis discovered [1]. Prevent that scenario by
> > > > arranging for cxl_test to check for a "watermark" symbol in each of the
> > > > modules it expects to be modified before the test can run. This turns
> > > > undefined runtime behavior or crashes into a safer failure to load the
> > > > cxl_test module.
> > > > 
> > > > Link: http://lore.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org [1]
> > > > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > 
> > > Indeed that fixes the same crash. However that highlights a few other
> > > issues.
> > > 
> > > 1) ndcl unit tests still fail once you do get the right driver loaded:
> > >    a) pending branch fails on the first test and stops there
> > >    b) main branch fails at the first test and continues and passes on
> > >    the rest of the tests. What is with the discrepancy?
> > > 
> > > 2) The instructions on ndctl to use an external module are easily
> > > misguiding folks on how to use external replacement modules, I'd like
> > > to suggest a fix below.
> > > 
> > > Details below.
> > [..]
> > > 
> > > Anyway I think we should simplify the ndctl README.md to just use
> > > INSTALL_MOD_DIR follows, thoughts?
> > 
> > Hmm, but scripts/Makefile.modinst already has this:
> > 
> > INSTALL_MOD_DIR ?= extra
> > 
> > ...are you not getting these modules deployed in the "$modules/extra"
> > directory, or is your distro not priortizing modules in that directory
> > over the others? Fedora seems to have this policy by default, but it
> > seems at least Ubuntu does not. That's what led to the discussion of a
> > modprobe "override" policy in the Troubleshooting section of the README. 
> 
> I figured this was the assumption behind made. I'll very well *aware* of
> this situation, and no, developers *should not* assume everyone pegs
> "extra" with for example a /etc/depmod.d/dist.conf with:
> 
> search updates extra built-in weak-updates
> 
> That is a distribution specific policy. The *updates* however *is*
> picked up by upstream kmod *by default*, and so stuffing things into
> extra just ensures ensures folks don't break things now by using extra...
> unless they are on these distros that do use that...
> 
> But it was *only* redhat derivatives that used it. Fedora's cloud
> vagrant image *does* not use it. And no developer should assume this
> generally for all Linux distributions.
> 
> The *real* sensible thing to do would be to be very explicit about this
> and have say:
> 
> /etc/depmod.d/cxl-mock.conf
> search mock built-in
> 
> *But* then that would mean ndctl would have to carry installing this
> *if* CXL tests are enabled. That also leave folks *not* using ndctl
> without any clue about this issue and so if we wanted to just be super
> lazy, we just use updates as that is built-in to the C code for depmod.c
> on kmod.git *ifff* the distribution lacked *any* depmod.d file:
> 
> https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/tools/depmod.c#n867
> 
> This has been there since the start on kmods since 2012. It's good
> enough for me, as old tools likely would not be used for CXL capable
> systems. Except maybe Android.
> 
> And so using "INSTALL_MOD_DIR=updates" seems better than having us get
> ndctl into the business of installing a /etc/depmod.d/cxl-mock.conf.

Makes sense, and acked your change.

> 
> This would also allow experimentations to see if the cxl_test mock
> driver strategy could be replaced by a proper upstream kernel sefltests
> driver.

Yes, I learned about this approach from this article:

https://lwn.net/Articles/558106/

...but that pre-dated KUnit. However, KUnit does more traditional per
function unit testing whereas nfit_test and cxl_test are quick and dirty
emulation. They are more for testing kernel-user-ABI than kernel
internals, but kernel-internal testing comes along for that ride as a
side effect.

> 
> > My concern with changing the INSTALL_MOD_PATH recommendation is whether
> > having modules in "$modules/updates" is guaranteed to work in all
> > distros. Otherwise we're just shuffling which distros need a custom
> > override workaround.
> 
> All Linux distributions without *any* depmod.d file will work that use kmod.
> Most Linux distributions has phased old module-utils for kmod a long time ago,
> 11 ago, the code for the old crap module-init-toolls hasn't been updated
> for 11 years and specifically mentioned being replaced with libkmod
> usage which is how kmod got started.
> 
> https://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git/
> 
> This is enough justification for me to simply replace the upstream
> scripts/Makefile.modinst to default to updates instead of extra as well 
> so I'll go ahead and just do that now and CC the list on the patch.

Thanks for that.

> 
> > > But this also raises the question of *if* using ndctl and linux-next
> > > shoudl one use the main branch or the pending branch? Can there be
> > > issues with synchronizing ? Or should the main branch always work,
> > > and the pending should just have the latest and greatest and *can*
> > > fail?
> > 
> > This falls into the category of a "good problem to have" in the sense
> > that I never had to worry before about others wanting to reproduce unit
> > test results this early in the dev cycle, so I appreciate the nudge
> > here.
> 
> Oh groovy, glad this is a step forward then :)
> 
> I know folks have been using run-qemu for a while and have mentioned how
> it is still a bit difficult to ramp up with CXL, and so the goal here was
> reduce barrier to entry even further by automating the hell out of the
> entire process with modern automation tooling. Since kdevops did that
> well for complex testing such as filesystem testing and block layer
> testing I figured it'd be a good match to bring parity with CXL.
> 
> So this also should now enable folks who want to say, run tests with
> qemu specific topologies too. It'd just be another guest on when
> spawing, and so tests can be run in parallel for each different
> topology.

cxl_test is good for testing ABI, but not hardware interfaces. That's
where QEMU shines and so they will continue to compliment each other.
Any automation that helps people get from zero to testing their CXL
patches is appreciated.

> 
> > As to what to do about it, I am open to suggestions. The typical flow
> > has some lag between upstream tools/testing/cxl/ changes and when the
> > corresponding ndctl/cxl changes land. This is because the tool enabling
> > does not start until after it is clear that the kernel changes are going
> > to land. After that it's another round of review to settle on the tool
> > changes. The ndctl/pending branch should usually be up to date by the
> > time -rc1 arrives. Is that sufficient?
> 
> I think it would make sense to always assume that using the latest
> tooling will not break anything and we should then be able to always
> rely on it for all automationf or bleeding edge linux-next based
> testing.

Latest tools should never break, but that's different that saying that
tests should not break since tests are hard coded to the topology. Maybe
the kernel could publish a version number that increments whenever it
makes a change that breaks existing tests. Unless then you can notice
that the failure is due to out-of-date tests.

At the same time I like the flexibility of new tests brewing alongside
kernel patches and then taking the time to review the new test code
while the kernel patches move ahead.

> Tests however should then always look to see if a feature is available
> and gracefully skip if not available / supported by the target kernel
> being tested. This would then allow the *latest* ndctl and pending
> branch to be relied on to test also even older kernels. That way, new
> tests, but which can be useful for testing old kernels, can *also*
> be enabled to test things on those old kernels.

The tests are backwards compatible for older kernels. It's the older
tests getting confused on newer kernels that is the problem.

> And so the latest testing userspace scripts should *always* work with
> *any* kernel. It should not assume you have the latest and greatest
> respective cxl_test driver. Is that something we can count on today?

There will always be the tension that the user tooling not move ahead
until it is clear that the kernel is moving ahead. So cxl_test changes that
cause kernel regressions will always hit -next before the next tool
release.

> Then as a developer, one can assume / expect the latest and greatest
> both tooling / testing will work regardless of the kernel.
> 
> That would mimic the experience with using tools/testing/selftests ,
> even linux-next selftests are supposed to work on older kernels. The
> respective old selftest modules would just be used if they were enabled
> for the older kernel.

The difference there is that you can check the test in with the kernel
change in the same commit.

> Then, a few questions, but while we're at it:
> 
> Do we have enough experience at this point to say what things should be
> tested with the pair cxl_test / ndctl test suite and say what things
> instead are probably better tested using qemu?

There are some things that QEMU may just never support like RCH
topologies. In general cxl_test is amenable to small hacks to test a
driver corner case that are a much heavier lift on QEMU. On the other
side, there are things that cxl_test will never support like register
emulation. So, I think both are needed and complimentary going forward.

> Are there tests, part of ndctl test suite which likely would be useful
> for non cxl_test.ko usages, but rather run on spawned qemu / bare metal
> CXL enabled systems, so one can just hammer on them?

Yes, and nfit_test has an example of such things in its "destructive"
suite where those try to mutate resources outside of the mock
environment. To date there are no "destructive" CXL tests, but I can
imagine, for example, cxl-create-region.sh being modified to run against
the ACPI.CXL topology instead of cxl_test.
