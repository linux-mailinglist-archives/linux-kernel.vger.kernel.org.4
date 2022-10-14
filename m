Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06C5FF6FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJNXpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJNXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:45:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F160AB40C1;
        Fri, 14 Oct 2022 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791147; x=1697327147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gfRdGB9TJHeVslHM/vivwutMPamk7naLxL+dIk843kM=;
  b=m3jyuqGMyeYFzLagit+8y6Xt+STs/6pD9LEZ2kGlQmyEbi84U5AgRhKi
   LQcZPK1p9FkWzHstV1bsrjLNdXhB8SzLzTP8ufQJxsDpQdtq+kks/A3p+
   1v1cVcJk6bmDW3vuN+kVvLZUxSeW82Wa5JAIg45ohEkC4YJcJYbfJ1kD1
   QxwVXhKj7+2FqztH6sDpu//U7+QoIqymkd4XMYojh599rc1w6+EDq8mUh
   psAseqnOv0B9tyU2hq+rsW3vunD1a27suodPeicQz66FEFUdzlB4sHIph
   /eC9bbJA7BVBMlQaZJkQn99tTkzZtL45BdVX6dewRMUprWv9h+eQZQNAJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285223131"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="285223131"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="802796577"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="802796577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 14 Oct 2022 16:45:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 16:45:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 16:45:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 16:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHG5vpAIGzJI09NC3CTomNCCtQsd5r2T16c8wfxsy/38jRB/ro7ht837eMzFkjDOeBeseaZgVmEx1NVMQ6gWmkQzxMM11B4TLGXQvGP64BGIZCCKud3lP/lmM5cMghTLouSwxU/YwM3Nwm1dTCdfqx6JaonILNG50aXVpUQf2eAX4ETmN8iAntbzho3c7AzeUxov81O0J7vHFUnSsLdgqw1v8d5UV/u/TlZnPu2xbagpqXESPBTd9uU7OwMlEm9fdZrROlZWsn1xbLusn55e0Y60540R9aci32dUeqgH3QZt7GWlWR4VZIUjKq+mhMSV73kH6Ue73f9wmVZ4Djcopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM+m+x34C4LBHQW3LA9GVPoYoRaCpR0H4K5oixM/3tk=;
 b=DNR8lj5CZ/sMGwC4opKL7A+F5UKUfRSV1XeSr1kSsdLOXwklSJ46f1uawLNBsEhj+ThYcprzKEVyHZhr1+sq8nkyp8HFC1TqgAGsQxb4Pk7GIzh+wca5oBA3ihi2DuO9lZs8EF/uMVJrn/cawj7n4Zoj0jKSxCE66uLkNtDc/SW3U0RIIEM2P858y2r5WdsYOyooXxKYZmlq2zKXxraLqtFaO5U09rJdMHpWj92z7Ksck/1Qr2XLcRtgIYNeo4fdGQl8pYKK835KUZN56ggwILcEwK5Mf8TMTCNZCxoK+7ZdxPI1PG9JDO4sQdla31I8K57JGvZzvPxfmXZVM+TcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 14 Oct
 2022 23:45:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 23:45:44 +0000
Date:   Fri, 14 Oct 2022 16:45:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 06/11] cxl/mem: Trace DRAM Event Record
Message-ID: <Y0n0o0r85ldlLMqp@iweiny-desk3>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-7-ira.weiny@intel.com>
 <20221011144712.00004a05@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011144712.00004a05@huawei.com>
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6037f7f1-34d6-4b5a-14ae-08daae3e35c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgDc26Fb8oKYNohsLd/LNKZoZMvJJbSVYkzQvFu6XqpjZpaL/wY6UzpkdVEbMJWx5/JxYCY+BgFRa0g8PMqM1f1Jnzr1J2yNXZTBc74OENbL2H/b4d6s/xRsuz3xwV5brJqSXm/Cqz/j0Oxf9kGzipvTi5tyECHrpvM13aL8zUtzgZuRsISWX9C4tAsjjZONUuMKR4CzeGG0Cy0aMS08z6BR7UE1A9W8fvMwesYjCuwKgEPspIO/jAVQ+3MPqnX+4pimVWEKy6c9eXVJr66ApRpi5H24Lq0P0HxlKTWDH5RDVowGD9dbovZYGr3OX6tUgSzHUwAh3tp0G9imdlbPfRD8XbE0bfgJ9/diRqOOaP/skJBoRm2vUtxavIeOKHXyoOe/Z2bMiHxBrCLTIzdfVdTBHSKXgWUqUeNA2CIt/Lp1bhHRoJey493JS7cgTdQVwFYsJjb6LZX7nu7h4giO5DuBz6tuTjAURTga6uuf10r+mRYyUXfgcfZMPysxz8hVtRiUilygEBwSFwZFRjb9dFakOJcbewlKWKBwyxSTOluK90JzgDYGN4ZxZyVD6Y0tWpXHvUs2y4wmXcLOcYeRe6ZTpvs1bi4Br8mwk56HOL0Wb7HC5fmzcMNihmuerQLtCxeITvzGQLHcsCp6IC7N+usi2VsGOTB6uX6/DvDorITMXVXHE6uR1sdlzs6swa4nYRYF9Z9JoMd/NB9JOvPopg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199015)(186003)(2906002)(33716001)(9686003)(6512007)(5660300002)(6506007)(26005)(6666004)(4326008)(66946007)(86362001)(6486002)(66476007)(38100700002)(41300700001)(6916009)(478600001)(44832011)(83380400001)(316002)(8936002)(54906003)(8676002)(66556008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjbgRUhOw9HIAcZPruEwELr5AvCGPkbcu4DcK5qVtJEnuwh+APv3sq8rawR1?=
 =?us-ascii?Q?49HAgqoanYxzh4octmAY4lcksIERwNlLCFyiuhHAYBl6jGF5Lt/+I0UEY6kH?=
 =?us-ascii?Q?pmwqmdDY6wIknfZYV4FAJKAU1UKUpw/FZ3jVf9SLfRGdM7XljQZyWqLQHcoP?=
 =?us-ascii?Q?eGd3Xe1Kr3bKrc/qT4psU2w3qL+jVP4f6j9GLdUBLOGnYCzvYYR2d6gmr5n2?=
 =?us-ascii?Q?45X2BqPuTPa33C/9OyVs8Bt9R7EJxEgC1amiHdTFTUVtVGayN3nnvYyaWKf0?=
 =?us-ascii?Q?3YhraKY79J0o2RhfYmA3+2sUQXVoYPKnEZdQnEv2fmHrjCwJhxRgfd6+iPa0?=
 =?us-ascii?Q?uIDXYmnBQeQFDIRKRFb8u9RYUZP7ZABbDw9Wcfywiqscgtp83RAgFyvIBZzW?=
 =?us-ascii?Q?Qns3O6NFuZRCkq6hmduI5Y52pEDLWvavNAFW3FFwbi6/oh/76SUNZHlzkwiD?=
 =?us-ascii?Q?SOXbVUyJvcoHQUfyAB0Kp6UiCfqC2YmWuEYjDEU334gS77iPnZNxLgcU2bKt?=
 =?us-ascii?Q?JZD/aF5yYwQLH6lcTgbX+hpQzpoZCM46SH6CFr7HgvChB6G0xx7H8W2UvJMS?=
 =?us-ascii?Q?piH8DQZZb1dcjMkqK3mV8taHpOnoQIOYwPffX1iLb0lxa7w0lILbRL0xr5rz?=
 =?us-ascii?Q?+1EYOnzcV/sCVUChqq/EFfyWB02+X7ffoS01Zk5BNlP5f8mL+gsWNf9mO+NS?=
 =?us-ascii?Q?AQpaqz6xHoZCzEZxLOQiEA9WepUillBF3088OgIOIq/dL4m9ekbD8AwUAYz+?=
 =?us-ascii?Q?+NM/xbUgkzACMdAo8EXMKFZPZG0Hvt/MGZH9nQTn3Dl00VGhDMe7n3IblaDd?=
 =?us-ascii?Q?MrQGD05VNUu3CiSogB+6fVQs/mzKgHXCrGlOhKVOKP4o9x5KCZ6iXPBUbnZX?=
 =?us-ascii?Q?TvYcp9H6T6d08KDJBAMwKqDuqGm4kKlaLl17uAaLwY3uMkrGpEsNcVnLHhjB?=
 =?us-ascii?Q?2GoHIBCYtMUyKkzYwcDADjdhmLZbzj1MJronr3T6whaMxX9GlzjnLbFrvGlf?=
 =?us-ascii?Q?O1TdOOhN9X1+c8fyIWIZ3uZoe4Oc516PoBngHm6BWEAh4oZmPmwCiWxuFvD+?=
 =?us-ascii?Q?l18jic/EVybJWTMakME3Omn0ytH+AsDhbDx5ALxAz8+ZxOE6XyF/jB43uaGZ?=
 =?us-ascii?Q?L/uuNimN84rCkKsozmo86eX/vUWN92DZfpXbMVEp8zAHzC6fL1jrmbnjLbzo?=
 =?us-ascii?Q?f723N+S0oIpBTSdcg/jjqoBxcNduNdb9Ds5GW3wvNr9DrszliT4HNuSuBgxB?=
 =?us-ascii?Q?JtQJlJd6EQeGbqB2rKUOtbOXAsv3ZOV1AmVQT213aN34k8S7/UcIT4NnYI9B?=
 =?us-ascii?Q?HSLlblgaHHVMo/AjjmTrDF7c2iTq6qGs5Rz0dYoHUFTUUOe0G2IwMtw9n2qk?=
 =?us-ascii?Q?J2YDS6r2Klcn1p1KzKCb0RxWH4LSw1Bsd53AtDsZGupGA+MEq2UEliTx5fCL?=
 =?us-ascii?Q?PdCIjvvFxrW/tYsKA3krhRxIJpATaBfIJpaa9lPoY2ovv9dE2qvoDz3osrIk?=
 =?us-ascii?Q?c/Tnn6/Is4e5i7yRyxubqjCulg+BcrhRfjx//SjrhHhSkuafEJCXfBRtm8rB?=
 =?us-ascii?Q?oIHji2k8NLO68Tu8AKTId79lTuoiTIW5SD9iKndx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6037f7f1-34d6-4b5a-14ae-08daae3e35c6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 23:45:44.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjKqIyXA81OSGdjudHM5ppKjMH4VuYjlaNqIo4IBhHP/zg+Q2WkpjkWvpLiiorkGTwur1DngKRGp+SPsUDVgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:47:12PM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:41:26 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> > 
> > Determine if the event read is a DRAM event record and if so trace the
> > record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> Trivial comments inline
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> > index 82a8d3b750a2..7a90cfea348b 100644
> > --- a/include/trace/events/cxl.h
> > +++ b/include/trace/events/cxl.h
> > @@ -230,6 +230,100 @@ TRACE_EVENT(general_media,
> >  		)
> >  );
> >  
> 
> > +
> > +TRACE_EVENT(dram,
> > +
> > +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> > +		 struct cxl_event_dram *rec),
> > +
> > +	TP_ARGS(dev_name, log, rec),
> > +
> > +	TP_STRUCT__entry(
> > +		CXL_EVT_TP_entry
> > +		/* DRAM */
> > +		__field(u64, phys_addr)
> > +		__field(u8, descriptor)
> > +		__field(u8, type)
> > +		__field(u8, transaction_type)
> > +		__field(u8, channel)
> > +		__field(u16, validity_flags)
> > +		__field(u16, column)	/* Out of order to pack trace record */
> > +		__field(u32, nibble_mask)
> > +		__field(u32, row)
> > +		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
> > +		__array(u8, reserved, CXL_EVENT_DER_RES_SIZE)
> 
> If we are going to have this, why not put it at the end?  Will that affect the
> packing badly?

I removed it.

[snip]

> > +
> > +	CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' " \
> > +		"trans_type='%s' channel=%u rank=%u nibble_mask=%x " \
> > +		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
> > +		"valid_flags='%s' reserved=%s",
> > +		__entry->phys_addr & CXL_GMER_PHYS_ADDR_MASK,
> > +		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
> > +		show_event_desc_flags(__entry->descriptor),
> > +		show_mem_event_type(__entry->type),
> > +		show_trans_type(__entry->transaction_type),
> > +		__entry->channel, __entry->rank, __entry->nibble_mask,
> > +		__entry->bank_group, __entry->bank,
> > +		__entry->row, __entry->column,
> > +		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
> > +		show_dram_valid_flags(__entry->validity_flags),
> > +		__print_hex(__entry->reserved, CXL_EVENT_DER_RES_SIZE)
> > +		)
> Probably one less tab on that trailing )?

Done.

Thanks!
Ira
