Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41855641189
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLBXfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiLBXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:35:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3BDBF7D;
        Fri,  2 Dec 2022 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670024109; x=1701560109;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xSXWFKgZ7tJdXiQIgcErpjsnhYIVgtDEiNSlqCtypfM=;
  b=I5iaKP35VFZ5V7dIzHyEIB1lmYpSSPRPybNn9Pe7Vw6wWvORwLhpBbep
   H70brZAima2EO+uzy9FK8qOkk7MQaBzXrXpTCfJGI4E3gR4TokpLuULvh
   +oqgM7W6gDtSJ/b8qAkWwYOsHVPJLrB7MZoeJtY3i5h5+L8DSXjqStwjh
   dbtpADOKDXIrHgGT+qFcA0jt3QcSUe8BTUf/dCwEUYmk4s6UxRe/UG8i6
   tLJzc3aCUZghH5YGAcZJkK77uBMp69HYd5pdJE8U0fDtSGazY6lVE0olO
   kYVHx4LhkGmbLwFzG6o1RbdDnWefvhoeKSV9Lwf92ySCwsHCgdSZR8OaW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316092798"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316092798"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="890330195"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="890330195"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 15:35:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 15:35:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 15:35:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 15:34:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOGNJkEnSqPoOVo1LIg+pBU7/BpTb8bgHbYciVBdM/srz6eu7P2NKlbbzgV6mgwfNgoi5hg7KupQYp7ho0mG+Sd/WHl9cDfpLIQ911UdyK1fBm1CmqJgNcsfpD/FHw42VcT40m8q3BOZ2cO3aTIAAtUZc21+ON334hWMF2xFv9d8VXzV3lTE2joV+Yaku8Zg37nRd0JActd0Ji6P2ToUc46ALZaT+0iuoTJXtfar6GRbnAH48iAvCH3t69iCslTaBSojX55L8eNTk/NEXMCcBzc16Jqy/O1dzjy4FON8Ntc4l1issecNfDlCWPOvg/qARlo8hZagn790CUUyKNQwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gREKjW5FDBRDEH1ORSeoFJU2Wd19weI4kJ3DvB0nw3E=;
 b=QRwmjZEOKKWuDLYJe6v+SyeZZpSCPf04W3ECXGBDlfZgAWck2uUTWnPEXPDk03hIVehWpE2NMkmtCpHaQvJsZuX1ysZdLe7J52aNVpyPB+R7+zEGFm7NB3WMOohJDNejyFjzqzlxtR232uSjwuedV85z3PPioS8sMVsa4YagvOXIyKNZ+Vhzh8lkRR4Ek5aMdSrTYsi/VFiExJkCtHt9ag41nKQ3MyHg3zvC8N44cCh2cLiZuVVN+tjZGcxyUd95dzSeSv+n3Rnqm5AEucDyFLVpXeUikUeQBQ4/Mz4tijRjxnRLvFpHkv8FGqj5Fr/7SN6bDvIUqZWyyfr71OIg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB5381.namprd11.prod.outlook.com
 (2603:10b6:208:308::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 23:34:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 23:34:23 +0000
Date:   Fri, 2 Dec 2022 15:34:20 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Message-ID: <638a8b7c97ceb_18fe029410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-5-ira.weiny@intel.com>
 <6389676c60d39_3cbe029487@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4oo+rxYAyBoHexo@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4oo+rxYAyBoHexo@iweiny-desk3>
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL1PR11MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 2519ab18-6194-4196-8fb4-08dad4bdbe22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4n6lRiJ8U8DTCFhWQy50z6fdbVM1g2aR1UXjgxLLhoXaEMp2sA6/uj2Ksp7lMyIbhQXGXYpJwJtIY82HRynmQ/ptsZnB2Jolkf2T2M5O370GE3SHIEe1bMoy00Ks8AalQbE5Lnx2I4/OnLzikvqcyoLfW7xOTeM7V1SRpuE1+TJvBnyjj+YtGp92W+CeXAiHLWfSPK8zGDnsMjgVehQ2ejYlmF5FpRnIk+DrXNLk1DMiPk7nRa3yajgtNIN7nwK9uCLvo2Qo+kwZ5MMegetgcRcaV1PhWRHg/FvpJWlbVW+owgbMMwOmrxQ8zEcIdAZf3WoHH9z1qzd2uUXIaQEEPDhPUdBsTczVGYqVfq1vuIUMtepEC9TryBx/KhZSm+t1Sce0TVmLcOOxPu9brxTE+nAy8SMb1xNL6/orXkO6VdzI/wQ0NrKnrXFkuThEyulqZteLPRpz6liOpuJ1TU+zq07kPGRaOsrnZU7W1YDtVSFHm+SJXuhsbbHiwq3KFCIvgQDBPXeqwEHxGMWFVOa3hm9yfVLErtol3KGj7mC2E6iSyxkESNrR0W4F8PyYhi0GTq45giPy02BuZD0ngC2L7g3ychlMPd5EPveRxreUp/XibFT6i0rV0Ljoj+jsryNKuq40rH8kxjts+QSwqtwFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(83380400001)(86362001)(478600001)(6486002)(82960400001)(2906002)(38100700002)(4326008)(6506007)(9686003)(26005)(186003)(6512007)(54906003)(66556008)(66946007)(66476007)(110136005)(8676002)(5660300002)(41300700001)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HQmbhoAnB4PLUcUHIDLsCoB5Y0KOQkgfkFCSbXry7BmyDnrVYU+xY0rdkLIa?=
 =?us-ascii?Q?wjRwoX7fD8bgej+tNkFbJVq5dxHCtoNXEimsFAk9mb6HtilSxwLqOuDMC8X2?=
 =?us-ascii?Q?VoiLvfOUpIpSiFioyWNJRQlr5xa1QRZXIYPP0EQW586AZ68Vtcg23EdrHYd3?=
 =?us-ascii?Q?z4jFZLcMcrJobnvPToq2S4+dkMrP3qSNtNrAFmJ3dRiSWvGsq4anGwtKFg58?=
 =?us-ascii?Q?UZJSx9vFq1c2CNdgcttbUNH+qpO0+D5OslskrZI7DDHXMxyicWT4sr3gBiZl?=
 =?us-ascii?Q?qBGSSrEE2IuaRqYnMcCz47ciaMC85/YMAGAAMSnZLA3Zx4gL4/q9SeftPMRm?=
 =?us-ascii?Q?V21GWMQ7KzEA3j2xAv+EldewAkVut3Q6DzmSHICmN+X53AA60bdAVxQAGVaN?=
 =?us-ascii?Q?ywZ3+NmDLjNHTI4gsbUj/QMuruC8UKkJEPlCeFdgbU+8kFS2ocF8aV2HiZsP?=
 =?us-ascii?Q?5HAhTO6ui1qh35fINHdNBI4/kqpnEInjeZW+eFmHmVvs1YFEGxgInfRFHQqU?=
 =?us-ascii?Q?6Q115GWABH79nTacoG+i87IhnfuRF2VDDfI1zAdvqif0Vczbio76SYPXBATA?=
 =?us-ascii?Q?KSNBw/+pIuRmmtaLxyrEN/cwE29u31u4mv0XcGOhuMMfaHvH1jMigYZXe/Up?=
 =?us-ascii?Q?ZF8E8NLdPRlOpAIIEoab/hJqKz2q8FjWkq84FlhgXctgL3JLiEuw97+28XxC?=
 =?us-ascii?Q?TlvRabRRKqoWcUN7LxJBSkEG+mZTlLoSMkBl6VUSh70cPBT+wZiQ+FhFySTo?=
 =?us-ascii?Q?37Wv8bIVZmNmdjkKtBXpiPOoQGeJCRPy8UDl3bh38xpDUoh37sLKBZlasinQ?=
 =?us-ascii?Q?Jd073D3P+clIE1f1RUveOPAJIRgWJ/UGohkujklsLLOErrlEGZbK6fjb0Ins?=
 =?us-ascii?Q?cFWaZOILWmH0/jhAeyGUz+ym7oVrwC1aM1frowgQoCGJD5JrTQZFTkppU3DO?=
 =?us-ascii?Q?0vfIeT+HA8EZumcHR89suiCEV4uX6PB/mo8HzLBZc+nz7l0KzNOrmhBt35Do?=
 =?us-ascii?Q?t3NtLtEFakAJEorivuzIh4amRjIzB2x20/okGM7HqwPvdTV1fNpEegbgRyMP?=
 =?us-ascii?Q?twWjXN9qxGqU7Z/arzevMSPtRFqvot5EBRhnxImcIvw5EEf8qv/mShsbSE9b?=
 =?us-ascii?Q?5wu8meEnWP5ad4XEYto0A9eTqhg2TuH+blongjdF+m9M+TFTA+8bvj9tdSOm?=
 =?us-ascii?Q?2Wv5lkuNrO7FGL8u1F64MRSfdWnzUqF8PjrJCrkVxJObqzJXPgVa5MzmX6pu?=
 =?us-ascii?Q?O5OcevPnJSG2qMVOTI7vOyMMAVIR+IMbn3zokjgt488cvBfqtEcGFirIaC9K?=
 =?us-ascii?Q?DmLS0H+F20BW42UMwXBlTaEPsvmrAirovQai1/hrmHbHFdTDS7GhL2fJm4mo?=
 =?us-ascii?Q?PxAHBElk8pK1Lb1aq0L5EVoD1yEuTN2Ltli54gbz944pl85bsIlF7VxotLNL?=
 =?us-ascii?Q?Q8YI72w4G3eMFPs+o/rDvZDhIU/TohNHQzMqqDiY/FRJZk3jIoYAy6/JSuHa?=
 =?us-ascii?Q?vWBIQ2iOlOyWAdHoyK6LCiGlvm4vvU/uYIE/3toTuVLdooDB/IvLWlTGimN7?=
 =?us-ascii?Q?Sxszaq6vRfXWd23aNMZ1J6W2+tJfEgEgWYkLpvq1G4gPB3XPNP3ig4qxgvJG?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2519ab18-6194-4196-8fb4-08dad4bdbe22
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 23:34:23.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZORTdUcT01BTj8+KnGGP0GJLIx1BmaP4KnlKNrvB+S09nat5tLLpltoeVwKrAeILYQw2sll1REv4LnRd8Gor/4DMvtYvZUxoM6FOuAnx0wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5381
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
> On Thu, Dec 01, 2022 at 06:48:12PM -0800, Dan Williams wrote:
> > cxl/mem is cxl_mem.ko, This is cxl/pci.
> > 
> > ira.weiny@ wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The information contained in the events prior to the driver loading can
> > > be queried at any time through other mailbox commands.
> > > 
> > > Ensure a clean slate of events by reading and clearing the events.  The
> > > events are sent to the trace buffer but it is not anticipated to have
> > > anyone listening to it at driver load time.
> > 
> > This is easy to guarantee with modprobe policy, so I am not sure it is
> > worth stating.
> 
> Fair enough.  But there was some discussion early on regarding why reading and
> clearing on startup was a good thing.  This showed that we chose to do that and
> why we don't care.  I'll remove it.
> 
> > 
> > This breakdown feels odd. I would split the trace event definitions into
> > its own lead in patch since that is a pile of definitions that can be
> > merged on their own. Then squash get, clear, and this patch into one
> > patch as they don't have much reason to go in separately.
> 
> I agree that splitting the Get/Clear/and this patch was odd.  However,
> splitting Get/Clear made the discussion on those operations easier IMO.
> 
> As a result this did not really belong in either of those patches on their own.
> 
> It is also very clearly a do one thing per patch situation.
> 
> > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  drivers/cxl/pci.c            | 2 ++
> > >  tools/testing/cxl/test/mem.c | 2 ++
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 8f86f85d89c7..11e95a95195a 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -521,6 +521,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (IS_ERR(cxlmd))
> > >  		return PTR_ERR(cxlmd);
> > >  
> > > +	cxl_mem_get_event_records(cxlds);
> > > +
> > >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> > >  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
> > >  
> > > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > > index aa2df3a15051..e2f5445d24ff 100644
> > > --- a/tools/testing/cxl/test/mem.c
> > > +++ b/tools/testing/cxl/test/mem.c
> > > @@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(cxlmd))
> > >  		return PTR_ERR(cxlmd);
> > >  
> > > +	cxl_mem_get_event_records(cxlds);
> > > +
> > 
> > This hunk likely goes with the first patch that actually implements some
> > mocked events.
> 
> If this patch was squashed into the other patches yes.  But as a patch which
> does exactly 1 thing "Clear events on driver load" it works IMO.  I could just
> have well put this patch at the very end.
> 
> Now that the Get/Clear operations are more settled I'll split this out and
> squash it as you suggest.  Jonathan suggested squashing Get/Clear too but again
> I really prefer the 1 thing/patch and each of those operations seemed like a
> good breakdown.
> 

I'll preface this by saying if you ask 3 kernel developers how to split
a patch series you'll get 5 answers. For me though, a patch should be a
bisectable full-thought. That at each step of a series the kernel is
incrementally better in a way that makes sense. The kernel that gets Get
Events likely needs to clear them too to complete 1 full thought about
enbling Event handling. Otherwise a kernel that just retrieves some
events until they overflow feels like a POC.
