Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8835B67F0D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjA0WEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjA0WEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:04:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36159EE;
        Fri, 27 Jan 2023 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674857053; x=1706393053;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pznPbiY8D9qQCjpvvRXI7O8YU+tV4J0poZwlsWDGFeY=;
  b=iHBH3A+6Rs/QdPw0ZwR8oUTkUMYN5TKyaH111h1WhaR67IjG2CgV7TtO
   1EwYPeH+dZ6Pl7s14C4+IDmo5EuONfT0j14Vai8RCfXpPuYalKiwcXoYY
   ySWIvzeH5hxOptjtvYtf15atm/YrXsHwMexKLFtT0YtVojBB0fOY3k8Uu
   cLxJbQ8B3e2JZacXOCisn41voyUO37K00B9BSVROfO8AftFVNGqRT0OLN
   WyB3VSbOW5a9KK190sqQNj944BJ8Xaa+KjkfwAYpwsGNYMz4gHG08Lw1w
   rYTzSi87uW4GxmavD6DsYqYsj0namy5p7LPaCCwc2d6KfYN30i6wQ9WmL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="328492799"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="328492799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 14:04:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656752342"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656752342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2023 14:04:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:04:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 14:04:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 14:04:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/zXzrLvtRh0JXZ6BENqkmRxRJiY68dHSHJJQYdZA/sh15D1LIGHDUkW2/xLARhFihpqgtIeyWTzNO2DwFaeqlt8KMWasA9zEMtO1nAyEiliNnQrUQo02zYZY7SvQFys6VbQGYsVwWyd/QeicQ0M4MhqBAWoPp4S8xO1PIKGtyw+W/cyNiTU5xVWktVeCluYimI0FqfJpkItgQna83aQTsN8/Y5nWKwtPxr77jfxWeLYJFPywOm33eMoY+W61I3bGJ/MRZrZGMLK/HAi2TjRTtwNDjULXoSRuIqETR25TfIOMEFsEwT4xrjlcQ0bxaRKbuzmKZwdqozk9XRVf+KadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njcNDt3bt8uoM6nwiy94YYemoNBOT+aPwIvv/IDO39c=;
 b=Firr+W/deB8wKzTKsjporrSFtStY26e2Vthv+kX0O/lILoET4xlT0dSCzYtADunXB7O0XTZCEUDf49GQovB1n1Gh5ltVNu0YS4UjAH9MZpM3fawnYvAlnGnpHuow6Fc8bv4Lbz5qZcWuhzJj2j8aQiwQR+XxZi19X62LDkXsA55ODXm8r1AV0s3NIa4zq9zcapr1oX6uG4JK/dxSTNJeR56256KnGcyHL168ky0ZOxzVrirGz7GYaD86o2X/jMZBmFzgCXQyAW6lUZMIlCQ6RfAtW6FMVrDtIzlB/SXJiJ8+BRY4RuEpTs8M4ZgFRVbE2OKGKtEaghxVEKDD2OdozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 27 Jan
 2023 22:04:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 22:04:08 +0000
Date:   Fri, 27 Jan 2023 14:04:06 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re:
Message-ID: <63d44a562a629_3a36e5294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <63d32fe783ee2_ea2222949f@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9P3ipL28W7N1bLm@aschofie-mobl2>
 <63d423218e854_3a36e5294fd@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9RDxWwKX+OPl7V1@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9RDxWwKX+OPl7V1@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 3377c3c4-8e54-4ca1-8059-08db00b269d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sGwFSrj7QlkvDjrLUEobjsyHRFPYgVUq74zaYa0SeSnJTVH7Qxk/QOOjvjmC7f+8j0DNrQHtTRWoRY7wDYLi9ldaYOzGW/fuDw+m3bclgh9MyPhKjZTcQHlaBhqWoOUCUoFrGhwiFZGX65zKcdsjiiEqJkYHcMO6p4lrNKlVVpAUfhD2B38kCGj7w1/A7lot4uUCgkwJUmF5DwjasqO/1dQdONXm5U+3I37R+t2j57IX83+7dKq46xyEctJsj/TS4DztSX7YYHSYwLMYLtBDjb4Jmd1wQMw6mvq2/aplc2uWn2VY5pTEs+byy8En88BHVkSQmtjJllQkRd2LwB98XdPFmYIGe/zqTCkFXmHxQOnvMBnEc/bP3nE/15uhd+UQ9clDgGshikKzTfDCs69ApFX6VLUGpud6faCtunC8psJui1zEquyz/ZkPcHs12iqtgKt+jNcSEqBuTAXnbbA82ML2e0zUx89EC3I+fUNuzPmIWF6HaXoOEhHZUCCA5e5+eX9YvafZfe1a1IppZDo3rZGH3JnBGWym+HguhFOqMmQac6d41gCzd0d3NoKPbdZYnFWJ5WaBW2s4/gNy1e2QFEY1LBAAEj8/C67JxaEuWYLrvTOyyiYL0FIF65gMNe3horE/EwWdkD6xCfvQNpqucBnaBg+jso1UVoObR3UIPU0c8NO8tY5hE6C14Aqkct5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(54906003)(7116003)(66476007)(6486002)(8676002)(66556008)(66946007)(4326008)(83380400001)(41300700001)(86362001)(316002)(38100700002)(3480700007)(82960400001)(5660300002)(8936002)(6506007)(186003)(478600001)(110136005)(26005)(2906002)(9686003)(966005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcZPfJtJtiJtiH3LJUSQ26kvgR/LIyUR/ULRgFtLlS7x9x88iAZUj3od/WWv?=
 =?us-ascii?Q?ZXSk/UuiVWk7GINe+MsuUa+1ssZgsn9/e+sAz0Ne+bCxvzUOxzNZZiDEkDcY?=
 =?us-ascii?Q?F6MGqAw69uB7nagQvU+pi6sksYVm0LQJ//wv/Y8yHxm47FU3/DLT48s8DrQW?=
 =?us-ascii?Q?pU/plP460VfmUig74JvOKjY5VIFmGZD+5J36Qd8iZWxgHon2jcg0NH0IgLRJ?=
 =?us-ascii?Q?S0923HOBvvDZQgcLYBfVH/zknouKrjSx/kUcD48WvSmRrBVY8lt85vvouPRp?=
 =?us-ascii?Q?lrSmgR5Hfs5MX+wllWKCmsxvfzFmSFS2ivSYBGSvbwgPLo5kW1N6lfS2ANBQ?=
 =?us-ascii?Q?SAQ+ip+oJG1sZ/sJaXaXPxdv/zk6Er6dEVGKpVW+7YO1wkkvTJFXAsjDkY89?=
 =?us-ascii?Q?O4A0fTObD7bfn+ZyBg/3p6CHs+TrXG61XmuGPAw5Y0yL2qE/FBFDo1PkroD0?=
 =?us-ascii?Q?e8m4bLV6X6AtZUmzwkzCgUdfM7xFByOqsAsPlJ0Vp7yNgvS+di7ftXdeYosA?=
 =?us-ascii?Q?/jmKVlRivsQO2sDRhV1SPCoE4evvTRodCQR7WKVrLP9QmcQGfRPqU+DdeBZD?=
 =?us-ascii?Q?t51vadAVf+4bF7ilRy/jADfmP9CuJdCDk64JbbZHrCVZ6jumZeMnKhi+acse?=
 =?us-ascii?Q?6XitQq5pAksCppxgTgelXqohXrDKxn5oJ4McMtsCXbj6U5f7AMkTboyvO9Ah?=
 =?us-ascii?Q?BvKB0k9aKZtBGS5kIm8fJDMicJ5kuTR4UyE53uvMIil3GY0YT12UEGkfdpEj?=
 =?us-ascii?Q?loYq26Zt1pny3FlsrBzVpmGRp7wHvNe2tWTyC8j+ey1FeCAXGtRWs7SmOQP3?=
 =?us-ascii?Q?HYJkOjeaXMGTpJlEGWpDSleWn7k7pJzppiyvbvecHYfV+EUDujRM2bqbTgij?=
 =?us-ascii?Q?4Ian2w6WM2CZdFZD4nLZRSbZ4EtmMfaeeZjooQi5x8kddWVU4syYfTaTuNU4?=
 =?us-ascii?Q?cMUS58Wk6Atz8fzh3z30p7GP9f5yuwHrbeXcJXed01sUKAhC85yADX3TBGEY?=
 =?us-ascii?Q?cLXhgLVFjkoi2XErcPi190MdnbpYDTyT6Pw7rwXnP21+syx1tXbeyqxzI7Sg?=
 =?us-ascii?Q?1eM9UjOx8eRi2hi+Op7+/j9r8Q+xqwifb/DpVVZ8tYx/lw4clnW/vU03yKWF?=
 =?us-ascii?Q?p4tjjzmeFdTmLMVY/xT6f96VqqM/Ua7i6HM14jHrxB25c1t+eKkMA68SHObR?=
 =?us-ascii?Q?XvtP4npBJJcTpbT+/K+Rye/auTenv8gzOSnVzqDWlcE6iLZQGVB4sid/wcqi?=
 =?us-ascii?Q?Nj+M/DT019+xqwwiLj3n+NVanT8UgEV+SYs95Capnm5acpAyG0QzzxobWkJB?=
 =?us-ascii?Q?b0bhSRkSqwwiEhndNr7mCZ8yWxg0LEfs0+R2BDKPGPXBWsPYmo2TLBq+4cIg?=
 =?us-ascii?Q?WpL8+epmpH0wQTMqufAG5j5jyqOYObi7nACuDi1gW35w0AJRx7X5HrSxkmc6?=
 =?us-ascii?Q?R7EpmnC8fXeKr9x/92Chs5LW/tQ4DImWKrY2nR0u/vEyeLtHFCoEy+dh20cT?=
 =?us-ascii?Q?Q31lTIY13ZYQTVeADqcgTpTnh4UQtIWZJlS1VasAuYGNX7bd21FESKb4NCWR?=
 =?us-ascii?Q?+OlE9DAgj3Gkh6rabbY1FgaA6WHztUe2+2o9MX6y4MErlOxfGWK+ZXvSwHBl?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3377c3c4-8e54-4ca1-8059-08db00b269d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 22:04:08.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RSidCcnG15o0drWIOM7VoSwbYs6Pvsk7Fo+Z2TsUDo0ayIJv1+3+QWmK5uwlxfGp9LMsE6B1Tqx5r4H7zjBDQxb9e/U6/J2OykaBRrfDLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
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

Alison Schofield wrote:
> On Fri, Jan 27, 2023 at 11:16:49AM -0800, Dan Williams wrote:
> > Alison Schofield wrote:
> > > On Thu, Jan 26, 2023 at 05:59:03PM -0800, Dan Williams wrote:
> > > > alison.schofield@ wrote:
> > > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > > 
> > > > > Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing
> > > > > 
> > > > > Changes in v5:
> > > > > - Rebase on cxl/next 
> > > > > - Use struct_size() to calc mbox cmd payload .min_out
> > > > > - s/INTERNAL/INJECTED mocked poison record source
> > > > > - Added Jonathan Reviewed-by tag on Patch 3
> > > > > 
> > > > > Link to v4:
> > > > > https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/
> > > > > 
> > > > > Add support for retrieving device poison lists and store the returned
> > > > > error records as kernel trace events.
> > > > > 
> > > > > The handling of the poison list is guided by the CXL 3.0 Specification
> > > > > Section 8.2.9.8.4.1. [1] 
> > > > > 
> > > > > Example, triggered by memdev:
> > > > > $ echo 1 > /sys/bus/cxl/devices/mem3/trigger_poison_list
> > > > > cxl_poison: memdev=mem3 pcidev=cxl_mem.3 region= region_uuid=00000000-0000-0000-0000-000000000000 dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> > > > 
> > > > I think the pcidev= field wants to be called something like "host" or
> > > > "parent", because there is no strict requirement that a 'struct
> > > > cxl_memdev' is related to a 'struct pci_dev'. In fact in that example
> > > > "cxl_mem.3" is a 'struct platform_device'. Now that I think about it, I
> > > > think all CXL device events should be emitting the PCIe serial number
> > > > for the memdev.
> > > ]
> > > 
> > > Will do, 'host' and add PCIe serial no.
> > > 
> > > > 
> > > > I will look in the implementation, but do region= and region_uuid= get
> > > > populated when mem3 is a member of the region?
> > > 
> > > Not always.
> > > In the case above, where the trigger was by memdev, no.
> > > Region= and region_uuid= (and in the follow-on patch, hpa=) only get
> > > populated if the poison was triggered by region, like the case below.
> > > 
> > > It could be looked up for the by memdev cases. Is that wanted?
> > 
> > Just trying to understand the semantics. However, I do think it makes sense
> > for a memdev trigger to lookup information on all impacted regions
> > across all of the device's DPA and the region trigger makes sense to
> > lookup all memdevs, but bounded by the DPA that contributes to that
> > region. I just want to avoid someone having to trigger the region to get
> > extra information that was readily available from a memdev listing.
> > 
> 
> Dan - 
> 
> Confirming my take-away from this email, and our chat:
> 
> Remove the by-region trigger_poison_list option entirely. User space
> needs to trigger by-memdev the memdevs participating in the region and
> filter those events by region.
> 
> Add the region info (region name, uuid) to the TRACE_EVENTs when the
> poisoned DPA is part of any region.

That's what I was thinking, yes. So the internals of
cxl_mem_get_poison() will take the cxl_region_rwsem for read and compare
the device's endpoint decoder settings against the media error records
to do the region (and later HPA) lookup.
