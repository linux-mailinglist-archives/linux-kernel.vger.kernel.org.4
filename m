Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1D6F0C47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbjD0TGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244607AbjD0TGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:06:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96536268A;
        Thu, 27 Apr 2023 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622394; x=1714158394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uNiJO3ni1HSRRRxelOPT+uq5nW6qxGb3vkEpLqUBZGA=;
  b=bGYwm26guhhJ/gVRU0KYA2TBhLmBZGuqZVRVXdyTYsoRqk1GBXKB6/u6
   lK8AKJAbffjjOI7OQfopJJA9IgelSq47FvddW+nt3W+wk3hkhFSFfz2PK
   U41jg7mtfnDeKKBA3GvoIzSyG1nWfVdG5Fav6e9C4tF6aKZZZlWUcq+WR
   PvdnMHIYSoci26RLLI6WFAJQ57cMyG9otjQEIqVgoj2lJwoXDVL0orFtD
   7bdxYVaFrqNTmC22WE0c+ePKOqz2zZEKXTt3Qua7yDaUqGs9kvhXIImm5
   PjEJhYQC5Vz+aFga+jVPeh8xBi1biRT+B3FY4vX5olF3N+gOXwAoOR9AY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336538180"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336538180"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="818678074"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="818678074"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2023 12:06:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 12:06:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 12:06:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 12:06:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGJAO02qUwe1CjF0d45n9izcBW3CuCeZMuRoRLqjFVx2/mR5TS+M87GDUqbc6SyxLjRsG6dU18Xm0CO+0CPxOaPRBTRYYR0WW6BPPB1QB8gsKm16/NmGkzasLT6wKTc/tctPCrSToALty86AuBV4Zm8draHf+OEW+rEVUGI4lQ5NyIQVzFuR4zbzM2zY3qX4gPO/FRmhtQ5KNfzItbtVSgdQwN+owamBwriPQTs40uhCF5KevMSEcylJQ5/eSjQ09sBBdtdr2fkMDTXxYiQnwLL+nyeMG7dmAC4t2ZV4J1mWCr5WXjFb5/Ta0R79JDcXPqGCiCq3vM/9q+f0nYGIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyI/7EWzaD/KMifXZEGWJvTvtKr0Ff4uC5ljUQUCVjg=;
 b=fmJKJEc8PFJKW+hULIkmIcQjkmJLP5w2fMhy6gq+HrWIPue5UmDg+qMB6KBQm42WF0DH/0xOMNIL+PoM8aOtVyPKKiNRra5QpOZ9f+nAa50zX2Ei5fWQICUUI6cVFL0ZL5UpQ3jLVibqszciIN0u6t4jLP7epXfhVolhxCGBagcNVUH3Bs/r2rTLFEzUWPCUNwPxtNMH0aZ27abz9YfBcaQZsMPS7qI3GUNvrEDxAFagaPxOxRgwzAkUvvkymKUmPU4p0Em60YRibV0ORI9VDQtSQB4wxF/YgvTn9mTIk/I0rE9AY/kC/rAe5zZRTPorsYJvfuhdNR87iHd3lkKbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 19:06:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 19:06:31 +0000
Date:   Thu, 27 Apr 2023 12:06:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Raghu H <raghuhack78@gmail.com>, <linux-cxl@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [STYLE v1 2/3] cxl/core/port: Use tabs to fix styling errors
Message-ID: <644ac7b3e5354_182a929456@iweiny-mobl.notmuch>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
 <20230419111443.231151-3-raghuhack78@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230419111443.231151-3-raghuhack78@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f36db5-dce3-48fc-278c-08db475282c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Os8Z+J60vd6wVSVNtSjznO2Ovnr/AHmjXacYbov6YJkB3SoWxbkmKbdLvxyNQpzWomBjn3oTlYj+WjR0tuua4eRGRlKJY4A54vSdn1Dk5/y1CXRWyTGRTVNrJAmSB7GyQmqsXPPf0eF6yWXwKUH6b/r46hxQYeUmMGCGBs2nNtTB8ayQWNC9nqw2txYG3ztIfRUYBB33cZc1D8tGW60XUQNBP2fK1Nicmq96QT5lOBFkG5BpZoos103nvjsUxcutIwT+Eny3Mq26j+sE+nshq6kWPaLpxwsfdRZdHEaf+9TLiQul6VURyQBAiNaTjGvUvGFbbsfATniTxqQdXITRUyLbJ0SAVPcIMVBnyjERBivuecYW06bIKSEYqHhWlkL2C9lxU9c9iRvK9ggBTCJM06Tkzau2g3qXh+MoMUAg5yQTn4s5kJvLey+M8fwkR8E/bgytwn8N3z2C344kPN71q2qUQNI+5Pp2DGsivYmHSMWfVL+VFYXXQshZpcKcpbMc2V7x1LFKvOkylS200xdt3+Jc82sRhr+CffJYewoRlqMbCmJsynZmd+LkocBY4RDi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(86362001)(2906002)(6486002)(6666004)(83380400001)(186003)(6512007)(9686003)(6506007)(26005)(44832011)(66476007)(4326008)(110136005)(478600001)(6636002)(66556008)(66946007)(82960400001)(38100700002)(41300700001)(8676002)(5660300002)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vc3X5syuAT/cH8xmW2IA8C3bLbnPycPTazkXL0k82O20jQ4SilWhE5JAx0ZN?=
 =?us-ascii?Q?skY66p33UdGfsTcKsXiMNZpdMVE9WUHBHkp9cUfURQmuXwWMmUWOzP8zTS9Q?=
 =?us-ascii?Q?WNfvhRYEHfY8i9hm015UwkxgWEQeDYLcgIkaVDIUPqgwn6l7gjxpQ8qWYWnS?=
 =?us-ascii?Q?eDogqcFK5qzQ9FuNEo3G3L12U51yb5xYxpyj18Oug1fjW45ao9oB/b7z1Z0m?=
 =?us-ascii?Q?zFU5wyCZH9vW2I3lFsOgOBi6HL284TB6uvomsbqUdXo4L0xZtwqwNRPRr3W1?=
 =?us-ascii?Q?4BwXXMDH5R9Q0R/DBStccF/QmnGto4tmFIvdu3kWBJJpD3icpEowjoI3088y?=
 =?us-ascii?Q?gnPa0kDn3iKXaKs3GeReBFwlY4kYN5IRljW3mUFsZAf+zcwqOUvKk+hyzoBa?=
 =?us-ascii?Q?oT+xNUBrLfJLTuDtNYRl7zMiGNiBXD1NbyltmyqWrxrF4dBfzRcs2vm/Ju50?=
 =?us-ascii?Q?bHmnXRtTDyMavNI4Aym0c7nBytSE7Tcmd6Sj+68NReqMri+RTPoAPTRuFFSy?=
 =?us-ascii?Q?iPjWRJe/KewjtIuNAfTDuPcUO1P8OBStvkoNfa7JtSTkTTXrslsdQpnKXOI0?=
 =?us-ascii?Q?YzRk/hGJEnjgvhi8EQftVEgV2JB/cN0nBfwfmm9V4irJlAbxHBb6ptOtgIBZ?=
 =?us-ascii?Q?pZsVXRtW5jkmvQ0NBIPs3E//t+v4BPYsH7toGWoovcbgLxlDMcoThVucDtYl?=
 =?us-ascii?Q?5DoV4NxhsPQcSCh367UT5tw3Ghji0uHpAY2KxgawoG6GYndJ53zyvJ4f5S8Z?=
 =?us-ascii?Q?swh6RZeDu2xxHgozq/4bbwbggE1cDsHFS7pVQ8xx7kzvsLM3OsPeNiCB7XrF?=
 =?us-ascii?Q?ox3DFb00sSeoYPYPFI3A2i1VHv56lobNJsjizXoxyoTL7M4n/o5A0SITk5Qu?=
 =?us-ascii?Q?AclfFQ/egKlBOMx8o8QZS3GfwtoZqWNd74A0bijjcS58nS0n5ttRkN916MOh?=
 =?us-ascii?Q?RHY07i9QjYrtBDPQPDoChIomnu9lsBqOr1fXAZp8nc40h8tys6m0kAu5PI8i?=
 =?us-ascii?Q?Pcv3PG+I18+LqV8pk90DX1Nsrals3zfpsSchwoWZ5IypzpmboHNVb6AyXQ5P?=
 =?us-ascii?Q?7C3q6F/pIpTN47zZiADSogElXCFFajV9y0rke4jPBJtVq1K7AhUMlP30yV0P?=
 =?us-ascii?Q?2uEdJsumxz8LGsX/Yp0Wf5eKCksiwMpis1UHZqUT+iQuOaHy+C+hoHSugcY8?=
 =?us-ascii?Q?LEkrDFrgCV+/lxLGH8QmPFFFpCKnL6JfLmvI6n5w2fQ7WmawROsy8toI7J8F?=
 =?us-ascii?Q?+IWvoajk08SJaORDNGgLpKCKNEuXclbfrifSPeQGvcKV6os3BN2HoEcxssTn?=
 =?us-ascii?Q?pma0j/8ZaZ3X4XgERISACTYibW4qZzcr3XmVqOwT6Zbo4IF5lNTuc4Y9Oty2?=
 =?us-ascii?Q?v3ambMXflbwYorQ7Q7yBxt8sGj8ti++tnoqGCqUcTozbjIWgaZQ1symmdcLs?=
 =?us-ascii?Q?DjLXEULfGdS1bqPtZ6IRe7+6hSl1OX9DOomBMNEvDE2Q4PZV+5DgNZW03/PD?=
 =?us-ascii?Q?VzJTTiswyNzltkHvBJtaz3xJP7b4a16phhX0TpfQLgiMNTVWSSFGIVL/oqbf?=
 =?us-ascii?Q?B98amPUy+UWN9Vkd/Qco06ZGmZWA3wRfRsYQqIZg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f36db5-dce3-48fc-278c-08db475282c6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 19:06:31.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi8xeK2KY1z13GipLB4LdSn/gb76k7lK3ly8/DElAMSDpbm/j1WKZoWQDBfzRMfVlFnO+/e0LbBPK364175+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5394
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raghu H wrote:
> Styling errors due to linux of unwanted spaces in the definition,
> modified the definition to use tab to fix the styling issue.
> 
> Signed-off-by: Raghu H <raghuhack78@gmail.com>

NAK

This is unnecessary churn.  The formatting of the file is fine and very
readable.

Ira

> ---
>  drivers/cxl/core/port.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8ee6b6e2e2a4..7c3aaed180ca 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -95,15 +95,15 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(size);
>  
> -#define CXL_DECODER_FLAG_ATTR(name, flag)                            \
> -static ssize_t name##_show(struct device *dev,                       \
> -			   struct device_attribute *attr, char *buf) \
> -{                                                                    \
> -	struct cxl_decoder *cxld = to_cxl_decoder(dev);              \
> -                                                                     \
> -	return sysfs_emit(buf, "%s\n",                               \
> -			  (cxld->flags & (flag)) ? "1" : "0");       \
> -}                                                                    \
> +#define CXL_DECODER_FLAG_ATTR(name, flag)				\
> +static ssize_t name##_show(struct device *dev,				\
> +			   struct device_attribute *attr, char *buf)	\
> +{									\
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);			\
> +									\
> +	return sysfs_emit(buf, "%s\n",					\
> +			  (cxld->flags & (flag)) ? "1" : "0");		\
> +}									\
>  static DEVICE_ATTR_RO(name)
>  
>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
> -- 
> 2.39.2
> 


