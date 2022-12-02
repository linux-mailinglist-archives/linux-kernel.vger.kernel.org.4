Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D063FDE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiLBCC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiLBCC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:02:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06905D4254;
        Thu,  1 Dec 2022 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669946546; x=1701482546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UTo6C3xqg+nmbEDksxpuY9ugn/EEFztAKe4AbKXVxP0=;
  b=cNjUc4bahB/JYRre1GKafXE7Q41wqW/LQ+XqhBZuQ7nzCL+JFgFRqIgf
   xnW+xY5RaVNzyb83jGpPH4m3E+aozhzevqXAaiSZNPljHrjWS1zT/QufR
   0/1CQ77xZa/zHzE0dz/na4wCZj8rfMIeOxCj9zi5M8iUhhapJk2bBYpDX
   +4exmG24KM+FGRlYth0+ndC5cS1RtilKvWK7dqtV7dua6XbkSYEbLpLnC
   6eTVYq7VfmiJnYzG8egjScuOx/ctJ0CAcsY/D6f9bGdoXG/m+4Hj4A0Bc
   lQLbhYb/Y9kGztLhEUmfnV+VnibLK3MXxmf6rXbgHa6FLv9fRp2dwW63z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315875265"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="315875265"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="751069468"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="751069468"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2022 18:01:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 18:01:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 18:01:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 18:01:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvhjJVaZgR1Anhgvd5a2fULGd9Rjt8e1FYPRb+NtqUtzWLyKDEYklhaHbTc9N1jrPnIacJZzD9HgPrfGsP13uqqYXE6alHqZMUiarzMlvFXP7F/FTQ06QPxGArb0ObEjYvbuZIN434PSa3+cXty1Zbl7IFCBmEND5SWkbVA/bXIfZX682wGnqFgSpb/o9YZoaSVQZ3ZAl9vqV3HHXi6ZT3gwlpbQpd5hsFUhQ+gJ6oG/9qEl1K/wV6sNc4+9NhHvM5OunSmxJYC0kELwwEd/1vtr/eX6nvrUceVCtUOv0TfhZTaWVQoPCKDy+0+4XlLGCyEB3+rhBlOg0bVyq1P06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSSviNLAb+zuogsZyzxX/FqhzxsdxxRxfxOppZUPMjE=;
 b=bHBzP3yEtmyXB25fOw/tIWHsce6qxiWxUtx/WJTuDexF+rul/urDj0fQPtPu2k1k8pOQVBg1a3TlH6CWY8Iby6jRZlw/Gc5o35nlIQE9gYONjlFnP8uV6sz0XC7eVHnRp/mPP42RcaaqJThiBy00eLqFyLtHJaHA8hREjJVV6Y6ZMHqHMtikOOehCPqlLnd153Hed0nfOgl9w26gKL448WSD0OHz0Zga8haE3yrjPSM1ywlELPLxgu3v/qFRF0lzkTRsnO62QlogOadwuJmQwbWVYrrbjNG8fzWSO2xZq4lnl/IlgTgDspZau/vMVTOKUQjy1Th6Yy6+L4jmknqwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6186.namprd11.prod.outlook.com
 (2603:10b6:930:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 02:01:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 02:01:02 +0000
Date:   Thu, 1 Dec 2022 18:00:59 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <63895c5b40770_3cbe029432@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-2-ira.weiny@intel.com>
 <63894579bf550_3cbe029458@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4lIE7Fyctj6GagE@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4lIE7Fyctj6GagE@iweiny-desk3>
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff5958d-baf0-45b8-083a-08dad4091001
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzrwdHDQB70E7JBhuHOzEfAyfl9MDN2QnRNY+ovynCd3oUNFOPDUOUERM7R3d71wHBtVSg3YovKQhxBrlmLgzyCAu4hwChynUe4Xi1s0azXGd7p+9IYPaxpsArjAoS/Z6+iNlCUyhaeSVxs2MS5TpuNV/b+wW10alvm0V6CTYGTPBYFKMGGEgKmX34g/Cf0qvLOqUv+q7lGOV18DDj487YeUL72OJHx3s8rjKUshnaG54hyJSrsn99kAAzKQUKGPzoUQhuoCIX6vQUHzvHM4pvT/vyvI6nRHvDKnAQ/L7ePbqt6A2NLGbnnjJ+RlcVsRY/RGM89PH0f3CpriINnRPP1NGjVKcAAcx8sHlkEFeV3z6erK98JSZ1C1Mz4JsOTXlEYjVV1C6+UEL7LKxDwr0bYrUMrgLG3aCannBCpCzxJ1tfHzH4UWOfWbyr1o1tgyFGj+QVzbCixUJ8vtqwG+TWExFufqndSfWt7qyE4KA4+k1Z5juSBtLNZ8Et5OaovynzPR7iPBM+DCzezxEPTFIpC/4728CzgGPBmgcwrmwAMyN5z2iCsT2klpypi9tGSa5EuUMCbMhQh2xQRZbpJkwd0HvZhqoaOyrzx5o719L/0qa/OBh2z2S3uI0C5ng1Eksc4uRT/xx2K7EAV8FpToDOt1XDmk2PVNlCvJhvWuSsLK1n+pKEsn3MpXIy6nlNKi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(66899015)(38100700002)(82960400001)(2906002)(5660300002)(41300700001)(4326008)(8936002)(83380400001)(86362001)(66556008)(66476007)(66946007)(6486002)(110136005)(54906003)(316002)(478600001)(6666004)(186003)(6506007)(8676002)(9686003)(6512007)(26005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7I4rmgSVuzsgFSSCatg0TC5nvSPODyszXM5qWZaswuuxzly7pEPA/fw6jSQ?=
 =?us-ascii?Q?BLS1Quak0sdC+ASAw+i+bX90no77cdo/fWMfq8DZ1HRxhW+H5FpHGmThAfn1?=
 =?us-ascii?Q?0YA8nu95gJ8CPtlnbs10IpHcqnNwPNqHqH5+ImCV3l/izlbEPUZUH9uKPg6a?=
 =?us-ascii?Q?qHD0Da7nurnp1U421JFr7upWgvHvy30t5uSJ/88ZIh0GMUs2dcT5dUcaiSEf?=
 =?us-ascii?Q?SEUEnJg1B392yMZwCKDGZ1VQDQSwVBnBsbp2a86FL9KQnsoD7Uu8p/HOMjeK?=
 =?us-ascii?Q?h8b3R1HNFmtPwslsdviTB6AoYE6hk1HEdt5vgOYLOv4gFFR3pB2lAfrMdjon?=
 =?us-ascii?Q?wpnTmr4WrZzsMUCUTDkpfN2D6XQY3NZs8R7tLZu1fU6e3M9flFyJNEVRqtaZ?=
 =?us-ascii?Q?HHlrK9g8u91cTJZGcjClKp0hSa9wMzK2c5vzc+8y9pz/Y0TuNWgqlZWY2QU8?=
 =?us-ascii?Q?T2cF9uTE8Nb4UDHu9eUdd6Cir8J9KqDJkyizOsFdDzvGSuVHwA2CJiJrq49z?=
 =?us-ascii?Q?i4MF2bNMHvizXcPQZD6kVDqZilNTtL+Yhbv+3YZsLjWSOSDf8eJaKRE2mjK6?=
 =?us-ascii?Q?irmlHYWxnKE4fGTc26QtcZfOFLeXiRe5+ugAfO05X3xFSqkDsqMzwWNqVmRf?=
 =?us-ascii?Q?+8OEBBHoTXKAFNMmWqoIPEeT0iVtASqWY8K7eMP3y4j9E0sNWlAXaEsqNwnr?=
 =?us-ascii?Q?Mql0iQkX/Dqgnk+ETnQiAcRAx5JaLOh7swzRk71ww5qpVFeDRc81hKySRMSK?=
 =?us-ascii?Q?EvbG2tPhvdiMrWJGjwrFFMtdOtZuD7WzckHeuHnjP4mdGQeFjj8vtjqRkfBc?=
 =?us-ascii?Q?qpnwHn4zK1ZJceWxU2WMsPOUYsIXj+3na0FQgfWVJVOhURoauJKu6lnl0RoN?=
 =?us-ascii?Q?tiTaMMlPXvZGvGyA6ey1DcwDH3Vb3i2hGTe5M4U4a9VQnYZlLXutqEoDoS+c?=
 =?us-ascii?Q?w66X4NgkHrKCBMVRX9AFkMzp/2B3BQhguTzYkTXz+hoPECDKZ2AHmelGry2/?=
 =?us-ascii?Q?kT5xgm57lhiqj8qFtwBpD19bUOBXQS7wW7J7OyOamYefaXPA8/e5I/IzsWUz?=
 =?us-ascii?Q?94PHSXILgmLpTQJAlQRYj93RCXfcBrgNzOlCUsmt4CBvGMMCRmeazQkGBrXQ?=
 =?us-ascii?Q?NI/vjjH7eG93FxsAZxKQ7tkmNvQA875hgHKDubPOyGcDlexbnBox4G5Z76oh?=
 =?us-ascii?Q?n/iuo2/CpeTsS47mt0Hieb45PhFfBISU5ambVBhCiXN9/G/FZtHebMhVwt0k?=
 =?us-ascii?Q?Q4G4vrbPqU4TQiqjCEjyNYJLlLU+wmiBic0KI0GQQtUfPdbnz4rDdDnrhMdn?=
 =?us-ascii?Q?PN/JFd1FUbxEk5+k1U3OJl8/f4THQlctsdt3bwaiYQqdvNMQHQ53vfksdqiV?=
 =?us-ascii?Q?xEjqJ1DhKJXQrSJNTW2v8mZdQn2O0d0UnF2xDyu96gkSYtKyEz8f9qxuVXkH?=
 =?us-ascii?Q?18Cg+SvEFzwWR7pS4mfgEE74C/JTYtm27j2D37lbiAiAUpWL2l+gNZalTMfh?=
 =?us-ascii?Q?R/552hhoQ+mb3p1byJnyQNcTLngMlhHt6SgGiBLIQIYp12jLs5nPS910MAAf?=
 =?us-ascii?Q?jQDdFKakSn/ffD0i8F8Q0EEzKcGdNzycRTeol8wbo1vtBrfB/4916BlGQCnf?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5958d-baf0-45b8-083a-08dad4091001
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 02:01:02.0268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMX/wuQmPs9OaKCOEkYCR9L+QPWwDDMn2LmtEnueouFpY3VE7jkqnI9IQG18zkbqyj2T2OGnmZkKBl1cjavzCXJADDyBpTH4wGO8wtGwF1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> On Thu, Dec 01, 2022 at 04:23:21PM -0800, Dan Williams wrote:
> > ira.weiny@ wrote:
> > > From: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > Currently the only CXL features targeted for irq support require their
> > > message numbers to be within the first 16 entries.  The device may
> > > however support less than 16 entries depending on the support it
> > > provides.
> > > 
> > > Attempt to allocate these 16 irq vectors.  If the device supports less
> > > then the PCI infrastructure will allocate that number.
> > 
> > What happens if the device supports 16, but irq-core allocates less? I
> > believe the answer is with the first user, but this patch does not
> > include a user.
> > 
> > > Store the number of vectors actually allocated in the device state for
> > > later use by individual functions.
> > 
> > The patch does not do that.
> 
> Sorry missed updating this message.
> 
> > 
> > I know this patch has gone through a lot of discussion, but this
> > mismatch shows it should really be squashed with the first user because
> > it does not stand on its own anymore.
> 
> It is separate because it was Davidlohr's to begin with.
> 
> I'll squash it back.
> 
> > 
> > > Upon successful allocation, users can plug in their respective isr at
> > > any point thereafter, for example, if the irq setup is not done in the
> > > PCI driver, such as the case of the CXL-PMU.
> > > 
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > ---
> > > Changes from V1:
> > > 	Jonathan
> > > 		pci_alloc_irq_vectors() cleans up the vectors automatically
> > > 		use msi_enabled rather than nr_irq_vecs
> > > 
> > > Changes from Ira
> > > 	Remove reviews
> > > 	Allocate up to a static 16 vectors.
> > > 	Change cover letter
> > > ---
> > >  drivers/cxl/cxlmem.h |  3 +++
> > >  drivers/cxl/cxlpci.h |  6 ++++++
> > >  drivers/cxl/pci.c    | 23 +++++++++++++++++++++++
> > >  3 files changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 88e3a8e54b6a..cd35f43fedd4 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > >   * @info: Cached DVSEC information about the device.
> > >   * @serial: PCIe Device Serial Number
> > >   * @doe_mbs: PCI DOE mailbox array
> > > + * @msi_enabled: MSI-X/MSI has been enabled
> > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > >   *
> > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > >  
> > >  	struct xarray doe_mbs;
> > >  
> > > +	bool msi_enabled;
> > > +
> > 
> > This goes unused in this patch and it also duplicates what the core
> > offers with pdev->{msi,msix}_enabled.
> 
> I tried to argue that with Jonathan and lost.  What I had in V1 was to store
> the number actually allocated.  Then if a function reports something higher
> later it can't be used.

A successful pci_alloc_irq_vectors() call assigns a vector number to all
interrupt sources on the device regardless of how many interrupt sources
there are. If the device has 32 interrupt sources and 16 irqs are returned
from pci_alloc_irq_vectors() then each interrupt source will be sharing
a vector with one or more other vectors. All PCI IRQ vectors are shared.

So I do not see the point of this msi_enabled flag cxl_dev_state. If
pci_alloc_irq_vectors() returns at least 1 then you are good to go.
