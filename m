Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7DD63F6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiLARxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLARxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:53:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0DB7DE7;
        Thu,  1 Dec 2022 09:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669917001; x=1701453001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oi0zP2NemjSQEOUh/vxvoOdPwCu+00KKWfQ9uMDYljI=;
  b=RmcT+ylumpdAYrtJmP0tI12GO/INmKHlX0Olv9pBCAxu+E+Ro3wwuSi4
   2vXucEnrvv3LJDwFHTsixJRAx8txsIetN7ZWp+7I4ZW4alMuarhTnFTer
   RW10SceeluRXT2RjiUQv5rq5uN9A8rkE22kpxUJfroAImLD5M3pjj2wBq
   +EFxxzOWxR7v67pBm0AYb+BUBgNknLQdyHximeru03IIlXnpewOJ278ZA
   xftwhpHgkVKZgC8Lu+qfa3Uj7OwwA2foQyrF/TOCp+EAb7uiI5uKQHnS7
   aFQf7Vq98x3m/9/bWM1SIbyEcORBc+H0QldEZ+Mg/PxLNbX6tcF17xVTt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303355621"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="303355621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="708164314"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="708164314"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 01 Dec 2022 09:49:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 09:49:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 09:49:58 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 09:49:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA/M24z3zuKeddJt6t16BJZvQ2BFQBvdejjxh27QLcxwNQX9OYj9EsbrWt+iRp/lgPU8lEJOkZ14BIFUfgIEf2PE9GKO4CFEobW/XWr1xATKc3fm/AVbRlSBR+PfT2Ru5+gsRcuEDcPhezVryS9IS6aM8niZaeC/uakoQxCiAY0plN+BwIZqzv+oz+yxGLLyb4y8FfsMG733GdnwlyYju8AOAaGgkXA1uZTlqame4achO4grgYSEfHNntSq5GdLTlz+LixcemyrYDrhZG2/e/uHLrotq5MqBTKxatNb3YUampuV3ouOyz3H7WmKvJm5Yt96n15jKaFYLpu1s4+IcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaKmkMqIBcX2dspMmOAps/XFo47Y57aE2WRRC60zLIU=;
 b=cBK+vCbDPj2wq+k2gnbNOIJXOEOC8KVBRuK9aPDA49kcnStAoiNR8GPzm4r9KUsHOlaNOew7lEvhxMGQRD9RZB5nSXvJCDPTMojxau2dw5eCpLPKd4rcVD99m/6ibRI5n28mnldq6LtKO4CbCIZ4cmnmlPrPjDSMIhHx1xMXBOLFdyo7C7MHnE5vEZsesK4iBtb84uhsgyKpcb0BgV6o+fgCCh+BiH8xwTczQTB+4+L/Pa9Ac0UiQYu5N1l1REhFpX14gh0lUImmYXDT4xFHI2P0ePx44Fnjs7IhVZHAs9S6BilOODdRwfD9kWW20NufOAtLAwUf+5O0IwebWRlsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 17:49:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 17:49:54 +0000
Date:   Thu, 1 Dec 2022 09:49:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 09/11] cxl/test: Add generic mock events
Message-ID: <Y4jpPVSX9/89x3PH@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-10-ira.weiny@intel.com>
 <20221201143727.0000255c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201143727.0000255c@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c4edf2-14f1-4eef-d794-08dad3c47411
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+FFnas6cLfNKKRSiHLuRch0M+LB9ZHl5I4dx+IFa3nw4BsEybHF4434aFASotUH3CYVDVyr8wm/h3KaH9enyOQHTCg/xYQUBM8UhJVhKSNw3XyCRxW7MBTNofT1vITQdZ1XHRWSY97vzJvbfFTUhAobH8TFIoei2oQ7rUbsg+73Q187cOWSQQTFVcUSANvjF34KuD6XmcfOVOy6KeeD7uO/JlNWYIRJ7ssQVOuzqIc83cY3LgvjmQYs/7xzvtQgKO8YwzwPD26MaxyG1ikybfCuRmBPEh+1tQOm5z2qQrZSqmJvUmLDTFOOrCnF0sqwcRv0NRT4qfmCmwPu3oQ4cV5DQcT4GuR5q4TjyQsT+ezJMCl+9oL44YBmmV3UeoSCC8Dyk/HoXWOJ+6UJn5lZx5k8pvLAss4Aj6kzlOmcn4iCSpLasdLJ12vQBoru8FAk8ZDXWZYzq9siTsn9qcp1P8hQgcv/FaWNFX9RGXZe0h3Yi35oV4aw3lPBkNowuFxioKDjDoAc7colEu17/8wrC985sQXYFElXmTvRsb7H9dklfBQ6+jsuZ1hFnZ1v2mHhNvMuwY4yvkP3x+Ho4JllDSf56l2CNskqjjE7xVc5jLKHJ7PJnRPzQmtkOFRfjd/7UgNackVaqjp/nwwBwZRSWEKAiBYoGpbvYUKwTPLXbJ9daWGg66VI2Y2aeWbY1jGa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(2906002)(6486002)(41300700001)(33716001)(186003)(478600001)(6506007)(26005)(86362001)(82960400001)(66899015)(38100700002)(8676002)(6666004)(54906003)(8936002)(44832011)(6916009)(9686003)(316002)(6512007)(5660300002)(66476007)(4326008)(66556008)(66946007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d48XdMK/9RVJSSlbsElqBHQdBYVP9dZjkf1H6r/jdCrhmO+4bXzNOwhcDZsg?=
 =?us-ascii?Q?TjBpC10Tq3YMhhKIMG8o89dNRgKwJSbgxG3ViW7Jueb2yRBUi35uyiUqPJv1?=
 =?us-ascii?Q?PSpay+g19ajSqp4wAYecxTau1gTE/QJ/TxYfxkNALeJJyO0BHSr8g5to0Vqo?=
 =?us-ascii?Q?dX2B1UbEN0RmS7xzFj5lKngzlUzt/Ua7nnRamCA77v3b7GmpfsmxejwzdTqm?=
 =?us-ascii?Q?488CblNbIAXTk+6ADlaLiqZ8/Zs2Asn56lJRtQWT8SDQUMtQEZtBnVPQ3kPm?=
 =?us-ascii?Q?oLzqGv8HYEwRncUHkMr/ks1hUs/K5c66S3vIrmD+n1ijTXXnYMG0rJTAG06G?=
 =?us-ascii?Q?JsN/26glffvAK6XArV1euQfmx3DjWd9JifXcHMAmLH1MbJiN/k4yxHICV69Z?=
 =?us-ascii?Q?N28prFkOACZuvVnfuhXEbhY9r1p//0HDu3hNO401fwRmAkzvghtRGJ/6kFf0?=
 =?us-ascii?Q?2ukj/wmUf/54MO5G7VpbuHQAfGfmvGI9COF23ZJomxD8W4mSJyA8Kk6m7/jP?=
 =?us-ascii?Q?kK7HomqUU8LwbdgamBQPJ6hT0js2qty+b8rlfLFCgZmHLolPzYMRhZ3946dj?=
 =?us-ascii?Q?bxBNS1brPRt0ULa6SrDGbRp3G4Wj1KRscG3j5f8D7wvTbDOx/zKorc4xA0so?=
 =?us-ascii?Q?38hDgdJusOGWGB0qNRZJldWK2gd22AH6OzIWuiYunvYA9mBBx84d4bhVKzeE?=
 =?us-ascii?Q?A16LcDSbTGFHF1ZcK+mYvmzgSD07KoKwh9CnDpd6gw6JQKfC7somIO/GzKIc?=
 =?us-ascii?Q?8ULtJCmKajiZmDm1r+uVaKhwcyaYPohqHw+WGDigHsjksTJDahtVawjBN2Pd?=
 =?us-ascii?Q?lZWjy4vSa7ulFUUKzcfCvoXuf8+jo09m02wt5QD07roNLrom8JwsslJyspyk?=
 =?us-ascii?Q?OThW7bm05hvktkhHj5CaPq+mdaB7KyDlOdGGTNOoC7HngoytcLRvKxqGeP2W?=
 =?us-ascii?Q?itxz3FordzZv8w9HCYS32km27hlOo6q0z+AK6kPpdPm4Cahuf7B39rRxiPeC?=
 =?us-ascii?Q?WcIxfERBN1Fv9KjgLMpgVTKOTSWHXKoLlKJMJqbyxtkoeTLhFGyHkEUCLz+N?=
 =?us-ascii?Q?Eg6GwYyTp8/zvUPWTsVWWmJQk+B8sfPi822XhUKJvyvuD8afoGmFcq5/VWlT?=
 =?us-ascii?Q?6RxIu+ZHhvVIY1te4T3jJFKyyPU5reG9Xdswy+Z6o4TRVlJ60Uvuyk9l8SWp?=
 =?us-ascii?Q?59bzR8IfUZV9M14mx6JlCBI4Sa+O5MpOAeoIFY89rbgS1Whlwvz4CBK3Rhtd?=
 =?us-ascii?Q?+SNDSaWqxa2ZCTafNP1K+yOGRZ4UuBjbO1eocIiFnrDDY4gISNbeQpY4g1aV?=
 =?us-ascii?Q?qmxIamzxsM4T9u4ydcMOXf24JYMe+o+DJIX4C+INyfaamcPZd3nrP2Db4oP+?=
 =?us-ascii?Q?KUJJqQdiTkCV5TNu8aMeqWp9rLunwrNmDUpKYnMnDPPgpf+KUCdeYFoK09f4?=
 =?us-ascii?Q?UA/gNQFBy7xQiiXyHmxEjZqNO6qEYNvhdvF4KXqWw34YPysBLctZkpsZYgfR?=
 =?us-ascii?Q?3u1mXRvxIOrdsucDjqxG2ygecNsRsvZ5io4RADRp/1tlvUIbnmawPTTXCwGu?=
 =?us-ascii?Q?S2wtnomm5+3/nxKv7lPzcvD57Ly94R2h+Ta3kKFv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c4edf2-14f1-4eef-d794-08dad3c47411
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 17:49:54.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE6CDcbkiYOFiMWh1TL2F3uvpam/+BvX4MhtZj+If14sAWRQUZPkMJD+0PBDvqtZeuFTVEyvgBBrhaAAcl3KKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
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

On Thu, Dec 01, 2022 at 02:37:27PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:27:17 -0800
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
> > Events are returned one at a time which is within the specification even
> > though it does not exercise the full capabilities of what a device may
> > do.
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
> > 
> 
> A minor comment on xarray cleanup inline
> 
> Jonathan
> 
> 
> > +void cxl_mock_remove_event_logs(struct device *dev)
> > +{
> > +	struct mock_event_store *mes;
> > +
> > +	mes = xa_erase(&mock_dev_event_store, (unsigned long)dev);
> 
> As below, I'd move this into a devm_add_action_or_reset() so
> that we don't need to deal with doing it manually.

yea

> 
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_mock_remove_event_logs);
> 
> ...
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
> 
> On error later in this function these leak.  Just use devm_add_action_or_reset()
> inside cxl_mock_add_event_logs() so we don't have to care about that.

I see it now.  There is an entry in the xarray which is leaked.

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
> Why not use devm_add_action_or_reset()?

Yea that is a better pattern.

Ira
