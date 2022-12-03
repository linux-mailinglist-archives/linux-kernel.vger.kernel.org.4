Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0699641926
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLCVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 16:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLCVBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 16:01:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF21CB2D;
        Sat,  3 Dec 2022 13:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670101263; x=1701637263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/+oKNe0p4OnPTz3jGGUbN/3FGoX3uMk66wwNM70G7yA=;
  b=DMOFHVgbiue7Ywaqxm8IfN6ZwGDfIkJs/Kd/y8aTGYbzIK3wpF5UYY31
   1JFhJWs7t4zIu8l6jmvpQfKoW1yOqYQSnHByoRStkEZ46I1Rw3eRxiJy6
   mLKdMs2mmwW3XorRxUGKrZ/LTJHsFXYHy+QruuNtyZfcy/scUAaswY37F
   aW5/tQbuH+Ptg6I+VFxRUFEyH7J5eNyWWBFS6LkFrxZjWIU7NIvnAvTRV
   iaDwS/xmYMvfXuNqhD4o9wI/294QWdkoq3casMGTTcy5XOVoTy4ALGCUm
   IykgpDpBXki8U1udJ7R66Hpk/m4Kf22EMNbNx74tHOwSIG7CAuCFaplP7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="303758715"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="303758715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 13:01:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="677943444"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="677943444"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2022 13:01:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 3 Dec 2022 13:01:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 3 Dec 2022 13:01:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 3 Dec 2022 13:01:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3RECdi83fEanQRg/0W2B73N8Z2xsFV7xVcJBIkQ9u5MLWh1ItGhqVJg+4uQHY844ovLXoHaVab/KNXp/rhWz95vyUvaQvfx8uRqk+/UwlWj4BAiKgxTVkTmY1u6HH+FdEVGP01sExcWVTgZ2hZQ97nR48RuN9qdQspC1IpXtUZS7nNbAMIQRRyUcgeDJryhfe+gwRrJXMZp4xV2NOIUqF16VnaVXA76Dntu/vTrhxDGh/Vy0rpuh8+KGaKeyIxTO6DRnlE0e2vE321N4DOfLPLoQpl+66wfAnwKZBLc4DyNzkgBoy+CMQzCiAvT6F+Evv6DzjCvBqpTAwQU6rvS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOPlIjICUjkhulkn1zje89XfKem700xe/UUo1aLPusQ=;
 b=W+JqQVZH+Bl2J/oAGH3lJYl7C8zfoLiHREJfwP/Vq4W5NarGdtocNji1x9L7beS5YnmulhXgwCGV/2zq07UHz8sJIUBLIHzGmkwZOpv+Mq0ElqYyLEs8lYh77MChxgW/SaJHcp60aHx3/HhtrIYmolFHusAga1ZexofLA9w9WjGMS2V3iXlkdvybxWOpYFfYOi6fXS7xv95GUzp58uu2qhiK5BujXZG3UFhett109K+6rUPp05h1xiPFowBry9tCN+VaPo+liGdt/fhZt2CDTlWzVbqk0qaelAWG4ODAKbFsTus42RPyYCgese5Briy0VPw1IPUsd8DlU0y32Gtkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5361.namprd11.prod.outlook.com (2603:10b6:610:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sat, 3 Dec
 2022 21:00:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 21:00:59 +0000
Date:   Sat, 3 Dec 2022 13:00:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Message-ID: <Y4u5BoSm9D90jbp/@iweiny-mobl>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-5-ira.weiny@intel.com>
 <6389676c60d39_3cbe029487@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4oo+rxYAyBoHexo@iweiny-desk3>
 <638a8b7c97ceb_18fe029410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <638a8b7c97ceb_18fe029410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: f62136cb-227f-44fc-133a-08dad5717a5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPbBGmkOcWhGu0fJ2xxofRQU3CmFm2Oh9sWffghs/VVgN14PFB8kIp8g6xCGvwf61/cC93aA3RGYexrdnx9bWRjHjUa+INAxKA/S945By7CcKvgZnnEdEacttWWp79TMZRGH51OdudbY6ubXvVPOJWCleeAu559AM5lYJkRxOPLnJiJ0XJRlmFIQ0rXixGWGMcC5PvGJM5IX7YMQyoxsLh1RiK1Yq+3u5srmEiL9vCke5pNeQzOEhoGt55NXSO06Kgy+1vqeCTBgdNJd1JqKprxqgYf2txAyZ0MkYJ+SDPiav4BjZcFdhpraFkUrfPimC4B8jg/X5pk4JTV7hbGmRKyj9yvNSaNgxIBkXwNS8DTazvlNMW0LhOeeJ5ZNwRS8QgoGK/12uqkCtM85Ju/TLp9ySRXZLr5lg5btpVRNGAmVLndODNjsSAVi0dzr2sfG/u5nPjxlDB44i2JpM7H/RCgfZy4uSoBY6y0z+r4c++MNZJ3WnTA5y+NbM8BPephhD8JRj2cOsXViIEk3+EmOtQRcH9/mwfJ6Tpbei1/ClG1FIta70NTvANwWAOZ5mcnJAsfXTr693nnOvhcpm8uSxgOAy9Y0dO1W74vEfAL+HAAE1YupSoUufTZe/fObrrZ7DPCQywDmGB/jUfchKUcIjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(8936002)(44832011)(86362001)(2906002)(5660300002)(4326008)(38100700002)(82960400001)(6862004)(33716001)(6506007)(186003)(9686003)(8676002)(26005)(6666004)(66556008)(6636002)(54906003)(478600001)(316002)(41300700001)(66476007)(66946007)(6486002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IfSFfVwBBs/bsoHEIWZGx4aaW+Yriazvcpi5CNVmSDAMCRYWCGgh/D+eu/D?=
 =?us-ascii?Q?Cclhb/2lWiknzb6dVtPwEANNoHPSlUd+DCSKgh1vQSgp8RDCw/fpB8Ddp5TT?=
 =?us-ascii?Q?HAL8GgllWkGup8ZVGCbSA+wtfGSqqSGc1U/I3BF+BCgiIHOUbFtS1rvCVkf1?=
 =?us-ascii?Q?ee25ck4iqHYHIxjhzxG+dTucLy8fs6IRLr63K2xcr5qCTkE3gHs3vV+Q4bj0?=
 =?us-ascii?Q?3xb73RqXEfN03ShBfRRZ0sRWXnm/+fOiEn+rFqhQZ2oLlboBDydkhneTmfNl?=
 =?us-ascii?Q?WcXOv9Ij6/KIQD+jfiKyyT9gz7GEorqRcxi3Gno6AhenW794IBJECPSQCwtG?=
 =?us-ascii?Q?BsXkm44Iquk7jLtjHsRjWIG6fplewyI1d4S2Q/yiPa3WSQu2IoNIohPT8khJ?=
 =?us-ascii?Q?g9WqAxAIIeHrmaSOI2mpeNlbPo/vuippRanquo84p5sIbAnEh4AsPkla9ffR?=
 =?us-ascii?Q?2bEDL6BlECYv/HelHCzzQIHIVzOeIRJuyY8q1EDyMp+piR1aRMHY/i/B8OHG?=
 =?us-ascii?Q?470uXJo8xwuD/QBQtp1MMqJpnaadEoarQ3vv7kXsaccOCBKBMwh1UTR7n1HX?=
 =?us-ascii?Q?HJt9UfsUopX54UFtdeJ4DHIpMxB6SDFKkq4Sp0EshsH/FvNuqp5y9gS7D+6X?=
 =?us-ascii?Q?E1zz0feZAiwcj7/7QGN2/1s8tNjP3iwAjfy0RO+sPofH5EPd71sVSJehwYge?=
 =?us-ascii?Q?LwNaEH5SLrxqykBTJ7EZVAjJrPquiU7C5WWIQFJRId2XeNmuk5xz5XNleKN+?=
 =?us-ascii?Q?JzQkSf7rxUbPweaTLC079xDm11+8OWbQjHZvIhK4sKplx3xpMzk18Zn9uV+J?=
 =?us-ascii?Q?N7K4oc4aZAfjbkKuR7/BpiVfturIVmbtTW9Po1QWCCExe53cYkjX28UJLRgZ?=
 =?us-ascii?Q?xdeuQ94j44+cq1IG38bsi21Yjx6wzo83VHa15z2bM0n3ypyQN4YUdSwPOJWC?=
 =?us-ascii?Q?n1tRkVSZbIcrtwyGIzy5SFZm5ZzqNKeZuZcDNPrWTkMzgup65ECOO0LLURGU?=
 =?us-ascii?Q?I6skUViZchTyDyRAYMY1kPDC1NlhZ9XuFvgs1w208xaWWlHEsh42n9KkeKhd?=
 =?us-ascii?Q?1/Q5sf9Mn/TMfcqEoiaKy5b1ELBB+RpRPfGYPY3OEqY4WwwCEq8n/o8y4qHo?=
 =?us-ascii?Q?4qSdu0aAa0op0PbRc2LjR2ou2FM9ckd7E6BE2IbZ2DTQAP/nt2U45vzv9Ywd?=
 =?us-ascii?Q?ssLm5dEyZH9x1XGKkeSoXtgZP2+xd5+muZ4NoPLD+x2BYks40Di2IOa4x8B9?=
 =?us-ascii?Q?qNoTYMWOV1e6gOXxAid3m8EBHDFcb9XafWFP8Mpw/r6T6p+fP+FhS59bcfQ0?=
 =?us-ascii?Q?FWjfxsI/yLdHA3uv3jlAKrmHH7O7gTyRZfsvoAVqlm/Htr3Pe7tneAE87oFB?=
 =?us-ascii?Q?gRuMjz1vtrUz12Ls2hVGFVFTrByRliVLGeeN/bO6VBjgKa/Aj+FhgvXrw1Zc?=
 =?us-ascii?Q?oKhmFml4MMNziX4fpWKXZHPHxDMIb1xQTzsFa3nrOH5vhu6lknBI1U3n0IW8?=
 =?us-ascii?Q?zHEfKO8sT78Fmn50RzJRQmJ251P0h6g1qwSFm7zrVTTWGYepACY9zOQGW64Y?=
 =?us-ascii?Q?WOD8O6YOurbdCnfbsw+BY36QmMOiUsaV6z3fN8B7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f62136cb-227f-44fc-133a-08dad5717a5d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 21:00:58.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWA6bMjCLK/gCOgovXWk/wus32mHaOApKRCs3livf/dItZm893XcmZBIJThdOrR1npEXop+pqS2U8VKtQP4BsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5361
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

On Fri, Dec 02, 2022 at 03:34:20PM -0800, Dan Williams wrote:
> Ira Weiny wrote:
> > On Thu, Dec 01, 2022 at 06:48:12PM -0800, Dan Williams wrote:
> > > cxl/mem is cxl_mem.ko, This is cxl/pci.

[snip]

> > > > +	cxl_mem_get_event_records(cxlds);
> > > > +
> > > 
> > > This hunk likely goes with the first patch that actually implements some
> > > mocked events.
> > 
> > If this patch was squashed into the other patches yes.  But as a patch which
> > does exactly 1 thing "Clear events on driver load" it works IMO.  I could just
> > have well put this patch at the very end.
> > 
> > Now that the Get/Clear operations are more settled I'll split this out and
> > squash it as you suggest.  Jonathan suggested squashing Get/Clear too but again
> > I really prefer the 1 thing/patch and each of those operations seemed like a
> > good breakdown.
> > 
> 
> I'll preface this by saying if you ask 3 kernel developers how to split
> a patch series you'll get 5 answers.

Indeed.

> For me though, a patch should be a
> bisectable full-thought. That at each step of a series the kernel is
> incrementally better in a way that makes sense. The kernel that gets Get
> Events likely needs to clear them too to complete 1 full thought about
> enbling Event handling. Otherwise a kernel that just retrieves some
> events until they overflow feels like a POC.

I've squashed it.

Ira
