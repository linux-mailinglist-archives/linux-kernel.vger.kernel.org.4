Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC8D63C731
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiK2S3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiK2S3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:29:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F68864572;
        Tue, 29 Nov 2022 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669746589; x=1701282589;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gVcbKExbFvw+ac8nXQwfmTkUHsnxg/76dmpRvDuZlsc=;
  b=ImxCav8G+vaRzLPIJvFFDaop4/HYK08FanaH+ah7+I9KI+kb1E4JNOMP
   iC7e2/uAG/B4FpIRbkj3WK8W1S9x7ABwdQamfY3DabGx0Sn+VNuUZ2tSM
   fudyI2Dhh1idaPFKbzD/pKEeRm/CeNTyuHxgRWJF+ev4CazcyX1Se2U5f
   si859hD1Q+wzKuXRMZ3F9OWQTqGcFdPENvCgTsko4bbCxmL14j4m/kGK8
   bMEDIq+Ony8jpA8Fm2FUfp9P+0vhlTfHyjKWYLzb0GLA97U7vFzTHGPJa
   bNt1jE8bjElL4HfGj4kNf4/C18bTsrAJhg54bccoCxnVj+0mR81ZEJEWS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="302802334"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="302802334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 10:29:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="637699787"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="637699787"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2022 10:29:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 10:29:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 10:29:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 10:29:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWtzn56nZa96CEwouPAznQnMeMRt0BcfUPWcJBPcoQXjCPW4lGNnpdsi0UgKhraKED9aJdVY4f/tQdc1qZXb30UnqLWj81os4Y+Oa1i3rIidOvBFpeR6GRM/MuK2jUR32ELr2RerAZeaMtXtFpm4AIXtYPnyft1qRCBiF4VMa/74YlO2ffeOkgDeTjdEyCHmZbg7jJlYKst+vKWT0XbQFKdPRL/k1Hh+Oi0MHUOK12N0wKxPDrm1t41Qg3j1FxaWW/PeaUp/1xU2mCBEnQkTDmuZlRiFoofHRtlnvokkIJOfoVvM0yc6IAStGn4HjuxO/dq0LInt9hPOV0jk+GDaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeOLZsqeDZKAQlBo/Yfyz90X0w/Qn9hi6feyuEp+vI8=;
 b=eOcANb+nG9DO+jyu0odlvGl0gBBlDbjK/0wN5ovE/VzXLr6rOHqkPTDkqUN8xEqrKiSzVMFDNGasUPU8YF8rVm8mRUWCpVuRyW5ZE/UogCpvWMwQn/lSi7gG1fYkGoqP33dt3p83WBIeuD+7NGjSHoEdeAl66MqtU8BZuapFufcG3JLuxr/VmXutpZtFziVg7SKgrOaZXZr8s4y3bArN38zm0a8SKccdOOidTNAuZxlmuu/AU3eSfgQlcHViq+/6TnJCk/Ywi8C5r5BS6fU3UdWVjvzpg0zorpR6hxUWq4wUX8erJozGbuecOnEklogljgHo2SzMg7N6tclwKIbn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 18:29:43 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 18:29:43 +0000
Date:   Tue, 29 Nov 2022 10:29:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 09/11] cxl/test: Add generic mock events
Message-ID: <Y4ZPklWiS9iMvAr+@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-10-ira.weiny@intel.com>
 <20221116160053.000015f8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116160053.000015f8@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0186.namprd05.prod.outlook.com
 (2603:10b6:a03:330::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 331d026a-c17b-4d51-4164-08dad237af19
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4gQnV41bucKWTTH+klQAajeqMiWAASZfOf97hPVED2syrmGi5/hOGYMRqsjD1UYVyR7dqMVTJkRawaJDau2FLLwh2OfmA9beTiwBK4w6l5a2QHRH1Q5RTG+7maFpj9pkEzu8IPbrzULLpnH76o84LjP8+Ej9v82uSFDassIg8u+OBbNQJyzwzxFzI1OVJ/55oqqYbZpghouP9JtYHMG/Y7K+kTCiEakxg+dTq3jgA12lkFLVdGqI91wrvlez8oJeC6In4crmgob8MtPFnYAtXbrsPiZd3fEJ/XFlMpZ3lSenp/dsrwD0xVQefUMDNeBjQ3PtWHjPHHveFTE+HKrnuf+6ahvOSsHgcLxkEkeV73r8uqnBiwlzA6DqFRgYyLNoyQpYdm8fRwCw+0IztiUMum1jwsip8dV5YDDdFTkQhdohq66IVFtJbb+ckc/ofPlQdXovJ8PNgk917YuevZJsHF2vMmd8BWLhHH2qHvrMzUdZoLfL9CvdsthSVbwrNyQ+dWM8/NvD4FSD/xwjzwOzqdRQ6Ch77qIBQi1AcY0p/ehCkb5a5asZIA6qT5VuxzzaAnsZK3ftLyW+QYhekNNHn2XfIruaXAytCD6YBljSH/mZ0/FD1oIdDAxfMzcoRPKfON1AuUcYuPdA6qZ6kn114LlOPJKsavWmEoFh0/t3x6SEqJPMR8MwEWzKbzz3a64
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(6916009)(316002)(82960400001)(38100700002)(66476007)(4326008)(66946007)(66556008)(8676002)(54906003)(33716001)(41300700001)(5660300002)(6512007)(9686003)(8936002)(186003)(26005)(30864003)(6506007)(44832011)(6486002)(478600001)(6666004)(2906002)(86362001)(83380400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C81JEwmm8XUoinNfiRQTb7ESTeTy/CigRNgqPEADTqHs+8GEZPI5cWyoQ22z?=
 =?us-ascii?Q?RfoiHbillsqoCFEOdEBVx4tfZzbNpygF/Md9yDZXJ/O8D4tqAm+4Ke0/N7As?=
 =?us-ascii?Q?HgMlOhncwCT6qlXtjO6w9sLuEwLRWR2Znno4VCNbRu1itp+bWkaYKuajMb0v?=
 =?us-ascii?Q?4lRZ3hFpJmmuE7WGRAYflCEbRTuOERWt31wC46c2vwGJPXlUMJKePCd6IIb8?=
 =?us-ascii?Q?lIxltvf1BKp2T93g2RxREIQRJLn2A/b146K3ihVOIVe1yin4dAguQohZKuLv?=
 =?us-ascii?Q?HPiVkuMghIGIQeQccMtY4C+/axOopWTzul9v1CWspKdQCzn/m6DGhiw35Ijs?=
 =?us-ascii?Q?kUsfjLxP9gIwgOWEKRDf/qoh1hfU7LaLOhGS92XHUm21LIyJnSkFj6IcljEo?=
 =?us-ascii?Q?4bXLdK2u/czG42A3obC8zp3gJZfXTIWB/KaDmrs7XTzwCA/B3I4oEWaNE5a/?=
 =?us-ascii?Q?RbPbQlmJNE82lLGNt3DOQOmjVn4K2g0RM8F0sO71hDKd5Jl51F0C23JRyoym?=
 =?us-ascii?Q?V/FrcwkqeqImB7wQlrha3WHQAXODjQN2zF14018TZphufoEcdPpAxe/xlS3A?=
 =?us-ascii?Q?TecL0b1V/6oHDsCvkkfdvXlKPgmgyMCCGNauIjzz6B7Oq5uQOmu71WcDyGZV?=
 =?us-ascii?Q?C4sBGRFJg7bpxp0SyntdKcs/8M6k7yjwEf159e+sTGvb6BJw6zLWrGo87Jsm?=
 =?us-ascii?Q?kvFSBdGL3R8MLqCkOKzgsrZ2VlbWeLch7pYhi8buBhEM1X2lUV/KarCQgHrH?=
 =?us-ascii?Q?AU0qsWYchZ/cdAdGngSJGznLQRpUOrnJVAQ1Soi+T3SK5Ltkni81clwxQr0/?=
 =?us-ascii?Q?rKXfCgTBPDELUYhwJI6yHvQz/l+I2H9PGqqei4a94XOc1f6m4dEkqV+S4Wsh?=
 =?us-ascii?Q?LG95UxvRfQlOlQqAd/jf7VIEBFcbQacEOmldydP/clW2mAvXEVVFj6utlZO0?=
 =?us-ascii?Q?eh7g8n7OQdrPXUuc36FHe+/fntvCKOQtKqfM6tlb1esVt8kAu9FuZzT3JAlF?=
 =?us-ascii?Q?5VpnNTsLGYhwVHcSGazacwU+rhRT5LSUFinOTB2eeJFZV/imnGQ3qlSzHstw?=
 =?us-ascii?Q?a1JG7VMdJm7n+6UYKXXEkxPm4AeXOLM9vge4uESTRA3dt04u7jBIN+65aWpc?=
 =?us-ascii?Q?7NFHMWiCPVfxxV+JI7sqLPBesBSNci/6ef1lktq/TEw0iagqKTyjtkY2Br62?=
 =?us-ascii?Q?Ow3PcxXJwDkyk917nwV8QJXyk1K52AIuhpSB44KN3gVK6jfgQgQLSe6E1rzy?=
 =?us-ascii?Q?rBB33T0gjFQq3oPb+uguHQUnnLAmHTU4R8QielmzC8WsXcQlfOi9UHgmVDMH?=
 =?us-ascii?Q?Ez3pjQbYK0kl7VMk0GYuDR8mvWkdoHSgOrQOQNkONmM5gyi/hirr0YD7zyUt?=
 =?us-ascii?Q?gGwCzd6hDcK2tgIze3dgEWasHqmvIoG3I2AIyVJhSulBuLQ/Q0ejBtmVDIuI?=
 =?us-ascii?Q?KPLkGQwyfdtzu6TWCJm4aK4WjTZNxYoCa0f1vgLf3SW9QE6wsRYlzBzWJUsf?=
 =?us-ascii?Q?2pY/QIMukV++a6Wvks3DJ33q/WUNCs62t0dhopf0/+pZb7NdOtW5Rrw73cum?=
 =?us-ascii?Q?su9hnrt4ER8CSwhkcDtoz1SDKSzLknnHfOTBeErY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 331d026a-c17b-4d51-4164-08dad237af19
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 18:29:43.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUPasbnuKY/QDJEmshJNh1MoOBTIQyrZjJej+K2XVdO0fGZTrTlpPQpqs09PQnt5NxbSZESR9jQl7B7jSM9Gcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
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

On Wed, Nov 16, 2022 at 04:00:53PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:56 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Facilitate testing basic Get/Clear Event functionality by creating
> > multiple logs and generic events with made up UUID's.
> > 
> > Data is completely made up with data patterns which should be easy to
> > spot in trace output.
> > 
> > A single sysfs entry resets the event data and triggers collecting the
> > events for testing.
> > 
> > Test traces are easy to obtain with a small script such as this:
> > 
> > 	#!/bin/bash -x
> > 
> > 	devices=`find /sys/devices/platform -name cxl_mem*`
> > 
> > 	# Turn on tracing
> > 	echo "" > /sys/kernel/tracing/trace
> > 	echo 1 > /sys/kernel/tracing/events/cxl/enable
> > 	echo 1 > /sys/kernel/tracing/tracing_on
> > 
> > 	# Generate fake interrupt
> > 	for device in $devices; do
> > 	        echo 1 > $device/event_trigger
> > 	done
> > 
> > 	# Turn off tracing and report events
> > 	echo 0 > /sys/kernel/tracing/tracing_on
> > 	cat /sys/kernel/tracing/trace
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Hi Ira,
> 
> I don't think your mocked device is now obeying the spec
> after changes in the core code that mean it gets a larger
> request than previously.
> If it has more than 1 record and the read is for 3 it
> must return more than 1 and only set MORE_RECORDS if there
> are more than 3.

Based on our other conversations I think it is fine if this test only returns 1
record at a time.  As long as it sets Event Record Count to 1 and More Event
Records appropriately.  The Clear can loop through the number of handles
specified (which will be 1 in this case but it is not hard to do this).

> 
> Gah. The more event records approach also suffers the
> same problem that poison list does. You have no way
> to be sure that "previous software" (which may have crashed)
> hasn't already read some.  So in the core code we probably
> need to do one more read on initial boot to be sure we have
> all the records.  Not sure how I spotted that for poison
> but never noticed it for these.  At least for these records
> the expectation is that there won't be a huge number of them
> so reading one more time is fine - particularly as you clear
> them on that initial read so the list will get shorter.

I can throw in another round of reads on start up.  Actually to be 100% sure we
get all the events cleared the initial read of events needs to be _after_ the
irq setup.  Because irqs are only triggered when the event logs go from zero
to non-zero events.  :-(

Thanks for making me think though this more.
Ira

> 
> Jonathan
> 
> > 
> > ---
> > Changes from RFC v2:
> > 	Adjust to simulate the event status register
> > 
> > Changes from RFC:
> > 	Separate out the event code
> > 	Adjust for struct changes.
> > 	Clean up devm_cxl_mock_event_logs()
> > 	Clean up naming and comments
> > 	Jonathan
> > 		Remove dynamic allocation of event logs
> > 		Clean up comment
> > 		Remove unneeded xarray
> > 		Ensure event_trigger sysfs is valid prior to the driver
> > 		going active.
> > 	Dan
> > 		Remove the fill/reset event sysfs as these operations
> > 		can be done together
> > ---
> >  drivers/cxl/core/mbox.c         |  31 +++--
> >  drivers/cxl/cxlmem.h            |   1 +
> >  tools/testing/cxl/test/Kbuild   |   2 +-
> >  tools/testing/cxl/test/events.c | 222 ++++++++++++++++++++++++++++++++
> >  tools/testing/cxl/test/events.h |   9 ++
> >  tools/testing/cxl/test/mem.c    |  35 ++++-
> >  6 files changed, 286 insertions(+), 14 deletions(-)
> >  create mode 100644 tools/testing/cxl/test/events.c
> >  create mode 100644 tools/testing/cxl/test/events.h
> 
> 
> > diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> > new file mode 100644
> > index 000000000000..a4816f230bb5
> > --- /dev/null
> > +++ b/tools/testing/cxl/test/events.c
> 
> 
> xl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> > +};
> > +
> > +struct mock_event_store {
> > +	struct cxl_dev_state *cxlds;
> > +	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
> > +	u32 ev_status;
> > +};
> > +
> > +DEFINE_XARRAY(mock_dev_event_store);
> 
> Perhaps add a comment on what this xarray is for.
> I think it's all to allow associating some extra data with the devices
> without bloating structures outside of tests?
> 
> > +
> > +struct mock_event_log *find_event_log(struct device *dev, int log_type)
> > +{
> > +	struct mock_event_store *mes = xa_load(&mock_dev_event_store,
> > +					       (unsigned long)dev);
> > +
> > +	if (!mes || log_type >= CXL_EVENT_TYPE_MAX)
> > +		return NULL;
> > +	return &mes->mock_logs[log_type];
> > +}
> > +
> 
> > +
> > +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_get_event_payload *pl;
> > +	struct mock_event_log *log;
> > +	u8 log_type;
> > +
> > +	/* Valid request? */
> > +	if (cmd->size_in != sizeof(log_type))
> > +		return -EINVAL;
> > +
> > +	log_type = *((u8 *)cmd->payload_in);
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return -EINVAL;
> > +
> > +	log = find_event_log(cxlds->dev, log_type);
> > +	if (!log || log_empty(log))
> > +		goto no_data;
> > +
> > +	pl = cmd->payload_out;
> > +	memset(pl, 0, sizeof(*pl));
> > +
> > +	pl->record_count = cpu_to_le16(1);
> 
> Not valid.  Kernel now requests 3 and as I read the spec we have
> to return 3 if we have 3 or more to return. Can't send 1 and set
> MORE_RECORDS as done here.
> 
> > +
> > +	if (log_rec_left(log) > 1)
> > +		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> > +
> > +	memcpy(&pl->record[0], get_cur_event(log), sizeof(pl->record[0]));
> > +	pl->record[0].hdr.handle = get_cur_event_handle(log);
> > +	return 0;
> > +
> > +no_data:
> > +	/* Room for header? */
> 
> Why check for space here, but not when setting records above?
> 
> > +	if (cmd->size_out < (sizeof(*pl) - sizeof(pl->record[0])))
> > +		return -EINVAL;
> > +
> > +	memset(cmd->payload_out, 0, cmd->size_out);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mock_get_event);
> > +
> > +/*
> > + * Get and clear event only handle 1 record at a time as this is what is
> > + * currently implemented in the main code.
> > + */
> > +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> > +	struct mock_event_log *log;
> > +	u8 log_type = pl->event_log;
> > +
> > +	/* Don't handle more than 1 record at a time */
> > +	if (pl->nr_recs != 1)
> > +		return -EINVAL;
> > +
> > +	if (log_type >= CXL_EVENT_TYPE_MAX)
> > +		return -EINVAL;
> > +
> > +	log = find_event_log(cxlds->dev, log_type);
> > +	if (!log)
> > +		return 0; /* No mock data in this log */
> > +
> > +	/*
> > +	 * Test code only reported 1 event at a time.  So only support 1 event
> > +	 * being cleared.
> > +	 */
> > +	if (log->cur_event != le16_to_cpu(pl->handle[0])) {
> > +		dev_err(cxlds->dev, "Clearing events out of order\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	log->cur_event++;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(mock_clear_event);
> 
> ...
> 
> > +
> > +struct cxl_event_record_raw maint_needed = {
> > +	.hdr = {
> > +		.id = UUID_INIT(0xDEADBEEF, 0xCAFE, 0xBABE,
> > +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> > +		.length = sizeof(struct cxl_event_record_raw),
> > +		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> > +		/* .handle = Set dynamically */
> 
> Multiple devices... So this should be const and a copy made for each one
> to avoid races.
> 
> > +		.related_handle = cpu_to_le16(0xa5b6),
> > +	},
> > +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> > +};
> > +
> > +struct cxl_event_record_raw hardware_replace = {
> > +	.hdr = {
> > +		.id = UUID_INIT(0xBABECAFE, 0xBEEF, 0xDEAD,
> > +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> > +		.length = sizeof(struct cxl_event_record_raw),
> > +		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> > +		/* .handle = Set dynamically */
> > +		.related_handle = cpu_to_le16(0xb6a5),
> > +	},
> > +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> > +};
> > +
> > +u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct mock_event_store *mes;
> > +
> > +	mes = devm_kzalloc(dev, sizeof(*mes), GFP_KERNEL);
> > +	if (WARN_ON(!mes))
> > +		return 0;
> > +	mes->cxlds = cxlds;
> > +
> > +	if (xa_insert(&mock_dev_event_store, (unsigned long)dev, mes,
> > +		      GFP_KERNEL)) {
> > +		dev_err(dev, "Event store not available for %s\n",
> > +			dev_name(dev));
> > +		return 0;
> > +	}
> > +
> > +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> > +	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
> > +
> > +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> > +	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
> > +
> > +	return mes->ev_status;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);
> > +
> > +void cxl_mock_remove_event_logs(struct device *dev)
> > +{
> > +	struct mock_event_store *mes;
> > +
> > +	mes = xa_erase(&mock_dev_event_store, (unsigned long)dev);
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mock_remove_event_logs);
> 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index e2f5445d24ff..333fa8527a07 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> ...
> 
> 
> >  static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_dev_state *cxlds;
> > +	u32 ev_status;
> >  	void *lsa;
> >  	int rc;
> >  
> > @@ -281,11 +304,13 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		return rc;
> >  
> > +	ev_status = cxl_mock_add_event_logs(cxlds);
> For below comment, add a devm_add_action_or_reset() here to
> undo this.  If nothing else, without one you should have error
> handling...
> 
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > -	cxl_mem_get_event_records(cxlds);
> > +	__cxl_mem_get_event_records(cxlds, ev_status);
> >  
> >  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
> >  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
> > @@ -293,6 +318,12 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static int cxl_mock_mem_remove(struct platform_device *pdev)
> > +{
> > +	cxl_mock_remove_event_logs(&pdev->dev);
> 
> Given you have a bunch of devm above, probably better to just use
> a devm_add_action_or_reset() to clean this up.
> Saves on introducing remove for just this one call + any potential
> ordering issues (I'm too lazy to check if there are any ;)
> 
> 
> > +	return 0;
> > +}
> > +
> >  static const struct platform_device_id cxl_mock_mem_ids[] = {
> >  	{ .name = "cxl_mem", },
> >  	{ },
> > @@ -301,9 +332,11 @@ MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
> >  
> >  static struct platform_driver cxl_mock_mem_driver = {
> >  	.probe = cxl_mock_mem_probe,
> > +	.remove = cxl_mock_mem_remove,
> >  	.id_table = cxl_mock_mem_ids,
> >  	.driver = {
> >  		.name = KBUILD_MODNAME,
> > +		.dev_groups = cxl_mock_event_groups,
> >  	},
> >  };
> >  
> 
