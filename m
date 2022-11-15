Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CEF62A118
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKOSJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKOSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:09:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F261A14090;
        Tue, 15 Nov 2022 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668535742; x=1700071742;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FXCitNBI+oKvwqFi8/CkOfNCcvtf/yA9QV1Blg1jEGM=;
  b=j1pO//cJh7c53SRbVBb43qlai2h0AQZ3IzwZnPBvvVTni5QM+pDsKef0
   D43AM7iNut/xb+N5S/AwgAQfU0s/Q/fnP+PcVQR73D8V+xtPEQ1UOcC0o
   5Hk+Y8iQYX4lA91Ylx9vu+6SD5d6YHnbrB3xRZUjwG0MqSc5yqwHOaRtG
   WI/Hr9HQdTIfWZHP6TsirUSK/u3OuSXL5/w2pHagMf1SmAR5RElyeWfXc
   1RIt87A7efenTZGVhh6b/ORzgAN7DcMmF15Jds1ZAuJcP8XtZoma9kUMS
   BiKGijfnHSRI96xe+Fs+Ovum5/SCp+4QQkR5Z8G61d/OkAmFSP8A/M+wI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339127925"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339127925"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 10:09:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633325926"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="633325926"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2022 10:09:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 10:09:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 10:09:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 10:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs0znQ5x3rBQPW06eCi62a99Vqc7n2PRo2X43sVGWPOd5sCmOqj3OVvkEwD3Ti4V32TLoSD9eTPce0iBu+og+xDcCr2sl2744ogIOP2bh4fVjPHzXG7evplb0sEY+QZM79eaVEq5oRymiQP3335ENPRAaVkzMlbpLkokER0XcsbvNjuCWyYezFAbNL/RpUq8z/neYNnFbR+8GTziqK8uWwlqQHr/BZ10c7/ehXSeehBb4RGVS5CERhxFYTWqAv/AefgtQdTo6KXKqKCJfBqNqFKeOGcIoA3GjClNL2WfxV5RY2dA2x2/dujGwn0nMez0Of25JQBOeo7yexU89dqYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHoO4A1VQzx329JRb1qaF302JCuGCmplLVTqpm7EolM=;
 b=QgoFEyLY2BstN07vbJktN3VugCmIBoFkmUf8robNPYUYUYp83IB/f5bDU1rra4VEA1c89o2MY8obFLHLJ13vUi8PuftO5Kry5s1kTZNO531wZxliViJzJIlcdV2OsHE7T4QR5QZmF91sNvMlYxzMZTErthnJeMaBIV7MG8yGZL98JDfbcoHlFfDdIbTbU5HKbXvrR3sRegNx/EGHEpDoCwAITLdKlALwFSSeP0org+SzHZNVInGjbZJH5Oet6jLzZZGpYYvw04XMDsVdO3BR0apj3zt+G0Xq56DoFfv0NlSdY9SC6yQ0HTCYU696sDtd0nSAlV+vj1o+qyheWIPUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB6266.namprd11.prod.outlook.com
 (2603:10b6:208:3e6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:08:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 18:08:53 +0000
Date:   Tue, 15 Nov 2022 10:08:51 -0800
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
Message-ID: <6373d5b332214_12cdff2948@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
 <6372d85ed793f_12cdff294f@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ORTv/1YbTFJQzq@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3ORTv/1YbTFJQzq@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: bc27b5f2-2484-4a32-b84a-08dac73474aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WZTSPquuZvLAEu6nyzfboie9HB4pSryIBqAKE9EZqldl8MMyUTgoUt0UGBDCgJPSqAd/VHqj4tRnGeX9MOiym6Q3cMsKIibhkf9h5hhJE0ppM24CkcW9Z4ezHSiNPpy5p9HZ8wJM2YeXgge0am/l3FiTGA3O7Gy1Vnz6cNr89K6jvt3mkQOw3df3i78N5biiGQ8Gf8ha1N3Qdr6d/KR+TNvo3MgBu0jp+fjq051/LehD36YHOjlNW157kBc9l8nBqron/Vapz62OlUiWcWo4Z2aH6SAbles4ljcyGepB046QDaQgY9FsiOw3IQQRZ3LRhj786ULSiCP19D4IGe8Vza9vkgSKFVTaEPQ+rGIB2+5vFtvQKynAmCCmpp6F4dVbHyGvIAVLBUKzeX0sVnlsz1egdOO7RcgroV8i5DE2rAthNWkt6Z6QLsyq9MXKGEShvesBD4//QiX1xpO1X4aWrd6zfUED2DcV2Vm/L4eVgCOIX4/l76EEEJE+GCgUOi8Q/7sjLArCKTqfYl+yKdgtnAV1FQZZ9H9sPvEwiEDWXak5BUEOdOwQXa0pq5EMRdX16MjFbQCXcI0C6z6i+oeege2QiTRVLxyPiuSOwvg++qasag0WWuYsqrWijHhAxQVHB185WrfwbdSug0FBMy5xsNtlzt9JtpFslWU63BKoqebBcSSEWOJIXAQNLMVZnoItxrVoF6Jwuaj3lFlrvnN+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(6486002)(478600001)(83380400001)(5660300002)(82960400001)(41300700001)(26005)(8936002)(8676002)(66556008)(6512007)(4326008)(66476007)(38100700002)(54906003)(316002)(53546011)(9686003)(2906002)(66946007)(107886003)(110136005)(86362001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jfkvvgkopz2kXmH5W9VSkLvbrnk1Bw9P6ceaZP3STPY1DJ5B2GzOaOS+LbSJ?=
 =?us-ascii?Q?IKrHVlEyfEM7fMgi1io0Y4P/vW7tMukHy/3t4wJgG5xwVdiigN0w0mh44VS+?=
 =?us-ascii?Q?ixQ7FQvZYomkvQeulgIrIkseG9pdH0N6uLu+Xu1pW/qxyvJKcDz3gK2uDrFn?=
 =?us-ascii?Q?SOAmkD4/sIZP+oxEltjZGiG8TwgoXE6mpPCxuP0uGuhKCBiOBlr8nsKQYq24?=
 =?us-ascii?Q?4zHzaNT9uLL9isfpKD+5M49Tbn280hdf7z3nvhXIv0gwfutmzONKsmK7UZmA?=
 =?us-ascii?Q?/6yEA43e5W8EzgF4VctFotdoV86+aCxK9Qhv69Fgrmu/toV6K73uWNdXCdKj?=
 =?us-ascii?Q?zlzj+4e5R8gWdCK3t2hLmIUTekR4sq+ZN3hkU2aFgutXD0ZnnUMEhlSvST4h?=
 =?us-ascii?Q?NHlsDfbp5BSUDHNz6OagFUXQw8ZMCKHpiuuOKhbFU1cZjVlp86Vr3PI0mAdm?=
 =?us-ascii?Q?O+3jOZ0VA/pSXpNQUo+YKC/iknXdXJimNZJDkd5lpqco8MsKwG1bz7PPSbEf?=
 =?us-ascii?Q?JayWtSrkLNvllZVSGAcIZrmJdjmnNHJLc6nw+RrCspHVvUkizsHDPYaFloE3?=
 =?us-ascii?Q?82escl30rSYbJb8i5CnjskTK8IrHx0Vq9pUp6OWmXJQy5lnjVexJfcm8tdTs?=
 =?us-ascii?Q?L6TOddwklJ8T/Denibxlw6kVw49g0BFLFA5s0MkP5Q3H+y9qMRkJIPGEP1Iw?=
 =?us-ascii?Q?HXVqZ84aIekK4++Ww11lntjDFmIDUTMsZ9L0T/8dwV/JAj5MlYYCkLwAUKXJ?=
 =?us-ascii?Q?YOVrxIML2woksoJQQF/mY0TOLJ+H+v2bUxumItePaYygzs/GO37sCAIMD9jm?=
 =?us-ascii?Q?Ohol62hN8hsP4Kf5FyR3R0+sh/EniALU2imIFipytI8TkM4OV34f/xaqsyND?=
 =?us-ascii?Q?0PAVf4vUJjDCev/5iiw/SltGI1Q8LyS+Y1hWVv4zRSlGFKwKozgepHMikacv?=
 =?us-ascii?Q?+tzPVtfK7MNYRxByn5mffK22EnUEFQzL3Q72Eiz0EU+gY05WjhRoBFt0d7f0?=
 =?us-ascii?Q?O1saCHEW4s46z6ELlShBh/RdEtZ1eqjSMP8IkwZP9Oh+9NPv361f5ZMWoGqG?=
 =?us-ascii?Q?LQOXTHyY3PKSfJiI7XNjizzED9ouw0IBL0m91ApNqCuVzR1RqmrdnscOTGtE?=
 =?us-ascii?Q?TB8XSBoeSkjJ/ehNsAv2IWqAPxokO1ZbbIz21Pp526dODJuPmOhjC9FBqphc?=
 =?us-ascii?Q?fu3UTd8+Fbd9zO/7JObShW8TuABCbleWrS+/ZacYiYq2lVkDPnmJcMwLGjTp?=
 =?us-ascii?Q?mqjTgqmeZS87nzUZcDwXAps3QDoivEso0Op+vDniZYiDQZKiqFDWL0wmrZwJ?=
 =?us-ascii?Q?kbWeGNSqxLcUvU9RCkH6DtfJlYkIM4XGRTD8BA1U+gRbQ9LLzZLdxcLMd8PT?=
 =?us-ascii?Q?rYH7x31F9/bIq+DksA++DWyESv+0fkCH3b+8E/K1wN697eaciakFYG7K9H83?=
 =?us-ascii?Q?q4LpVIzCi6bzroGh6xphZ6iojcHY36WFj3YwBecww/Sbhv0pS+b6mHzbc684?=
 =?us-ascii?Q?HDUTVmHtymeo55zaEJ77pzNh/VkUB85Fh/uUpOXzNAz4ilW7Se3hNXXiBL4X?=
 =?us-ascii?Q?gh7IPfueiuXFl5RrfcFIbjzqlfjtxTZdkawYOBZlltvTtanwkZ44tL34xy2m?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc27b5f2-2484-4a32-b84a-08dac73474aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:08:53.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmRiWyvN3j1SfY3EJ8ETJUKhv6BESAbOp9pchs4NJb7fSVgk1DOzP2wJRxg6wVcmfTn7Dt8h4bjL3HeeQyTc2A+ohRfC5RZvjBfg38LDUKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 14.11.22 16:07:58, Dan Williams wrote:
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
> > 
> > I changed this to:
> > 
> > 	if (cxlmd->cxlds->rcd) {
> 
> I a mail to Bjorn I suggested to have cxl_dev_cap and a cxl_port_cap
> in the pci_dev struct that could be looked up too including RCD mode.
> Checking the pci_dev looks more reasonable to me here, though we could
> have a flag of it in cxlds too.

Would that not need the PCI core to understand how to walk the RCRB
generically? As far as I understand the RCRB association is ACPI.CEDT
specific.
