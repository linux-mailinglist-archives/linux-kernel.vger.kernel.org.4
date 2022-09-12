Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC235B63E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiILXET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:04:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC784BD21;
        Mon, 12 Sep 2022 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663023855; x=1694559855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YN78aYfCoq6rTlsOmlBbrl2wszM+meDSafyz6I+cKDY=;
  b=Y0tBqVX51oyqEaviNoEf1gTu/tQKFDCGjOU6UAMQr92S0EIts3ADEe6b
   S+Gfus5oASxa9ZYJFDb3lEk5pO5LdOKpwVTdhgYau9ao5r3tTTYPi5KDY
   +6L9Ijumlb58RtfUWZVc7xF7GvYxj7tYnL7vQlcAj4L3D7kZYyTp/In6J
   BFPfepbr1OAjYdko3ReYftHUhUQfFv7u0OBquxAqXt58hzvssrBjyUuxp
   Lu/qmQ+/PzZTOCNuCSKTLU9bIs6EFjIG+UehsiwPwV11xByzKK/FT3vsq
   +Yoe+jSoA9zxWE6lJCHkcN74XeBa2buEMudqdxExnEcaqhU8jyU5HStyy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299328942"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="299328942"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="944821040"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 16:04:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 16:04:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 16:04:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 16:04:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 16:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK5/md2wL8O4xtGtYyfNG7AMrvQ4gxVPkSHiIGOlRmIluKOfXacEre9hRt9bjMIgR+mY49CUZPZk+JaLSAyMrGVV0FdmDpUjyq0jaHTpwuXTHsRP2HjCDWgmIGNluMwfxvZIbVRSVCTRFsMUALwbIPbu0jEwKUwGA8b581c/4XHQ/EsAGUasTW4VA+nkZyZXzLTQ0ZbnHT7rDp0UHuq3kuY9WjyaRzy1h+W6cNMLcwla6PGaW9oqkUisc5cvnBiuv0uihUQbXdQGRX4yCWGUaMUx8/KO0CpZkLiEeeBPh4GvpVRNcH16K0TjthEmFCTyL5XgQJoNU/hkyv7xpwR6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcRr5tm+gW6b9nhmiqd0R9Gpfs4eqCJeDUu8iyD/f7w=;
 b=GImPz0qO34HmQRisBNvUtQQGMFYfLLsdCEQqMXyXN33n0IbMWeiilc1lPvFN24m3EBJ15tXA3/iLGIy7IKGKNEGvn7K7uwvHJE2bFK1YnBuksivfY7m2abs59kMT3fmrysPAxPVIasIeGSEqYgPOPRVi7BQSMpM/Ww7XuxNbVTHpmYwhzbt2zCxX4jIOVA3neFbX4TyrUp/5+EkSAGq2tcp6NA21xfKpIXzvu9+LTUcESCVZsC7PhtYilWCpiI2mZIGlqK6gX4RXqwOM14EWmBE0ohS/ZjgyV6TM3UxnZatlywQhg2SeM38MaikAa7GJdyLq/LSJNxKqffIVH/QaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 23:04:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91%3]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 23:04:12 +0000
Date:   Mon, 12 Sep 2022 16:04:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Trace DRAM Event Record
Message-ID: <Yx+65zjlpTsmg6M5@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-6-ira.weiny@intel.com>
 <20220825114632.00003fc6@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220825114632.00003fc6@huawei.com>
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0c33b8-687d-42b0-3a6d-08da95131b1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHm1lExvLSw1y6BUzs/892u+Gg+FSKivWgYpszanOJmRcKRBT75XrrvdrCXB/K799DxeSoMyoKiAVDTgwohinUa6si87SPUAZPevB395ksocgnZ//lIGZbzVNdizoDgoJantWpF/UyuUQABTwNVdH+DtVGSon1fRyBw3itEUYugcKnMACtlfzb8Lvzk4VUh1KnjEmO9d1p5LgBY7XgnOgLK36Yn/6+pVwvJS25Oh/gxe3Ut/xlU/oOre3OCmkRL4i0+jTPr1MV5+FzGZD2qxjykiiCai+f+rIJSvVYenG9YPuLoVOkFmjevPJlds72oL9q8BONAseWf1Q5yJa9CJdQjtNY3JWC7tF4HroSWceCft0FT75BNC384Qw7dUuiaUkBd57+Su9pobsWAORHbZi3vqMiW+n2gGA3GDSFM37MamTU8ZewbCSHHb2okTi9IgUsKKgW/+dpo82i7DSXnSPbmkPAd3ubAdZPI1aFaz/JLrdYaeNzgdjxZYDZZG/GaQC6hKIm+ZE8XVFECrQqU+u9Twaxll8vUcFRckficQlJiKy0bQiALAFRGKJfRTX3tFQmMusK/dlDMpXPaz7CYAjf6VJGhv0HW1Cj3TfNsXTwGHPMqC6dASUS0hHI6nUsM+5gV7qrjsfqWO/qHu7SqkdYz3qsMKHTX20z4EJEBhKGMN1lq0oDiiisP18+AYvgTqb5U9PEC+eCuSmtapDFGe/yxD8W2E8bymnf67nbfW/0fcXav3FqRB0mL3bwFt60V/akVqRhLIU7IScF7Lxf77j6Tvd/xdkpGicQqpmn7kSRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(186003)(6506007)(54906003)(6666004)(6916009)(86362001)(2906002)(44832011)(4326008)(8936002)(82960400001)(33716001)(8676002)(6512007)(66556008)(38100700002)(966005)(6486002)(66476007)(316002)(5660300002)(66946007)(478600001)(83380400001)(41300700001)(9686003)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mJmPYktc8eIrj8dz6m61x/cYJlZfsgmiBIM9KIiQjlKfWXdqQXHt0urVq2g?=
 =?us-ascii?Q?qFvK/Hz/DWSMz9SJBDIo+XlFVTdRqNQxMs3WS12y4/C636A7JIxpHaD3/3rw?=
 =?us-ascii?Q?Rw6E512hQ8Xg9uO3j07RuqBAioQN0WyFYgDN2h5l04o7TlL7jdpAaaLyaOHl?=
 =?us-ascii?Q?jtbR6oXVDEZjQiKAcY98ja3DK4P+T6ueWzhehW5Uw+u8Dw/bijdzzXILAYGh?=
 =?us-ascii?Q?ZGDeBR/s225mzZIyulTYPPuTkVWomow1URnDu8PT9t2vRCpNhhlE1tXB0J4C?=
 =?us-ascii?Q?amyOOWPOLaM8q1BSEcPkT6o8Y7lZzHpDweX9iRfX+dWCukyEBUXNeQOgIapK?=
 =?us-ascii?Q?e2GD1zUNKOVX47XbBMkgZ9c7/nIdsoUQOtDvPsB4bj/aqC3NE0spbCHokCYI?=
 =?us-ascii?Q?EoApihHUpt2TPPBdfkBqTKF9r2sF3Ke+v6y7DgXrPBFgxBjuOGMpe9TY9NCG?=
 =?us-ascii?Q?e8eLb9vvwcfxSc6qeNOeph6bAWQFZYclG3zX1TrctOEgcoDf/Sh38ZbNN2ij?=
 =?us-ascii?Q?9plsaxxxjRfuyWf+v55ZIIRQlJkXAEas7g69pLfc5vOff+BD8LsZWWBo+Qf9?=
 =?us-ascii?Q?3prCwXUe0TjQ/YeposQQ+tPzGEltq73xVwKQVWxKC4ROMAVSQBBplPnc5ErQ?=
 =?us-ascii?Q?jdWLOzjuBZggXi/AqrYWnojOdg97LX8bCse+6BF7y1utrP17LojeH6Y0V2ls?=
 =?us-ascii?Q?sw9ymbWrEkmeAFmB7OpJwR/vIYGzbIL6h1pfG2lgHRb/3V/1H7YKU2cyhooS?=
 =?us-ascii?Q?GOXRY5uD7e0a5KuEiIksCAiHSBf+r+KqAQplE18HanlcnhBowOigZ0NieUsy?=
 =?us-ascii?Q?yxru75oDmYMED+Fvm9ObdgGurIAmxadFBH/JPvfr4DkbXtJxLsjM4W4kFhGJ?=
 =?us-ascii?Q?cwTPIbfwviMmaPh0FIx7C7FbTVMTk2XyBkU/cAdjf7wHIEXjQdsLtT/qBX8t?=
 =?us-ascii?Q?VK23p9E6IdpUvv/ny2/6W8GdFdOPniH8e+tNBEhAisVgx3GvdD1yLBEsPDZJ?=
 =?us-ascii?Q?Y63hon7eLgjVgimELoyIeqaEltptqyfI9ezyl2jxp1Rcf9GdR7D57zBNkzEA?=
 =?us-ascii?Q?dAJ5sZgcTyav8ppqFK/Kwb7sqgltjHu06KwjWg6S2CdPh2Nc984MbZLr0X4d?=
 =?us-ascii?Q?Mx/PfaYeILehgwIq19Dolsbjg1JHFwZ/vjr+I8OYyKpnnjuPeOTaYjlGEZle?=
 =?us-ascii?Q?BCelYqfPpf3xmFhmAa30zjML3oPqaDGl8yhLSas4Nnd2rOnZgJVjxzBW92//?=
 =?us-ascii?Q?SLFEpuVmMihsB8puWsGuk9hspQy4NqEscDz4pYpsyHxqwhY0vGiYfBXMS3g2?=
 =?us-ascii?Q?jxXKIVd4wbrCQXKfAMhVF+KRhb27F+PqQmBMH7NSG61Hg1z18SqHcJVsJaD3?=
 =?us-ascii?Q?ntEvAJE4bjwo/b6pILrps8Y1qO7jJsJIDcb7oeP+yyaxsatLymx4Uq5ahRrD?=
 =?us-ascii?Q?RPFUU/qNuBVw2WZsVgaRDJRdlMEgXKq7Z/xY1+lkY4YCHW+zn5G/2JblCJ8j?=
 =?us-ascii?Q?Qq1+h/BHv7bxAacfpSnFvOsFx4uIOQGBVmJzUvbAv5dyqjQ4ySPonMpkAnFE?=
 =?us-ascii?Q?Rgiqf65H+4w3JWfyaKZDV+mpnU3KGoW0ClS66FR5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0c33b8-687d-42b0-3a6d-08da95131b1c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 23:04:12.0286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQfkQhS1VFwPRTNAVRuC54U6tKglPZTGWH+LJNqPVcNu2d4c47MO0B14zFmX9dg8IUhtqMxEUB8TqxK8yw5KaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:46:32AM +0100, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 22:32:39 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL v3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> > 
> > Determine if the event read is a DRAM event record and if so trace the
> > record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > This record has a very odd byte layout with 2 - 16 bit fields
> > (validity_flags and column) aligned on an odd byte boundary.  In
> > addition nibble_mask and row are oddly aligned.
> > 
> > I've made my best guess as to how the endianess of these fields should
> > be resolved.  But I'm happy to hear from other folks if what I have is
> > wrong.
> My assumption is same as you.  We should sanity check of course by
> poking relevant people.  
> 
> Similar comments in here to previous.  Use the get_unaligned_le24()
> accessors + consider not printing invalid fields.

Yea I've already converted the 3 byte fields to get_unaligned_le24()

> > 
> > struct cxl_evt_dram_rec {
> > 	struct cxl_event_record_hdr hdr;
> > 	__le64 phys_addr;
> > 	u8 descriptor;
> > 	u8 type;
> > 	u8 transaction_type;
> > 	u16 validity_flags;
> > 	u8 channel;
> > 	u8 rank;
> > 	u8 nibble_mask[CXL_EVT_DER_NIBBLE_MASK_SIZE];
> > 	u8 bank_group;
> > 	u8 bank;
> > 	u8 row[CXL_EVT_DER_ROW_SIZE];
> > 	u16 column;
> > 	u8 correction_mask[CXL_EVT_DER_CORRECTION_MASK_SIZE];
> > } __packed;
> > ---
> >  drivers/cxl/core/mbox.c           |  16 +++++
> >  drivers/cxl/cxlmem.h              |  24 +++++++
> >  include/trace/events/cxl-events.h | 114 ++++++++++++++++++++++++++++++
> >  3 files changed, 154 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 0e433f072163..6414588a3c7b 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -717,6 +717,14 @@ static const uuid_t gen_media_event_uuid =
> >  	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> >  		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> >  
> > +/*
> > + * DRAM Event Record
> > + * CXL v3.0 section 8.2.9.2.1.2; Table 8-44
> rev3.0, r3.0 or just 3.0  

Already done.

> 
> > + */
> > +static const uuid_t dram_event_uuid =
> > +	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> > +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
> > +
> >  static void cxl_trace_event_record(const char *dev_name,
> >  				   enum cxl_event_log_type type,
> >  				   struct cxl_get_event_payload *payload)
> > @@ -731,6 +739,14 @@ static void cxl_trace_event_record(const char *dev_name,
> >  		return;
> >  	}
> >  
> > +	if (uuid_equal(id, &dram_event_uuid)) {
> Why not else if?  Should be obvious to compiler that multiple uuid_equal
> conditions can't match, but even better to not make it try hard perhaps?

Sure else if can work.

> 
> > +		struct cxl_evt_dram_rec *rec =
> > +				(struct cxl_evt_dram_rec *)&payload->record;
> > +
> > +		trace_cxl_dram_event(dev_name, type, rec);
> > +		return;
> > +	}
> > +
> >  	/* For unknown record types print just the header */
> >  	trace_cxl_event(dev_name, type, &payload->record);
> >  }
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 33669459ae4b..50536c0a7850 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -421,6 +421,30 @@ struct cxl_evt_gen_media {
> >  	u8 component_id[CXL_EVT_GEN_MED_COMP_ID_SIZE];
> >  } __packed;
> >  
> > +/*
> > + * DRAM Event Record - DER
> > + * CXL v3.0 section 8.2.9.2.1.2; Table 3-44
> > + */
> > +#define CXL_EVT_DER_NIBBLE_MASK_SIZE		3
> > +#define CXL_EVT_DER_ROW_SIZE			3
> > +#define CXL_EVT_DER_CORRECTION_MASK_SIZE	0x20
> > +struct cxl_evt_dram_rec {
> > +	struct cxl_event_record_hdr hdr;
> > +	__le64 phys_addr;
> > +	u8 descriptor;
> > +	u8 type;
> > +	u8 transaction_type;
> > +	u16 validity_flags;
> I've not tried it, but can we just mark these as __le16 and use
> the unaligned accessors?  get_unaligned_le16 etc

get_unaligned_le16() requires a byte array...

So I think this needs to be:

	u8 validity_flags[2];

Now that I know about those calls I think this does make a lot more sense.  The
test code works but I knew that it would be sketchy with real devices.

I'll adjust this.

> Also there is get_unaligned_le24() for the 3 byte ones.

Yea done.

[snip]

> > +
> > +	TP_fast_assign(
> > +		/* Common */
> > +		__assign_str(dev_name, dev_name);
> > +		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
> > +		__entry->log = log;
> > +		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
> > +		__entry->handle = le16_to_cpu(rec->hdr.handle);
> > +		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
> > +		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
> > +
> > +		/* DRAM */
> > +		__entry->phys_addr = le64_to_cpu(rec->phys_addr);
> > +		__entry->descriptor = rec->descriptor;
> > +		__entry->type = rec->type;
> > +		__entry->transaction_type = rec->transaction_type;
> > +		__entry->validity_flags = le16_to_cpu(rec->validity_flags);
> > +		__entry->channel = rec->channel;
> > +		__entry->rank = rec->rank;
> > +		__entry->nibble_mask = rec->nibble_mask[0] << 24 |
> > +				       rec->nibble_mask[1] << 16 |
> > +				       rec->nibble_mask[2] << 8; /* 3 byte LE ? */
> 
> Use get_unalinged_le24() ? I'd definitely expect these to be le24.
> 
> 
> > +		__entry->nibble_mask = le32_to_cpu(__entry->nibble_mask);
> 
> That doesn't look right.  You will have unwound the endianness using
> the shifts above. Don't convert it again (noop on le systems, so you
> probably won't see a problem when testing).

I thought I did it right with 2 shifts.  But regardless using
get_unalinged_le24() is better and I've already changed it.

> 
> > +		__entry->bank_group = rec->bank_group;
> > +		__entry->bank = rec->bank;
> > +		__entry->row = rec->row[0] << 24 |
> > +			       rec->row[1] << 16 |
> > +			       rec->row[2] << 8; /* 3 byte LE ? */
> 
> get_unaligned_le24()

... and this one.

> 
> > +		__entry->row = le32_to_cpu(__entry->row);
> 
> > +		__entry->column = le16_to_cpu(rec->column);
> > +		memcpy(__entry->cor_mask, &rec->correction_mask,
> > +			CXL_EVT_DER_CORRECTION_MASK_SIZE);
> > +	),
> > +
> > +	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s': " \
> > +		  "phys_addr=%llx volatile=%s desc='%s' type='%s' trans_type='%s' channel=%u " \
> > +		  "rank=%u nibble_mask=%x bank_group=%u bank=%u row=%u column=%u " \
> > +		  "cor_mask=%s valid_flags='%s'",
> > +		__get_str(dev_name), show_log_type(__entry->log),
> > +		__entry->timestamp, __entry->id, __entry->handle,
> > +		__entry->related_handle, show_hdr_flags(__entry->flags),
> > +		__entry->phys_addr & ~CXL_GMER_PHYS_ADDR_MASK,
> > +		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
> > +		show_event_desc_flags(__entry->descriptor),
> As before can we not print the invalid ones based on the validity flags?
> 
> Few years ago now, but I did something along those lines for the CCIX equivalent of
> this stuff.  (honestly can't remember much about it now though!)
> Was a bit fiddly but lead to nicer prints in my opinion.
> 
> https://lore.kernel.org/all/20191114133919.32290-2-Jonathan.Cameron@huawei.com/

I'm still not seeing anything which alters the actual print in this patch or
ras_event.h

Perhaps I'm missing what you mean by selecting the valid fields.

Something will have to change the TP_printk() format itself from what I can see
and I don't see a way to do that within the trace infrastructure.

We _could_ do that within the C code where trace_dram() is called.  But I'd
like to keep all the info together and let user space decode more than what the
kernel may know.

Ira
