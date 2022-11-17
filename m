Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46F62D05F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKQBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKQBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:07:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554126A69C;
        Wed, 16 Nov 2022 17:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668647255; x=1700183255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9gwi3K4OX4zMrSTGZ+s/hz5DY8UMoH937c1M+sc18kU=;
  b=Y+MO5AZa/emQI23ZdwBsslTsRGX3H8VQ3yFtOHEsgSpsMMZHTh8FXyfq
   dArrXpzryN4HqROTOYGhPU8VpOOp/LGtf/4ocgG01AZGPLZKlJacmh0Td
   JUlTaQDgvBBPxytlvJ6n1lq5WqiAPnmqLCscuZ0OrjN5F3+bZF7SIdzXy
   /IxWUf8V0Ll2FzMUEl6KzzOMLEzHx/d99PfAtIQIzVkEvjqxdNbZJUpYp
   ZC4woXnVORS64NpfGU+Ps2cD+HCdU9MphDLdO/kktc8Pl5D7ycpjqXBa8
   BWT3GsxOJOsn6EKa9slliEUwBVRf5iKheYSddgXdNs4CPXlqIalGcickz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300248053"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300248053"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968656599"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="968656599"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2022 17:07:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:07:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:07:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:07:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr5mSxV1cEjYpdSe8UXkBR6RwWWM8AVMjLnbznvy4efyzh/NGwXtLUX03KuQqIDhNHPTeL77thlKsZ8TFCeC9vBDneexMEuMVOK5m7ElrASKVie8UkRkBDJd/cu3XJH3xQvI9mSbX2uwTvXc20+Wc5MJY9gPLE2N8wI0LEQyDJPl12YIoHkRaQRJ/gw/PVDEgS4oxePBI+6xaFGRaRebVJKnkbjYhqiWPYEmQpxFynQZJ+LYw5+XvWMaqzDE5ZCGRemdxCAuAb5aGwuwfOifmFWbVxGBNaAeXsJJFWnBqO16uuEkeN9HzaDQ153PzUgsWa1FjKgbXcHj0P8PmAe1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UeuIIIBfK4Z++n28tfaBp2+Uy4pmPvyuk4OFQUU9dE=;
 b=UFdinONgDlfMalRb0xdsy1kHhlx8MxCg7yJcxjWwlZUl1ESxGh4A3nVnnonRy9IdYAS8CH4y9TC+++ZcWR5e01PC/RDXVAAcThEACqLfjlUNccyqvolSyLLXbJLnAR+3jAbv6wiz0F2S1umtxOzWRwN5kESUeW65sss4sGb3w0TmhplTBrDzLeKQ31YFdPDWXax5VPxa6IPXkzwLry+c36vUmnSt3PInLpEXBmRUUPvITnDukrWvhKBKdhRrow9ie69ooGRCUEo7RZOaSgiHGBZrRIfCUe9EfI5VH+kaVm4HFtCyktXzo7xOGGOx0bj9QCLGOrHoPL7Rg0sIhBQsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7096.namprd11.prod.outlook.com (2603:10b6:510:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 01:07:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:07:32 +0000
Date:   Wed, 16 Nov 2022 17:07:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <Y3WJUN4oNs6t5qOS@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-4-ira.weiny@intel.com>
 <20221116152426.0000626b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116152426.0000626b@Huawei.com>
X-ClientProxiedBy: BYAPR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e947d4-c0bd-409a-55ad-08dac8381b35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ukqcWv+NYLnTi8zeYg3tw3KiK6ApCzN4QgVe9DlsB+8EWNovDuTcdENQb//VanTGAcIETaRDgfH5rBIyHIMpQFi7VlJH/bo/f/4ATVP2LbBS28fP0AfrOidIySl3vVcja2C5JaPPcpEymP4nl2QsfwrvoMDGlbyNkiS6qDPeSVwLj8OzJCw/RMeqpB/rOfHBM5wvsVG4ZGJJhPP9uzKak8hT6LVMlMkLrK6kKOV6kQ3Mr7QzUBDxOfPla6yip+pu+Y/ZvHvImb49ziO88qtMoQCY3yGgO8B18DnBR55JyO9+aOfX58cuIAOz3XHaiPxifyKqPAjAh4KxmoDhhbdvQC/aY4gFPQsHqVZFS0IuXYZVU388nrrpLa+SK0JWEpKf1cek958nl3IaiE23DcM/MTRZmOpfGG+w7A3nS+AtVxGAA4GlkXkdbWtwleD0vB3vutwfFoSBfnx2Ydzcfs3ucpAYlZANzWrnVvZjAS7LbrCX8FFwEaCSobO76DSGEyWwpLaXFSVAptPqoh3WH06fmiiLFyY/+DbdZfqJx6tmb1P2JC5ZlbOcdLGDU8Gvg3CQYSW2V8EaOPQmGTTDBiuS4vC2JdccgBcl8hKjjzyNoAGz904YH9zzja5LY0Yef0Gl58cmNXRXQ6zDg2xS7Akr6p1R32D1vdeQbrORjAN/C8HVmlqhNFl/VR67bIsFbHK0Dk0PwTTrzDKaFliMAck0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(2906002)(316002)(66556008)(6512007)(8676002)(9686003)(26005)(4326008)(66946007)(6506007)(8936002)(66476007)(44832011)(38100700002)(41300700001)(186003)(86362001)(5660300002)(82960400001)(33716001)(83380400001)(478600001)(6486002)(6666004)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dj/vt/uKqe6aan9f0mGHciMtx4vGzumd8lX1KvYlH69DeZAh9Z8MyYUc44Qr?=
 =?us-ascii?Q?iWfMwIpuqGB4NIo9m+o348YazN0NIK+X+6zYT1BhABdstxt78yZplNvow33y?=
 =?us-ascii?Q?72hKKgw4vTn83RvZ2kCAWfkjlkCnKfzBU7UmHitipwNQFMD6TWMxds6fRQyU?=
 =?us-ascii?Q?qG8zxiA+ZZQjr1w9c0dNrTvh4P82V7sYG6HIVYbg1dLnQY3OEcsIEy2Zs0Mu?=
 =?us-ascii?Q?AEUXE863Q4k1vBhTGzIzctooL+L4adLTFPRvEaA2avEpKJ25xdrBWRrIb5n0?=
 =?us-ascii?Q?vLcW4ulpsZPnKr9/ReozMLVLA9as8xC+iidtAj6tHT5V6spzlNBUg0YiX6iC?=
 =?us-ascii?Q?vclZ+OUy/4b1NlTU8XAi/TdkgUEbAGYHKEh19sF71wdcQ9C65CtbIawk/gKm?=
 =?us-ascii?Q?C3megnmW05UAMjuxtwxpUrc/U+5bTn5Tux0OGRsXksmoRpfkjkC/kq96uFHa?=
 =?us-ascii?Q?2TGNETPzVIxRht8CIgW9f3s6I9HBozGsphuLmBsgYSjj0b2MSzlfcVNom6IM?=
 =?us-ascii?Q?VX2s38GTRFNUBlIbsl+Mc+7AuUwRRXI0r60OVWX2LZ5T0gwAYZlVU16W6dco?=
 =?us-ascii?Q?m6iDqBkB+iCyXnHRfUmEMMFzEe1le9beueO2SxYHKoPx8a2gnN3Z1Xs29Zw6?=
 =?us-ascii?Q?3J/adpWSk1bL1qCQ7y9acVnJudDawlGE7rrHcFGZap8/PrucWbykqUFiyWl6?=
 =?us-ascii?Q?5DL3GVTXYQTbLkgtvTxAbbGJw6uAAnl3XRpoMcuibktv6VKtrMDbrBg9RN4Z?=
 =?us-ascii?Q?X9wz9rXW4pPtB5x0uZksIEj38R1M61tKB4RbsijMcOY9+Viy4mz4nmEinJtG?=
 =?us-ascii?Q?BjcxwT1hyepM8S/7B2R95/L7e1U1URoYw3ygpSaSI8ViiZFlwhMHNOAkD+i8?=
 =?us-ascii?Q?RdJmMl24gLZGfiq4gad4pquRVHxaRbkwKE1iGM7wEp4qxbL6kubSnWzkaOM0?=
 =?us-ascii?Q?ro0/vx2jO9eliaruerZl1tSJvfwEQJVNZREofKABV4C5ecpZLFrjqOBFAEyE?=
 =?us-ascii?Q?iGlBz8zUk1Mn74uyZeq9S293kBm2MHGKX657Bfmm7ehLxFQKSfUJKRXYvBb7?=
 =?us-ascii?Q?ECqpy1qQWBREJ1dxsb0T50AkQisGVwxb1qydTlTTBnRStyqjUvG8Ff+bVXCY?=
 =?us-ascii?Q?0X1y3qyOLpNW/KA2sYN2g87l4jwhINKnu9DMFJz5mJaEblraVc/pDNh+5zku?=
 =?us-ascii?Q?W2DZGrpyhqK86uecC3IuqsuLpv6NQB0ULMH07BH9iZkzRR2dMgA2zuwEzMd5?=
 =?us-ascii?Q?EwWN/ELwgldEdBi1U2wG2iBw/b04dUhCTMJEIpT5zv5ywzbZykBMbSZQIzXH?=
 =?us-ascii?Q?cscpnfZmvoBFB5KZz4BPL//995xrLnHIUxTYWK9atKKzCnQA6X/I6T5JwThz?=
 =?us-ascii?Q?Y90b/EMatLyhU6U0nKC1UkBlkwMdw7LZIQCnheWkfcEy6+3GGI/DtoUJSaBR?=
 =?us-ascii?Q?nHViEDMixIWRHHR0Zc2a3hz4bzuefUA137xDP3Y3spmAonwBj5qO0wFhtLk1?=
 =?us-ascii?Q?xJqadSZk/OOBuZ0mL3aDAoXW9cxx3U8xARcvOEl0adNGsagtUrsQ1cgPqosQ?=
 =?us-ascii?Q?7LWeGXivDN+bOQSB0lAGeeHeeyL6UelF6DFZ3W1U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e947d4-c0bd-409a-55ad-08dac8381b35
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:07:32.7643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0CNQj2QhxEJq6fouUT1zueC2zkbiFRy0a3rRzEX+0qGJgv2tZHd8OawmNjYYxofUMPo+7W6dezWxV0MqdZpAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7096
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

On Wed, Nov 16, 2022 at 03:24:26PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:50 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> > command.  After an event record is read it needs to be cleared from the
> > event log.
> > 
> > Implement cxl_clear_event_record() and call it for each record retrieved
> > from the device.
> > 
> > Each record is cleared individually.  A clear all bit is specified but
> > events could arrive between a get and the final clear all operation.
> > Therefore each event is cleared specifically.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Some follow through comment updates needed from changes in earlier patches +
> one comment you can ignore if you prefer to keep it as is.
> 
> >  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -728,14 +750,23 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> >  		}
> >  
> >  		pl_nr = le16_to_cpu(payload.record_count);
> > -		if (trace_cxl_generic_event_enabled()) {
> 
> To simplify this patch, maybe push this check down in the previous patch so this
> one doesn't move code around?  It'll look a tiny bit odd there of course..

That is the issue I think the oddness is easier to defend here vs having it in
the previous patch.

> 
> > +		if (pl_nr > 0) {
> >  			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);
> >  			int i;
> >  
> > -			for (i = 0; i < nr_rec; i++)
> > -				trace_cxl_generic_event(dev_name(cxlds->dev),
> > -							type,
> > -							&payload.record[i]);
> > +			if (trace_cxl_generic_event_enabled()) {
> > +				for (i = 0; i < nr_rec; i++)
> > +					trace_cxl_generic_event(dev_name(cxlds->dev),
> > +								type,
> > +								&payload.record[i]);
> > +			}
> > +
> > +			rc = cxl_clear_event_record(cxlds, type, &payload, nr_rec);
> > +			if (rc) {
> > +				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
> > +					cxl_event_log_type_str(type), rc);
> > +				return;
> > +			}
> >  		}
> >  
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index da64ba0f156b..28a114c7cf69 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> 
> >  
> > +/*
> > + * Clear Event Records input payload
> > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > + *
> > + * Space given for 1 record
> 
> Nope...

<sigh> yep...  ;-)

> 
> 
> > + */
> > +struct cxl_mbox_clear_event_payload {
> > +	u8 event_log;		/* enum cxl_event_log_type */
> > +	u8 clear_flags;
> > +	u8 nr_recs;		/* 1 for this struct */
> Nope :)  Delete the comments so they can't be wrong if this changes in future!

Yep.  :-/

Ira
