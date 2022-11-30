Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6063D16F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiK3JMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiK3JM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:12:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8394A5A2;
        Wed, 30 Nov 2022 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669799546; x=1701335546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+ZTieIoNB1dXqbD29F7uDirjuVQ4lDSoZvubc9kel+M=;
  b=nB2HNGnfyd4JYoVO4JqDsRI5aWgLKTRO1wg12RZhOhdIDwgVEjZ2O6f1
   DBeGjVkgzbWXqCp653Mn5YlzC1XMtH1G5pR8ZgrNKKPPneDWi4Cv+VAW7
   6Jpdr7N0+7E9rLW1yJ4K/czJ7p/qsU8UDZrR/TB8uC9URjO+Iqijt3ziw
   zCGjLpRqY54R7oZmfoyluckKMCnzWkkCXHj6rY6J2Dnl+Ix/3i1l2+R0d
   NjIB7RKHQz+rFQuKiESK283srl8XuPmFiZAQd3gimDznJ9hmwZuShl63x
   Pjo3LQ5NldKnqDX1TBuyQyDQhulJyAlXVuhzXDx/Px5g3Bd+SCTZQfOjs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="302950830"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="302950830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 01:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="676755062"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="676755062"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2022 01:12:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 01:12:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 01:12:04 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 01:12:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjysQnpYsoHmYeSGpffGupoVAwNQPjooU/+wNtWWcqVFAnYKX2pzNg0ULo4eYXpnxLkeZ4R6+mgHJ85hZ5VJB1hgme6/9UKvvO8S2EpDTlbadvWdHmoB+i7j1VBS6JZlXNfuumkIMZvKBLEdMwrAGg6Pm6QwROqg6+X06k+Fb9zDtxJmp+HAN4m5Lwh2v88DredD6gqzk9lf1BxVCqsCZ3dxDGAxjpn77XV5JqGcHT12Wyhwxw7lGNzkkxa4meH9LiKtCXga9EsYHloEK3okNUmkOlc71WSYz5wSe2InvxCgGc+yPhyqk7UuQ8lQEkFHTugo4nVtxIos5ZiWVljj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbUu/vRjy4oRLjQzOUaUJvKePkaf5aIYxUnuP+uNINs=;
 b=NAf55O/I4vhFc/rxh6seRzJYJR1n9U165SQ3oebH92xDwgYS+cZS6yiBr+O9asJ+LW889h9OceN2RX9cKs43/TC66T1JCMF9VIG6K+AVcDoWTil6dDoIe4AnPhyZx4dM/0CEdacWG69jexKRx7nUePk+NqRKeb3Pmu3QUtaOuy5o1AkUVoK86aARW6JJnSjoX43aujAaq6CnkmhryaYpxXWqnCls2HNp2w1agj1Dn717UsUVnFwVRZpjHryT1NpPKtw/4mNMNzDXtSVrQwv3cxoDW3J4QjPtwxSe8RfhE0lRp7xjZhOg4+rEaK0XOHtDoYnxV9VyPb1+2dG0kix72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 09:12:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 09:12:02 +0000
Date:   Wed, 30 Nov 2022 01:11:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 08/11] cxl/mem: Wire up event interrupts
Message-ID: <Y4ceXGYg8MXzZCwP@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-9-ira.weiny@intel.com>
 <20221116144021.00007a7c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116144021.00007a7c@Huawei.com>
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 964bf769-d9f1-40bf-5967-08dad2b2f05f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AC68X6Dzo5+8dUojVZpiAI4Je29xae2+fToATMRNSq/EOn9uP10QKxkPqHYePtG4KwP1MPCosz1tn4cQ0uEDsijCjluLpDw5SA0ijujZvLZJMrMhLqqliPThriPk9s/UMwE2B/y0UQ6s44JbNDXLNUbs5Bqy3PGP7GCnjdi4dyzdYX+E/w7Ub8ZMUMPEZh6V1IGJz87e1NcrTXjy6leZX91nQY8AKpXUePmAYG8GR+0+7uLW93VfvM/OSfxjeHD3VvZQ6igjZQ+5UQ0mjQFkQ2/CJ7gdVVObrX3VwS+qcJ2AxJqgKvSnK2xwgEVtQOHBMbYVjNjDSjqrO5PDkfcrNYhtDNVI/t0OwkRs7bYCE9IuWpG8NXVgQu35hN3YcbmIY6oWzeHFxxHzYpXkF2wZZ+VAFpRhp3tmFH9atReyA3IOXay2PqL4y2sZ3m0Zk2M+ITLIsDuXT4RmNAwED4kfndW6zv5OKVOEC/FKtdGe/Gt0LgMbwbXUQDqb0y2S0MI8JCr6XEO17HoFq1HIVFK401BdJ6p6fqDRbeJbwYcfCXMgHxHxs3mfwCoOfPBwSwrU+mJ17bMBZ+k8s7ODmHes/MsWou8sYFn0ixUt6sowmsnAii25b1viD0Q2X8ChD6TcX7kfOZSA+5foNkwdQZKKaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(5660300002)(44832011)(66476007)(8676002)(4326008)(8936002)(41300700001)(66556008)(66899015)(66946007)(6916009)(6486002)(54906003)(478600001)(316002)(2906002)(6512007)(9686003)(86362001)(6506007)(186003)(33716001)(83380400001)(26005)(6666004)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSRSEq0Rf+JYxuuPmkXNC+Duoj9rSxvR2Y2i81wuST7Ut149C/XzmwudMgIR?=
 =?us-ascii?Q?7J5eoCGaeWkcCsD8XXH8ShKp6Is7SLknspRIzMw0V7EZh2A2lSn37pF6H+A5?=
 =?us-ascii?Q?G+bPSt84GSrAtSdbwfdyYEjVZYbymuIdCk9le5fKpCmU9jn8y03GSefdreMn?=
 =?us-ascii?Q?0m4QoDZMoMdhza6HpOmMxijLCcGSH8KRl/kuUXy9NWT/n4lgouEua7UEPHiB?=
 =?us-ascii?Q?ve3BYztdOGT1955UBV5LRx+wuZJoh6NTECM74Fnfj61mBDx6Qy13Y8FIZ8TU?=
 =?us-ascii?Q?0LxNhqvV5bV8SZwMykRwbUGSgp1/k0H4Mfb4AsFrz7RsGlTcoqy/K2zvuiI3?=
 =?us-ascii?Q?7rJKT5s3L/t42yGX/iDhd4+s0zicw/AJgL9XWJts/WF+xKeUl84jatLoqRf2?=
 =?us-ascii?Q?sGF6PWXCLjF7w/zZwcnRXkakJ1qpVk8Y3M2WCjhlOGLMjUDIZOuKkgDHNRbH?=
 =?us-ascii?Q?X7GEV5gFOTeB7DJpmCMLRNG34l+EcpRS0s/7BmWhQ8tkQDhgPgYUInjtKr4a?=
 =?us-ascii?Q?OVXzYvq7O1z8MXfTV+okS2O9w6hwd3935CMM6zg9bxAiuoo+btlVYZnRFixD?=
 =?us-ascii?Q?QgzYQeROJE488N+lA4ywbY48fWXPe0l0wvNAeZp/zR5IUT1WHUdRsC0GTjwf?=
 =?us-ascii?Q?j8i/8KStuW9USb97lQjXVdNhjltohclnrpD1fN7NFDwzFVmDQqW3afFAHsoA?=
 =?us-ascii?Q?Cz4bZHtQ+PsWo98LRwjxm6aLZpmrU9L64DN7T6YzPiNIJq+ABGWUYkVGGZxY?=
 =?us-ascii?Q?S9AMWiv9eIn9W9SqugFH6qbgSB/Iet/AT2n5WFmrAzVkcOlKmRQ9m20/elP+?=
 =?us-ascii?Q?PjyHPByxsYCvRNqcwNDyK/mUQwCswAtwnOkCYcWhHKJ9M9iZN+mPsbgJVdeW?=
 =?us-ascii?Q?/MpEPpb+8HuEHyvLdGn3UcK1fh2y4w+fN6jkp1UsfGHZDbpWVbQYOQch+NiU?=
 =?us-ascii?Q?eoynRzxvDrjy62Mrlc9TmUPyZYc6ZGcmbEtgdmPNnDv0Mi2ogm41qP6nBxyG?=
 =?us-ascii?Q?UrFililo2xDuCDFjfFRvudHIrkSD87KxlACB8UWuxrCJMs+tlG2nQq4arlcC?=
 =?us-ascii?Q?V+t64rxL6NPz6kzKo5Tt9APMkrikUj/Mss+drviwIsyiIZTChVoJ63afl9yn?=
 =?us-ascii?Q?U4FKqoZLoCPV8ggrTt7vhHFQwWEv/uSzI2uf9soFfMosbgITwBzTxCle/VjG?=
 =?us-ascii?Q?5+F/0s6HN6wOwqR1UmWF7idMTWMdSqGOD9vUcq6Yepl1g2FaJWOXUwK8DuH4?=
 =?us-ascii?Q?zKFGJvfAlAbrzlAKLoBzLSroTf+7yltbH+Z777XDtD0Fh7DDma1c5fb+PEnT?=
 =?us-ascii?Q?dqDlkvBWw5dFxiyRKxGpRSWcKQEZCqa6NNJUq4LMPEO6rA9aUgp5yZoxPQmI?=
 =?us-ascii?Q?UJ8mYma8gOKOCS+8CkQfVbF1Q6nECwnl1nV1/MBzvuyWNujnf2Unh1Z8x4N7?=
 =?us-ascii?Q?hXz+KgpCAAQRI5W+xkg2kbEA3AVNeVC6ZXoEFLxMBBNeAk6oePvoNCMpMD/H?=
 =?us-ascii?Q?NueGh0tdO1v7l7dS1lWl+SsXCFrMNcgJbz0s3TBGUN8Xb02CjB9nup34hvp8?=
 =?us-ascii?Q?RMmjvLWz6hdlH3gPl/p2snsWoGd7RschusCc6VUe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 964bf769-d9f1-40bf-5967-08dad2b2f05f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 09:12:01.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xvR49zziAmReNx5BtkLNlhd+4XI65gHfKnqU2zS/kjoBvmfhGOdIdNqxVh/ckyf+sSRW0VSQj6/QXusKi1aDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
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

On Wed, Nov 16, 2022 at 02:40:21PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:55 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL device events are signaled via interrupts.  Each event log may have
> > a different interrupt message number.  These message numbers are
> > reported in the Get Event Interrupt Policy mailbox command.
> > 
> > Add interrupt support for event logs.  Interrupts are allocated as
> > shared interrupts.  Therefore, all or some event logs can share the same
> > message number.
> > 
> > The driver must deal with the possibility that dynamic capacity is not
> > yet supported by a device it sees.  Fallback and retry without dynamic
> > capacity if the first attempt fails.
> > 
> > Device capacity event logs interrupt as part of the informational event
> > log.  Check the event status to see which log has data.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Hi Ira,
> 
> A few comments inline.

Thanks for the review!

> 
> Thanks,
> 
> Jonathan
> 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 879b228a98a0..1e6762af2a00 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> 
> >  /**
> >   * cxl_mem_get_event_records - Get Event Records from the device
> > @@ -867,6 +870,52 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> >  
> > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_event_interrupt_policy *policy = &cxlds->evt_int_policy;
> > +	size_t policy_size = sizeof(*policy);
> > +	bool retry = true;
> > +	int rc;
> > +
> > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > +	policy->fatal_settings = CXL_INT_MSI_MSIX;
> > +	policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
> > +
> > +again:
> > +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_EVT_INT_POLICY,
> > +			       policy, policy_size, NULL, 0);
> > +	if (rc < 0) {
> > +		/*
> > +		 * If the device does not support dynamic capacity it may fail
> > +		 * the command due to an invalid payload.  Retry without
> > +		 * dynamic capacity.
> > +		 */
> 
> There are a number of ways to discover if DCD is supported that aren't based
> on try and retry like this. 9.13.3 has "basic sequence to utilize Dynamic Capacity"
> That calls out:
> Verify the necessary Dynamic Capacity commands are returned in the CEL.
> 
> First I'm not sure we should set the interrupt on for DCD until we have a lot
> more of the flow handled, secondly even then we should figure out if it is supported
> at a higher level than this command and pass that info down here.

I'm not sure I really agree.  The events are just traced.  I think this
functionality is really orthogonal to if any other support for DCD is there.

Regardless like I said in the call I think deferring this is the right way to
go for now.

> 
> 
> > +		if (retry) {
> > +			retry = false;
> > +			policy->dyn_cap_settings = 0;
> > +			policy_size = sizeof(*policy) - sizeof(policy->dyn_cap_settings);
> > +			goto again;
> > +		}
> > +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> > +			rc);
> > +		memset(policy, CXL_INT_NONE, sizeof(*policy));
> 
> Relying on all the fields being 1 byte is a bit error prone. I'd just set them all
> individually in the interests of more readable code.

Done.

> 
> > +		return rc;
> > +	}
> > +
> > +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVT_INT_POLICY, NULL, 0,
> > +			       policy, policy_size);
> 
> Add a comment on why you are reading this back (to get the msgnums in the upper
> bits) as it's not obvious to a casual reader.

Done.

> 
> > +	if (rc < 0) {
> > +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> > +			rc);
> > +		return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);
> > +
> 
> ...
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index e0d511575b45..64b2e2671043 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -458,6 +458,138 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> >  	cxlds->nr_irq_vecs = nvecs;
> >  }
> >  
> > +struct cxl_event_irq_id {
> > +	struct cxl_dev_state *cxlds;
> > +	u32 status;
> > +	unsigned int msgnum;
> msgnum is only here for freeing the interrupt - I'd rather we fixed
> that by using standard infrastructure (or adding some - see below).
> 
> status is an indirect way of allowing us to share an interrupt handler.
> You could do that by registering a trivial wrapper for each instead.
> Then all you have left is the cxl_dev_state which could be passed
> in directly as the callback parameter removing need to have this
> structure at all.  I think that might be neater.

It does prevent the alloc of this structure which I like.

I've made the change.

> 
> > +};
> > +
> > +static irqreturn_t cxl_event_int_thread(int irq, void *id)
> > +{
> > +	struct cxl_event_irq_id *cxlid = id;
> > +	struct cxl_dev_state *cxlds = cxlid->cxlds;
> > +
> > +	if (cxlid->status & CXLDEV_EVENT_STATUS_INFO)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> > +	if (cxlid->status & CXLDEV_EVENT_STATUS_WARN)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> > +	if (cxlid->status & CXLDEV_EVENT_STATUS_FAIL)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > +	if (cxlid->status & CXLDEV_EVENT_STATUS_FATAL)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> > +	if (cxlid->status & CXLDEV_EVENT_STATUS_DYNAMIC_CAP)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t cxl_event_int_handler(int irq, void *id)
> > +{
> > +	struct cxl_event_irq_id *cxlid = id;
> > +	struct cxl_dev_state *cxlds = cxlid->cxlds;
> > +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > +
> > +	if (cxlid->status & status)
> > +		return IRQ_WAKE_THREAD;
> > +	return IRQ_HANDLED;
> 
> If status not set IRQ_NONE.
> Ah. I see Dave raised this as well.

Yep done.

> 
> > +}
> 
> ...
> 
> > +static int cxl_request_event_irq(struct cxl_dev_state *cxlds,
> > +				 enum cxl_event_log_type log_type,
> > +				 u8 setting)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct cxl_event_irq_id *id;
> > +	unsigned int msgnum = CXL_EVENT_INT_MSGNUM(setting);
> > +	int irq;
> > +
> > +	/* Disabled irq is not an error */
> > +	if (!cxl_evt_int_is_msi(setting) || msgnum > cxlds->nr_irq_vecs) {
> 
> I don't think that second condition can occur.  The language under table 8-52
> (I think) means that it will move around if there aren't enough vectors
> (for MSI - MSI-X is more complex, but result the same).

Based on the other review this is just a bool msi_enabled which is used to
determine if this should be set up at all.

> 
> > +		dev_dbg(dev, "Event interrupt not enabled; %s %u %d\n",
> > +			cxl_event_log_type_str(CXL_EVENT_TYPE_INFO),
> > +			msgnum, cxlds->nr_irq_vecs);
> > +		return 0;
> > +	}
> > +
> > +	id = devm_kzalloc(dev, sizeof(*id), GFP_KERNEL);
> > +	if (!id)
> > +		return -ENOMEM;
> > +
> > +	id->cxlds = cxlds;
> > +	id->msgnum = msgnum;
> > +	id->status = log_type_to_status(log_type);
> > +
> > +	irq = pci_request_irq(pdev, id->msgnum, cxl_event_int_handler,
> > +			      cxl_event_int_thread, id,
> > +			      "%s:event-log-%s", dev_name(dev),
> > +			      cxl_event_log_type_str(log_type));
> > +	if (irq)
> > +		return irq;
> > +
> > +	devm_add_action_or_reset(dev, cxl_free_event_irq, id);
> 
> Hmm. no pcim_request_irq()  maybe this is the time to propose one
> (separate from this patch so we don't get delayed by that!)

Perhaps.  But not tonight...  ;-)

> 
> We discussed this way back in DOE series (I'd forgotten but lore found
> it for me).  There I suggested just calling
> devm_request_threaded_irq() directly as a work around.

Yea that works fine.  One issue is we lose the format printing of the irq name:

...
 29:  ...  PCI-MSI 100663300-edge      0000:c0:00.0:event-log-Fatal
 30:  ...  PCI-MSI 100663301-edge      0000:c0:00.0:event-log-Failure
 31:  ...  PCI-MSI 100663302-edge      0000:c0:00.0:event-log-Warning
 32:  ...  PCI-MSI 100663303-edge      0000:c0:00.0:event-log-Informational
...

Thanks,
Ira

> 
> > +	return 0;
> > +}
> > +
> > +static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	u8 setting;
> > +
> > +	if (cxl_event_config_msgnums(cxlds))
> > +		return;
> > +
> > +	/*
> > +	 * Dynamic Capacity shares the info message number
> > +	 * Nothing to be done except check the status bit in the
> > +	 * irq thread.
> > +	 */
> > +	setting = cxlds->evt_int_policy.info_settings;
> > +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_INFO, setting))
> > +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> > +			cxl_event_log_type_str(CXL_EVENT_TYPE_INFO));
> > +
> > +	setting = cxlds->evt_int_policy.warn_settings;
> > +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_WARN, setting))
> > +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> > +			cxl_event_log_type_str(CXL_EVENT_TYPE_WARN));
> > +
> > +	setting = cxlds->evt_int_policy.failure_settings;
> > +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_FAIL, setting))
> > +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> > +			cxl_event_log_type_str(CXL_EVENT_TYPE_FAIL));
> > +
> > +	setting = cxlds->evt_int_policy.fatal_settings;
> > +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_FATAL, setting))
> > +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> > +			cxl_event_log_type_str(CXL_EVENT_TYPE_FATAL));
> > +}
> 
