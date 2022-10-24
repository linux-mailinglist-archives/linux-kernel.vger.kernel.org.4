Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27160BF67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJYASJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJYARr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:17:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFCCAE79;
        Mon, 24 Oct 2022 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666651077; x=1698187077;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ci8vjoVslJECaZHFVElByFsFFQsBC7mNUhXkm/eJzO0=;
  b=PSV5iEQ/zCX6dVeZgywgXe9aQNLJ4pKLRX/0ZYI7TmMQ27kABPC5+Z+Z
   +SMja8854WRNtxc/zS+/g9YObUKCIA+lnthRfmsF4S6YSVVk7XBDeK23q
   BnW5ccEQpkUuu94NpBPyTbMEhPRZpLuf5PFrw9H84ZE8NWSK4nQAmGxwB
   X8Aa7BIpI5UHlGaZC4afSyQwnsfQDiOqQUgasSNOlA5dzvWzNywP9BlEQ
   gonYuDeTek9JO2Hz/LBdU2RCo0wyxw3LR4XFcaYuHGfpmMTYHfTVsoRh5
   walXGhgQeop/RCx37p4npMNnphe2J1+MK85xdzo791BoWLRSODyflYJWy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371753534"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="371753534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="773980838"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="773980838"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2022 15:37:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 15:37:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 15:37:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 15:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw/tECh8WBini5zIxS0HA80d87PSm84Ae91MYfwzzJTczzzu9GQDOFLDThqUTwAsrLGXVswMskKSsEnM13wKBGZ4bMjWrEKoMV4y7h8E6FJPnXIjRrdev5XM2dIeNVX6/8c/8vThvj4eBKihFYTJHxLYXEmh4E/RdvL91QEbJAm/K9AdQ6GZGeHkDn08T7jQx0LEahT+J36NyN0sBcNDS03O0qkSJF2wtSo7EQq5mZCxBfdL/7j06C4S/3yL8IjUzNgAWUOxteXqTGMe47Mublzz6JdSKvrjuCmY1mxjpBcwWCD1Dwe6xJEVpwwx7cRM8GNJtgWrSnnyFDrEP5/sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEXi/Ph5OtriVkB5vGK72iPrIumOQH+hig3K+pdUJvo=;
 b=h1SVOOZYMwXOxAlWwZizGgBltoPrRtRsdjYBU1NMMJSDDlexjtFt6/hMSb/0brJvWWhHpVnwPOGxah2z9VlmmKXS56qrCOYSB3EIXai4yGgMvZZN0JkWTAQjZy6rXCt7fNaDItuRqZ3TekNr2oWMFf9/3Zkj0o5d4xo81FWKwtU1aSkBrrqsC1bPnYbdWifOCWHrFoeUpGfoBhgkpc4NmhnVPOvfJQutT4EJCUq1PwUIVoTMENrqj59enO23A8ll0zWowgjbq+g5ZJDmoCHExtVjHqqYb4VimaHEIlrPJusVdbcoo5jJwSFHQb1UZvctfXdOaPphcYc0EJawTQjfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB7248.namprd11.prod.outlook.com
 (2603:10b6:208:42c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 22:37:52 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 22:37:52 +0000
Date:   Mon, 24 Oct 2022 15:37:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Terry Bowman <terry.bowman@amd.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <635713bd6bc15_4da329434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y1b92DF0c36/QDbo@rric.localdomain>
 <635702a652637_4da32941a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <635702a652637_4da32941a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: f52465bc-5e33-4081-0c5b-08dab61062c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUclEOftkBIWSDf0aWk7J1J2X4eX0sjUsXjBH3sl63a2iRS2XmNe1VGGJePtdL08I+DNi3YM4tJ7xIo6E/QDsZB9QDV1KFgjEH8PaLs0gT1BxdSKwoDwcZ5ARxtEndwxjS+qHzhWhpEUWdpkkixDd9qDuH6L7Cai22WMY3JVixXIqhUZrvajVo49m7h/HtxOGUMofUtLYdyHe/TIAlh4a/5YpcG+nZz4/ZRI6bbampJQ36BrgXMstqcvL24SIsnlgYJSbsICbz0GKpNxQ0SWqx71P0w1fvRuPKFws9wa0g5ngL3sKozlWpkF3FKON7MvAM1Hhm25dt2oy7i4tImhCMrXrMzvJyZk3+LXZ/jTV6usleMoGzQhuZ0oZs1WXXVHWB4bTPcxRdu4NozkZNDFes4TiuVtdAyM2+D4yQsEBhAQ956cMabM7iK8Up+xDJ8leID9zspQNQXUH8Pw9thxTDXeyFVzEUrGk3wBhcIjDN8sVkvfOgKRBCWg4CKra63vv32tqTbmLFOtLEbTX5BRXtMWuLfqCMxr0gWZ3XkfCFqk6Z9LYth2ZK4Ggtq0nHhsleGXLCeeY8R1L3Z1Bx6DaghnypC08/JN56ZhvjzWb50EDxcozzZk7fDFYMrCz7WDNkzvK1NTPSfOtretyL5mZ749kKegDY/J3a4Eld8nJqXQvLylBHcA8Xk6ODx9aah6j4CpaoPsX6TkTjOqYd9Va6kVA51axnoZUUHE7CnXXpZnw+pZQAGgXvdZJ/pRKvXY9I9Gr3GJM+oo2Mv8jyeA1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(83380400001)(9686003)(186003)(6512007)(38100700002)(82960400001)(2906002)(5660300002)(8676002)(26005)(107886003)(478600001)(7416002)(6506007)(6666004)(53546011)(6486002)(966005)(66476007)(54906003)(66556008)(4326008)(316002)(41300700001)(110136005)(8936002)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zY203aiYEE8wLnCFa7ljsgk0Ym3UF/Z4Lmt+dr9tKf2b2WxaOSaUucIhvZpl?=
 =?us-ascii?Q?w8Nc2zXVvM0WEeyegcOPWXqk1ccLWjNNCDTMi/+28eInh3DOTnbuOBpYSwHs?=
 =?us-ascii?Q?C+bEAi1OsSe5pB9pYmWz5Ua5PXEh+GOHyyoohgwXB6BBqdoyLpWa4mrOheCC?=
 =?us-ascii?Q?dRoxUpVvSStKO38JVYS0xiqVigf83j6rY7cIdtzjgEdEmOYUdgL6jG9p1TF8?=
 =?us-ascii?Q?a3awjHorVcV9LtJgKZZj7YeuJt/1dsj4g6xvmrddQN+5Rh/XHb/P/+5ccoaw?=
 =?us-ascii?Q?emxi5sZxSfVlnLCLE0OucQoDy7lUXXzmo8JWJ0kF++ikPJ6b0SjCVVcqi7XT?=
 =?us-ascii?Q?L/zS+RGkH0QppMm90bX4iE4z2j0+pkpt+GVxMFLa9G3rbLSDlzcMTmbA78a5?=
 =?us-ascii?Q?Prdc1OcaV2QRumtYP+NF1eArBBxLb/dHnaPQ8fOPjUPSEM2TkfxbMMhhEjqK?=
 =?us-ascii?Q?T9PVlCaWCjRV/V8AgphYGMRq/bMqjcR4mhXO47Th0C+H7vX1KFxlc0e31H4v?=
 =?us-ascii?Q?mQWaAfKq9/1QFCDHdQGHlNvZe5ttJUvWI4+Qg5rcXGsMHZjCLaKhibzkme3J?=
 =?us-ascii?Q?pgbB4o3x8G5hPoIF4mkiMi6yKJuKZjdF0J7IOiSiL4cR1TK9gphKZETsR3ly?=
 =?us-ascii?Q?aAmj83KcBEHpczNZyUt+ffTqRqmZeQ2uiJvCjyhLaip34eKuo0Qchx60rFJE?=
 =?us-ascii?Q?Ozdkii2wjEGkkGEg8UaSYZOzB7SiNKsR64oq9ko/sWDcD7aXNZflTUSGteFN?=
 =?us-ascii?Q?zIOZ5mHb5vT0CVnEb1zuAuT9jPZ3+MWGmswMnYntVoJbgngGH6CzfpP6HUcN?=
 =?us-ascii?Q?H7jyi09UA9/weFwBv0UeHGQs494UKLQXDND2/sqwGDH1unTOgCd6Hs3+lD3s?=
 =?us-ascii?Q?2TwMUhq0jV7H447v1sFQpHfsHP13bb174YliRJdLsgSdc4PTGkw1ihmNhucG?=
 =?us-ascii?Q?OnS9grwJ30pEteKWTHRhF6UnEBF/UKPeuy95/Dl6VDLX6A5mMaTh7JPty9Dg?=
 =?us-ascii?Q?MapowCFibuIhQtIxzj9TmiM1R4LL50R3N2qVLNNT1hDI5iTpC5sE0qiVxrxa?=
 =?us-ascii?Q?NQpKdUUncH43lnDFioox68sWJo7x0ZERuJIYb35X8SQ/Ve+XnqXC3ryG/Hyl?=
 =?us-ascii?Q?gqPq91QNX0WyUt6rho1J47ZkPBY5+5J0fD959U0Mq2I+aT/fh4aiNMnqY3F8?=
 =?us-ascii?Q?L2UDuraYIIFE1vJEuzSfXo6uGNKN0P9CYamZqSDswYceMRRP0Nywh1Rx/pES?=
 =?us-ascii?Q?SpCdhDfg2lOF/l1GHUlUneYQBLeyf7N21rag5Z3UFOLevP0VleWpgIXmUwfr?=
 =?us-ascii?Q?cz2l3ec0qwFnfdbzEx8RQ9fp9hKcQVOAafuvsfhxaljmDZYYfjnUgWZGzSwH?=
 =?us-ascii?Q?Bsm3geMYLPhiZ121oeLCmqRaTdgLUFDKXCUGTAKnV/X++h+a02wJ9IDZLW14?=
 =?us-ascii?Q?KAneVXj8SaT9jjjWyTCZinNc4CjWKfBJxHDw8GRH4nbC9Bkh+ahrvj9mDa2O?=
 =?us-ascii?Q?PJb8Bg4WGVXgOwOjFvZBZ6AtrDLhSds81RyAVy1pC63IGMRVuf2zjUemJ0GR?=
 =?us-ascii?Q?0AOXJD8QBRHIV04VosyaFikST9eNoh6yA6KSeYf3V3kLCZqFhmqZKlCCgJRe?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f52465bc-5e33-4081-0c5b-08dab61062c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 22:37:52.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLCZTlEoN3stcggZ+RQtWe/nuHEiaRzLTdbWK5CDVwq0pl/LnqcvCpx5vDFp2D9riAxlPa97Rz5hXGrsjfAKRhG6iRKudD8ANnHTIxFy9LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Robert Richter wrote:
> > On 20.10.22 22:17:07, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > A downstream port must be connected to a component register block.
> > > > For restricted hosts the base address is determined from the RCRB. The
> > > > RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> > > > get the RCRB and add code to extract the component register block from
> > > > it.
> > > > 
> > > > RCRB's BAR[0..1] point to the component block containing CXL subsystem
> > > > component registers. MEMBAR extraction follows the PCI base spec here,
> > > > esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> > > > 
> > > > Note: Right now the component register block is used for HDM decoder
> > > > capability only which is optional for RCDs. If unsupported by the RCD,
> > > > the HDM init will fail. It is future work to bypass it in this case.
> > > > 
> > > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/cxl/acpi.c | 79 ++++++++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 69 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index fb9f72813067..a92d5d7b7a92 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -9,6 +9,8 @@
> > > >  #include "cxlpci.h"
> > > >  #include "cxl.h"
> > > >  
> > > > +#define CXL_RCRB_SIZE	SZ_8K
> > > > +
> > > >  static unsigned long cfmws_to_decoder_flags(int restrictions)
> > > >  {
> > > >  	unsigned long flags = CXL_DECODER_F_ENABLE;
> > > > @@ -229,27 +231,82 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> > > >  struct cxl_chbs_context {
> > > >  	struct device *dev;
> > > >  	unsigned long long uid;
> > > > -	resource_size_t chbcr;
> > > > +	struct acpi_cedt_chbs chbs;
> > > >  };
> > > >  
> > > > -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> > > > -			 const unsigned long end)
> > > > +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> > > > +			const unsigned long end)
> > > >  {
> > > >  	struct cxl_chbs_context *ctx = arg;
> > > >  	struct acpi_cedt_chbs *chbs;
> > > >  
> > > > -	if (ctx->chbcr)
> > > > +	if (ctx->chbs.base)
> > > >  		return 0;
> > > >  
> > > >  	chbs = (struct acpi_cedt_chbs *) header;
> > > >  
> > > >  	if (ctx->uid != chbs->uid)
> > > >  		return 0;
> > > > -	ctx->chbcr = chbs->base;
> > > > +	ctx->chbs = *chbs;
> > > >  
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
> > > > +{
> > > 
> > > The core logic of this looks good, but this wants to be shared with the
> > > upstream port component register discovery.
> > > 
> > > Full disclosure I am reconciling these patches with an attempt that Dave
> > > Jiang made at this topic. Since your series hit the list first I will
> > > let it take the lead, but then fill it in with comments and learnings
> > > from Dave's effort.
> > > 
> > > So in this case Dave moved this into the drivers/cxl/core/regs.c with a
> > > function signature like:
> > > 
> > > enum cxl_rcrb {
> > >        CXL_RCRB_DOWNSTREAM,
> > >        CXL_RCRB_UPSTREAM,
> > > };
> > > 
> > > resource_size_t cxl_rcrb_to_component(struct device *dev,
> > >                                       resource_size_t rcrb_base, int len,
> > >                                       enum cxl_rcrb which);
> > > 
> > > ...where @which alternates when called by cxl_acpi for the downstream
> > > case, or cxl_mem for the upstream case.
> > 
> > Ok, I see where to go here. Could you point me to Dave's postings you
> > are referring to? I checked linux-cxl and could not find anything
> > related to RCRB or that changes regs.c.
> 
> He was in the middle of tidying them when you posted your series, but I
> think it would not hurt to push them to a git tree so you can grab the
> bits and pieces you want.
> 
> Dave?

Looks like the list delivery is backed up, so I added Dave to the Cc:.

He pushed:

https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch

...which was his original attempt and:

https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch-robert

...which was an attempt to rebase on top of your bits.

The common RCRB mapping function is here:

https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?h=cxl-rch-robert&id=5be44cad37972517dae6a79001080ccfbdb67c49

I think the path forward is to build on that common RCRB code, fix
cxl_acpi to register the pci host bridge device instead of the APCI
device as the dport device, and then rely on a flag to skip over
devm_enumerate_cxl_ports() in favor of just calling cxl_mem_find_port()
directly in the RCIEP / RCH case. Then we can figure out what to do
about RCDs that choose not to implement the HDM decoder capability which
was forbidden in CXL 2.0, but now allowed in CXL 3.0.
