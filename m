Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3F62D0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiKQBjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKQBjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:39:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952A2529C;
        Wed, 16 Nov 2022 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668649140; x=1700185140;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mBr9AyEilq8ozljIrf2CwGAXerqXpeOljlikBtZ87Oo=;
  b=cLxC+Mz3ji0VRyp72/644WxOZ5z4zQTzKf0Skem7ZX7K1taoLcRRr0o5
   dxGHHF5dSsZFTBQU4wXdRqDainE3fxpiEdu5QkIZ9lkbA/fYO79mLeHu2
   CkqLLUiXfCCUfniCWky9+H+vn2iDhjvIv5pnd9g2xoGVzYGiD1i2kZk/i
   dtGa06tDE+G/I6ak6kaC1X2S1AjZWU7ZM9EwBivvpfEc1a50QBJPWiD0H
   EkhF+ylfNm9mQZSKk1rnN8kn+oZecbjRS7L8I3Kn2wvrYBlbQpVEqX7y+
   d2zXdvfnzyoWHNgHEs+jpcDxltU6w/AwDqoe4PlNyH1494mDVg+II3pwd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="312736978"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="312736978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:39:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670722951"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670722951"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 17:39:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:38:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:38:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:38:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za/MJAik+XkBRwMfAfaVpl6LgRmhEP0WoVSpxHhSyup2QZYBo/LC9mQhUX/ice2SP/wvjrWXW3yx/6luLBvh/A1eGs2w2v3KGWjYg696SXltbNA+IM29nxkU77gOzR7kIH8dxQaBA6g9neg6okg2/frIZg74keYG1ZLcF4eV/XRfB35BBiR3AsPSlGFLmw85LJ4JUpcjAwtBZRljeeVXFUIPFXV7FqOwORbZ8jjlTIjwkrnRo8tfusvIyiniKBISVUhbigBy5VRqYIJSflDWs4A4qN70ImqoXLLZBtYgyILnifBq8YqQStcuK2WgvcNSgHRLOF3lSQBVOATYWzGjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bsd0BWhg0Qpd1IbK1KT+o0cstiDPggT59trzr0HRj4=;
 b=b01gCyUwmUCAzSzM2rpOQnD7Zc8WOYjFrmsg904eSpaFkmDh8/yDLqEOjbTqxjL1R3iKTEZXxai5c3hPkPJvMNqrxu99DwLJS3rNIpkgCuJaACrW7PQRpUVRI01EaKOaRU8BbQEflns7RiHPEr5WiXRMtKl6tquZ8ju5k+5zsLqi05I1APZtUzmIZ3TkOPSTSMcIkUHaTuAXVa0kDtQ/uUE3jut4RDYZJnrjB3ygUeC9ehBnyEknnGvR7GS+evVLDar0N6dKAa6R7v3ZXqYSneMWcLPD6yUa/3tH0zkQ8bLoJzX62WAHvl//xovofKX8TQpA5TGuiKAa7O+l6yq8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 01:38:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:38:54 +0000
Date:   Wed, 16 Nov 2022 17:38:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 08/11] cxl/mem: Wire up event interrupts
Message-ID: <Y3WQqT+UXrR5FY/k@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-9-ira.weiny@intel.com>
 <8f41c3d3-d814-02a8-2e38-adf599f4ce6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f41c3d3-d814-02a8-2e38-adf599f4ce6c@intel.com>
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b67debe-0811-45c7-f34c-08dac83c7c38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nogmVOcHTc0gv9NmMoaIAoSJqWF56nPBJpmiN6LLydhv3fzG8EUJCr3gyStZfenvwT93CJhSD8jq2pfEz8R8HOo/juERgu7oWToIpHqhgGRbPe1LcDQnxFytKrAE8aFdC95HVZzeBKjS9R+4UgLASp+lo7iS3oEYJw0CQ1g7mES9XWCvbY5kmVLACUkm7jItuKK98Ci8gou1+cPrHTvvi3IeS0mh/nHfGIAexhnzXpkdYf20GZqcHlGxd1LEcB3QDXXGmmUfu9+OSgnIyU//uHbuWXVhE3+XBpyswyIin5wTD1pa/rCwCuCEEOMXjJuZ4O9IqRI966WMi95MsehSWuy5bFYXqvuT7Q3js6fshHUUnBuU99AFOsQ9NYZ/NFbRwZah8vZOUxg2PmeJQ0iLv69rfy/FCr9LgVKxvFYOGV/V7lTF6zD5nt0ecPK4RBAHHcVYSLG2aUwdGau0a3UiFwV/cmMY8NILUoZIP9JtG7fPq6CCEmH4jfyo/ZZl8Mr71bMIjFOjRQhjbv1JE2/sF5UZodDRowP1EDrgzNx695GeH/Z7Llwtb9neJurf7ip+Cd4WQ0Ki/RSrFIBJMvDm9el+RIU2/TDk95bGGb2N+GvVtr+cAUJ6Q6F2sGbCa48liGbfSqjL9U9Bln1ZI9M4XriN+VT3pJmJQ13UO96HDFQ5AfPMjUmljw6W1pjp3uYtk8NZ6XuGUcBk6XFxoBm6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(66476007)(4326008)(83380400001)(66946007)(86362001)(8676002)(66556008)(5660300002)(44832011)(8936002)(6862004)(41300700001)(38100700002)(82960400001)(9686003)(26005)(186003)(478600001)(53546011)(6506007)(6486002)(6512007)(316002)(6666004)(54906003)(6636002)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLglX0JeKoet2ZP0d9s8c84e4l39WqH946z778pxk7UVLCHEe8mTUg/V1p+M?=
 =?us-ascii?Q?LrzHZYLyOcCBbFKNlKuXC3mqHY05IF6talvFK4yp7TP8xvupNNvlvo1CPg94?=
 =?us-ascii?Q?w+MZcz3HV/DM3D1ufKlajCoB24Uthbur1HNVlul+ZfbbtnhtqZru+VcAXhda?=
 =?us-ascii?Q?IF2scvs07oEz/YmLOWoZl9hJVPlQT6iu4gAWfmA1r+VIL0UvuyhHviD1lhUW?=
 =?us-ascii?Q?aHEgjUJarKyOZ/1SJy5H4q+jjcllyJH/m18pX5XCdvLVQKuxF087pI6kbf6u?=
 =?us-ascii?Q?9gYTPBQgLrBuy97x4TKIp+2ouZOY2oh027MWjfc9H4WnPBClpqjIwXBvIy7S?=
 =?us-ascii?Q?6D0nmAZga3z2pOctbKHl5V7THNUCZltSs5Ndqxy7onuQBglhuLiUzSe5tTvj?=
 =?us-ascii?Q?lvIo5Cn5whK+fMXl6lWDRAuj7dsGUHpxxyjFW4XzFAtBdmmtE94s/YQ4dgk0?=
 =?us-ascii?Q?NoBMbHIupMTkzSfDHPzGmoSNHR7TANF5hib5R+XwvOF3RNtPmp9BmOt8Tr9N?=
 =?us-ascii?Q?n02nsc5DZ+5B0p06ahW8aagqa0gL0jH83fSXLJWAsYep9Pa93KH/IFG+HspO?=
 =?us-ascii?Q?364P0qmKiLpQ8TGF5P7Fuyn0DByFdsH/keHrE9AQMJxW4BnAqUSlU0G2LU9o?=
 =?us-ascii?Q?Gek79X7Myjehge9x01Ew+C+mg1YqO9iM1AgfmfXM/JwejWUQpbIaAD0zhAhN?=
 =?us-ascii?Q?gOuhX+GItvjzGMHWDd/FG1R5rhMDjwIBmZaCS0/AKJyWieF5JxlwRdRtXgMb?=
 =?us-ascii?Q?t97E14trphi5XxBpJj9zh/LPATmjLRfq6GbNM/yZXbzcF7hJQcAEussl8MN/?=
 =?us-ascii?Q?/W0PuOaO6PR1qqtTX/doPMr4CfsHkwByrYsxNegkC0A3cKM7R9b0UNXHMxYO?=
 =?us-ascii?Q?aUnlo3NZYyl/bELAAZTBKONj9QRd6bQcPXrR4SENc4dtoST7BCL8znfjSmAZ?=
 =?us-ascii?Q?Mf1UPGSUNzyT9CMzGToLO8ML/oiPDwBIiHcCS6U738eqaO2Y8P2YGs95RFs0?=
 =?us-ascii?Q?oSMI/V15M9KSlNj+yLrAnipnAE46j4JbdUwE10OWKbmkt3MOCvEMB2Is/qZ1?=
 =?us-ascii?Q?kQuW2UXbI04C4Qd9PXlY0DPU0xTkit3oA3T0hyBmkZ5ww5YNfYN0rCkms+o7?=
 =?us-ascii?Q?EUk+PBfy2Mc7JSBe1thipEH8QzxfBPYDAUvB7uW1IoNO5XccYwyLns4iKPtH?=
 =?us-ascii?Q?WGdGlbm9MYJTKUdru0NtQVNH3Vyd2iW1lFyg52EyCANleFr/hJpYuemWwkdU?=
 =?us-ascii?Q?I6R5NN27UgVuFtAwHphJIeZL01vRCv+bwjngCjRYKTDJ7iP4BYHltsN6UoN1?=
 =?us-ascii?Q?vsWnDsUQxNDJckAdi4TU1zjMbST5AumFMhLR00z8CQx10gFYcSbl7z8TQaEe?=
 =?us-ascii?Q?HZNcr/NTgP62oSE9HLw8bWCSAA4n5naqskunQO0e4Zomd3BnbwKmhuXH964C?=
 =?us-ascii?Q?nDSAi+138aem4LKGarfOW12rGJ7I2Ype49eKKmY5DGpULoDdcKAbDtHlXrbM?=
 =?us-ascii?Q?DXL1Dl0xkgcdmiklDJn17sPpiwdeIzKinLygsGujg4eqvS74bsvNELhDD9ys?=
 =?us-ascii?Q?DSKQ23z8DUgRtNXspkysLP69yGmP5sF++iQG66Wt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b67debe-0811-45c7-f34c-08dac83c7c38
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:38:54.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+x0MfFxwk2/aEQtZMrMBCNpQbshK231FCU79q6hxtWsIeXV19raSzp+5/OK5bJbiKlyM/uxgrZ06tZKOwnpZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:13:24PM -0700, Jiang, Dave wrote:
> 
> 
> On 11/10/2022 10:57 AM, ira.weiny@intel.com wrote:

[snip]

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
> > +		if (retry) {
> > +			retry = false;
> > +			policy->dyn_cap_settings = 0;
> > +			policy_size = sizeof(*policy) - sizeof(policy->dyn_cap_settings);
> > +			goto again;
> > +		}
> > +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> > +			rc);
> > +		memset(policy, CXL_INT_NONE, sizeof(*policy));
> > +		return rc;
> > +	}
> 
> Up to you, but I think you can avoid the goto:

I think this is a bit more confusing because we are not really retrying 2
times.

> 
> 	int retry = 2;
> 	do {
> 		rc = cxl_mbox_send_cmd(...);
> 		if (rc == 0 || retry == 1)

Specifically this looks confusing to me.  Why break on retry == 1?

> 			break;
> 		policy->dyn_cap_settings = 0;
> 		policy_size = sizeof(*policy) - sizeof(policy->dyn_cap_settings);
> 		retry--;
> 	} while (retry);
> 
> 	if (rc < 0) {
> 		dev_err(...);
> 		memset(policy, ...);
> 		return rc;
> 	}

That said perhaps the retry should be based on policy_size...  :-/  I'm not
sure that adds much.  I'm going to leave it as is.

[snip]

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
> IRQ_NONE since your handler did not handle anything and this is a shared
> interrupt?

Yes.  Good catch thanks!

> 
> > +}
> > +
> > +static void cxl_free_event_irq(void *id)
> > +{
> > +	struct cxl_event_irq_id *cxlid = id;
> > +	struct pci_dev *pdev = to_pci_dev(cxlid->cxlds->dev);
> > +
> > +	pci_free_irq(pdev, cxlid->msgnum, id);
> > +}
> > +
> > +static u32 log_type_to_status(enum cxl_event_log_type log_type)
> > +{
> > +	switch (log_type) {
> > +	case CXL_EVENT_TYPE_INFO:
> > +		return CXLDEV_EVENT_STATUS_INFO | CXLDEV_EVENT_STATUS_DYNAMIC_CAP;
> > +	case CXL_EVENT_TYPE_WARN:
> > +		return CXLDEV_EVENT_STATUS_WARN;
> > +	case CXL_EVENT_TYPE_FAIL:
> > +		return CXLDEV_EVENT_STATUS_FAIL;
> > +	case CXL_EVENT_TYPE_FATAL:
> > +		return CXLDEV_EVENT_STATUS_FATAL;
> > +	default:
> > +		break;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int cxl_request_event_irq(struct cxl_dev_state *cxlds,
> > +				 enum cxl_event_log_type log_type,
> > +				 u8 setting)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct cxl_event_irq_id *id;
> > +	unsigned int msgnum = CXL_EVENT_INT_MSGNUM(setting);
> > +	int irq;
> 
> int rc? pci_request_irq() returns an errno or 0, not the number of irq. The
> variable naming is a bit confusing.

Indeed.  Changed, and thanks,
Ira

> 
> DJ
> 
