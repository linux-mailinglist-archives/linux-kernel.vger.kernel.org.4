Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB21262A120
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiKOSKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKOSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:10:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544B55AA;
        Tue, 15 Nov 2022 10:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668535825; x=1700071825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1cdvZC4QfmEMKDzpgNYdFfwEH3Yi5/m3/Qod8JEbNYU=;
  b=cLtmkAcEoEU02N4bDaxpTRKe2dY+c6gJ09tv26I2vbjtsENkqEjavs9l
   l3QLK4r93stiKwJ6cv4ycvfj7wOXmlJffK/zcUCIZphtMuJNB0dK32V24
   TQqnyxxpfU7ni44IKGpptBgM8k52WKuFs54EaNmCCWrgKG1YDZ8BxORBY
   8dca2dlBya/7BVlBssVeGxXBYoEpd/2iea7gOlsaxW9uozEJCnwWv4j4x
   EkQc2kzK24u/s3E+0wD9gVsqblupptUL7Ob3NQemenrw6J/GFNqqpMy8A
   0kv4jIARbZZoe59USud8Fb341g/Z1+JyB9nPW7hnFnzOmN1DU8RQ1Wn7W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="313477345"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="313477345"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 10:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="884058059"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="884058059"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 15 Nov 2022 10:10:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:10:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 10:10:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 10:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHJDHm593iuBvrUzGWi2N/raU0fN85SFk1nxyRT5qMLXtyZnRUeUegVA+WOkCdYlZmb5ifeqWWm6O9R2TxllW3hxK01gVk9UMS6Xvq6CreADhjs896E75HE4/TcwjQAlEC25fFa9IdmwWSa84kJfS9QeCBbGJob5OYHq6nwHAWXs4OgGAsJTtNf8wx0I4KVHhN7olAeQW/pFM7hw8fj7pyB7kqVJAxmx/XX2axC8QL+is6QhVelXaw+hLHQ/S7I+eqpcTOOzWJ7gDus16+44zAlw7CcRwnn5OCIHUcOFmBgy3htHyRReR4lkdVT/o113xkiPWsNlxfMsycEoiTNXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ9KfyZdTKGwpwzj43clzs9p48j4wf7AZXXKvqN6IJ8=;
 b=AbFSjV8OlZH44MPnvxIiADQZcpqN9bAcdBgfWNuO3arUIJU3biJxqzDHs7OFiOKQTEZtDMN2kKoQVNQ76zpmvcFIAt6Q/I1IhdaoM3A9fG1dXvZ8mr5DsMTZ4M3BYizqcvVFwT8ABTaPnEuf2LvCycW/owr1vsDmcOHFr7YHr29Q87Z6erEFTnA0uXgBxt84NIg2i+tit8jvD1qmRiVoqj258JvOyfzdcecDkk6eCFbQG9V0eseDVLBXtSNtLbW2lDzND0vJILjp6ulP4PyRTvxb08907vqf5jjsK2XEly1+YDL19SUYsMxQIcF+iPcHpp4isWC6hDP1RFriAKuTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6266.namprd11.prod.outlook.com
 (2603:10b6:208:3e6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:10:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 18:10:00 +0000
Date:   Tue, 15 Nov 2022 10:09:57 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
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
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 4/9] cxl/mem: Skip intermediate port enumeration of
 restricted endpoints (RCDs)
Message-ID: <6373d5f5bed39_12cdff29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
 <6372dc26c8f2f_12cdff294e4@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3OT4oz6aR6hyvSt@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3OT4oz6aR6hyvSt@rric.localdomain>
X-ClientProxiedBy: BYAPR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed47746-db83-4f03-1b29-08dac7349c48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xs4A6ADbVkqIUGX/OWDv7rEgxuX269zoo8cpWw+mJZOTywFhMqgkauy8gD9jlfy76SoxwRnHwLtMjhRLu6Wd0DdAQVjjUlyZUZi+BXRBU/Y3chxSFy0gB+sI9Gz+GaVQ3xE1nvlUl3JXepCLW8TqPmGIGg68aDprGv68vxa4TL+Eoq9PC1vUSxoy47P18n1Lxw7f1/iOd4Rom9g2Cb48f7IDwZ4CtsVqSX7q2POz0jk0x/nHffiq3ROgdDUX2PGykCKNFRL06Rlq0Ff99lDMcAHguLoDyibHv0AperL4fQHXLjIrb4hTAGhZTlXknOVQWdn68sxGCsalV0JlCDJLRfkWhpYNYzcyOxXL9mtIYTHucbcw6LvGFHf4b54YJIFxD4Mdi7VQAZ28yfAPa3N1gEmvmmEKane5QlrrPqSayqzaGw1X4M03WJieklS7+W7mAiWsJoh0/31WHIFQK+wXIOMRI8Kta1V9rHt8RBKt9ML4P9UPVpQyTmTDzWnfdZlcb2WjTW4TcML+ZLYVSe5vr3xsyZPbbetzuaRAusNEkowQbKoSFlkuU/A76/TBZwdHgvqAgWspWNmqWhHWhWRdWtegSn3FyvhJoZDGOJXclHzzGyMNy81uVI7SzD5lbH9beay764Ft57abDhTp5S+TaB9MmfbJS5z84dt+00tX62+sq0w6iG10420fTfnQY0UvsA8iacE9FkeXeonZ7d5TOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(6486002)(478600001)(83380400001)(5660300002)(82960400001)(41300700001)(26005)(8936002)(8676002)(66556008)(6512007)(4326008)(66476007)(38100700002)(54906003)(316002)(53546011)(9686003)(2906002)(66946007)(107886003)(6666004)(110136005)(86362001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhM/36LF8V3W/1wTPNZellyvHgQUHNKODjmNPTPxlv+NJobXWEUYMxl6z+VZ?=
 =?us-ascii?Q?ii5kQiCtCefwruoCbHt5A43ixIYJQPa2AN5dhvT40iUV3lF/xAUDMrBf/rc9?=
 =?us-ascii?Q?hm0XwLiciZAJWIiaEhz+sJ+0nboPWlydPNpKxIGYc0abfoQgz7EhFLPzkQYU?=
 =?us-ascii?Q?paJsHYFQjchkQoybaEGtOXuCjlBdgAZyAg9wRlx2+XgKbo0XbnGoMqarG3QF?=
 =?us-ascii?Q?eFvkByTl0HZ+NXWwihf7g81eeAo58VhARZ07UwDG8WDEG8J1p99NrMONoYQT?=
 =?us-ascii?Q?ngvXlKOy3lptPR3MbdShqNs2P2S6qQp3CeDb5Ec2uZbOmxS0JJAaoFvFuDrT?=
 =?us-ascii?Q?mDvHV2k8gLYz/SV5+HiqS1zRBqyKQVB/S6SJi44/dC0YgEYfmIL9PgDdDf17?=
 =?us-ascii?Q?2ZUIOIRxQGY2TIoIN7lr6e9AyI4Y9UBjvGKqf6OwcU0PEPa2ZakGiHdSsDX0?=
 =?us-ascii?Q?c1DdhZ4hisdwxsn11hFeDUmGMCpXROIekIlwZyaxHDmOh8L0KdiWi8qCW2FO?=
 =?us-ascii?Q?lWseThsuX6YCTawBsMSljbrOWWcEwuuFu71Rrx3D+DA5mhBRz4AtVKNNI3GE?=
 =?us-ascii?Q?qND2NeH51HCOp24do4cyK7gatFFfKS4iAtbyFdc+w+nmoN5NNX6Nbtledfao?=
 =?us-ascii?Q?eFemzpbLt/K2HSdjvSiy8x2p8XxUoLhsoOyrTrnnFLI9KvME0mCmW8aFfTQZ?=
 =?us-ascii?Q?+mmOhWzo0xrp6C+fe6DvTOOKuvUoqw3Kb0S2IVqEZolW7C8EKs02rC+Ra+CU?=
 =?us-ascii?Q?MwS+TNUC5Kgv7M91a2LJIhqrJNIFusgty8m3QtoYWwIZYFJC7zicMVDsyewC?=
 =?us-ascii?Q?LI84y+23Ii8V3LB/7ctLXHJZYmkMsPh2tLIetO64KoP9Ud2YyciIAWNIDPWu?=
 =?us-ascii?Q?gaXko/8Lkx1PgsariVCpSvso3nDQGsfvvZg7n7n8kTyPIcLZrs+ynkYX5SY6?=
 =?us-ascii?Q?qqilDbKKnplVyW+/GD7o+WFYg+ZEGBcdHz6o9mC/a44zSUrrlGE/5lKXeUZK?=
 =?us-ascii?Q?XJGvan9czNnTjqEr3/Vwgpp57hBNTxZfVMgzcHkN49FzXlCRoB4UaESNmXzS?=
 =?us-ascii?Q?1CmRnyVUngejmbxmRo2VXldkHGGI6x4kDKYRmbrB5C5WublHbFsY5Efa426e?=
 =?us-ascii?Q?BPADvB9wKBUNxPE18w2ANov/85ZGuge4zJuCwlS35pLIw42uw+whL8VemCrz?=
 =?us-ascii?Q?IZbFfWvyjiEXBUAUj4Gz7t+iDvFqPop/aGVOrNApJPpH3j8fXl0FnNRNGmmk?=
 =?us-ascii?Q?cJ0t1Nu3DvLFnnBvzNqdGSLm605dV476x2DSLSjTeAvtEW0fBIhgl7QzqpYQ?=
 =?us-ascii?Q?i7MVCcW41rLOWh4ZPIAeQ83T9KSQnEZeosgoue/TfzA/No50m6ePcy0BD713?=
 =?us-ascii?Q?12iz/1XxjLf0gJSQUeUtqYTrvEO2sub7Hf/KqGjDX6IZDeOud5CDMBUFNYSb?=
 =?us-ascii?Q?QPYcfIg9PmW5GqLWaZBCCVQwCVnbN0dCNEZ2Z4GMZ1rOG2aEf0W70WrYT1hs?=
 =?us-ascii?Q?0eBZhGZoFbNN/Tzc+LppfJfmFZS0hU8V5N36jk/aPlKPpzCzBAJC0Iu8+KUp?=
 =?us-ascii?Q?nDLGyuGxThm49DlQx5VB5j601DaMvjRZnznhq7Xv2XKFJ/Undrv8VyQ8wDjd?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed47746-db83-4f03-1b29-08dac7349c48
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:10:00.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfPrMzHRb7Sd6o7PBctXhE80ey8Z4ydmYhP6KBBoV2q5+UpTdzDVGDkaVfgtOLBWXSBoRsLBBwTcLClFCNEZyTr5PGRtZr9raDm7xHzcSqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
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

Robert Richter wrote:
> On 14.11.22 16:24:06, Dan Williams wrote:
> > Robert Richter wrote:
> > > When an endpoint is found, all ports in beetween the endpoint and the
> > > CXL host bridge need to be created. In the RCH case there are no ports
> > > in between a host bridge and the endpoint. Skip the enumeration of
> > > intermediate ports.
> > > 
> > > The port enumeration does not only create all ports, it also
> > > initializes the endpoint chain by adding the endpoint to every
> > > downstream port up to the root bridge. This must be done also in RCD
> > > mode, but is much more simple as the endpoint only needs to be added
> > > to the host bridge's dport.
> > > 
> > > Note: For endpoint removal the cxl_detach_ep() is not needed as it is
> > > released in cxl_port_release().
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/core/port.c | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index d10c3580719b..e21a9c3fe4da 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -1366,8 +1366,24 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > >  {
> > >  	struct device *dev = &cxlmd->dev;
> > >  	struct device *iter;
> > > +	struct cxl_dport *dport;
> > > +	struct cxl_port *port;
> > >  	int rc;
> > >  
> > > +	/*
> > > +	 * Skip intermediate port enumeration in the RCH case, there
> > > +	 * are no ports in between a host bridge and an endpoint. Only
> > > +	 * initialize the EP chain.
> > > +	 */
> > > +	if (is_cxl_restricted(cxlmd)) {
> > > +		port = cxl_mem_find_port(cxlmd, &dport);
> > > +		if (!port)
> > > +			return -ENXIO;
> > > +		rc = cxl_add_ep(dport, &cxlmd->dev);
> > 
> > On second look, this seems problematic. While yes it will be deleted
> > when the root CXL port dies, it will not be deleted if the cxl_pci
> > driver is reloaded. I will code up a unit test to double check.
> > 
> > I note that cxl_add_ep() for the VH case is skipped for the root CXL
> > port, so I do not suspect it is needed here either. Did you add it for a
> > specific reason?
> 
> Yes, all endpoint iterators need to be reworked. Also true, the first
> endpoint is skipped in the chain. So only intermediate EP structs are
> touched by the loops actually.
> 
> In particular, cxl_ep_load() returned NULL for the first lookup if the
> ep is missing. We could stop the iteration then. I tried to avoid a
> rework here, but maybe it is not too extensive as I expected first.

Hmm, ok, let me get the unit test topology working for this to make sure
my assumptions are correct about when an @ep reference is used / needed.
